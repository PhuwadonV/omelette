const std = @import("std");
const vkh = root.vkh;
const wnd = root.wnd;
const root = @import("root");
const config = @import("config");

const App = root.App;
const Renderer = @This();

buffer: [128]u8,

pub fn create() Renderer {
    return .{
        .buffer = undefined,
    };
}

pub fn render(self: *Renderer, app: *App, hWnd: ?wnd.HWND) void {
    var paint: wnd.PAINTSTRUCT = undefined;
    const hDc = wnd.BeginPaint(hWnd, &paint);
    defer _ = wnd.EndPaint(hWnd, &paint);

    renderBackground(hWnd, hDc, app.bg_color);

    if (!config.dev_mode) return;

    const vk_version = vkh.getApiVersion() catch return;

    const format =
        \\Variant = {d}, 
        \\Major = {d}, 
        \\Minor = {d}, 
        \\Patch = {d}
    ;

    renderText(
        hDc,
        std.fmt.bufPrintSentinel(
            &self.buffer,
            format,
            .{
                vk_version.variant,
                vk_version.major,
                vk_version.minor,
                vk_version.patch,
            },
            0,
        ) catch return,
    );
}

fn renderBackground(hWnd: ?wnd.HWND, hDc: ?wnd.HDC, hBr: ?wnd.HBRUSH) void {
    var rect: wnd.RECT = undefined;

    _ = wnd.GetClientRect(hWnd, &rect);
    _ = wnd.FillRect(hDc, &rect, hBr);
}

fn renderText(hDc: ?wnd.HDC, text: [:0]const u8) void {
    _ = wnd.TextOutA(hDc, 0, 0, text, @intCast(text.len));
}
