const std = @import("std");
const vkh = root.vkh;
const wnd = root.wnd;
const root = @import("root");

pub fn renderBackground(hWnd: ?wnd.HWND, hDc: ?wnd.HDC, hBr: ?wnd.HBRUSH) void {
    var rect: wnd.RECT = undefined;

    _ = wnd.GetClientRect(hWnd, &rect);
    _ = wnd.FillRect(hDc, &rect, hBr);
}

pub fn renderVkApiVersion(hDc: ?wnd.HDC) void {
    var buffer: [128]u8 = undefined;

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
            &buffer,
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

fn renderText(hDc: ?wnd.HDC, text: [:0]const u8) void {
    _ = wnd.TextOutA(hDc, 0, 0, text, @intCast(text.len));
}
