const std = @import("std");
const vkh = root.vkh;
const wnd = root.wnd;
const root = @import("root");
const config = @import("config");
const window = root.window;

pub const spec = @import("spec.zig");

const MainWindow = window.MainWindow;

pub fn App(comptime main_window: *MainWindow) type {
    return struct {
        hBr: ?wnd.HBRUSH,

        pub fn create() @This() {
            return .{
                .hBr = null,
            };
        }

        pub fn getMainWndproc(comptime self: *@This()) wnd.WNDPROC {
            return struct {
                fn wndproc(hWnd: ?wnd.HWND, uMsg: wnd.UINT, wParam: wnd.WPARAM, lParam: wnd.LPARAM) callconv(.winapi) wnd.LRESULT {
                    const opt_msg: ?wnd.WM = if (uMsg < 0x400) @enumFromInt(uMsg) else null;

                    if (opt_msg) |msg| switch (msg) {
                        .DESTROY => if (hWnd == main_window.hWnd) {
                            @branchHint(.unlikely);
                            main_window.notifyInvalid();
                            self.cleanup();
                            wnd.PostQuitMessage(0);
                            return 0;
                        },
                        .PAINT => if (hWnd == main_window.hWnd) {
                            self.render();
                            return 0;
                        },
                        else => if (config.dev_mode) {
                            _ = wnd.MessageBoxA(null, @tagName(msg), "WM", 0);
                        },
                    };

                    return wnd.DefWindowProcW(hWnd, uMsg, wParam, lParam);
                }
            }.wndproc;
        }

        pub fn render(self: *@This()) void {
            var paint: wnd.PAINTSTRUCT = undefined;
            const hDc = wnd.BeginPaint(main_window.hWnd, &paint);
            defer _ = wnd.EndPaint(main_window.hWnd, &paint);

            if (self.hBr == null) {
                self.hBr = wnd.CreateSolidBrush(0x008080FF);
            }

            renderBackground(main_window.hWnd, hDc, self.hBr);

            if (!@import("config").dev_mode) return;

            const vk_version = vkh.getApiVersion() catch return;

            var buffer: [128]u8 = undefined;

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

        fn cleanup(self: *@This()) void {
            if (self.hBr != null) {
                defer self.hBr = null;

                _ = wnd.DeleteObject(self.hBr);
            }
        }
    };
}

fn renderBackground(hWnd: ?wnd.HWND, hDc: ?wnd.HDC, hBr: ?wnd.HBRUSH) void {
    var rect: wnd.RECT = undefined;

    _ = wnd.GetClientRect(hWnd, &rect);
    _ = wnd.FillRect(hDc, &rect, hBr);
}

fn renderText(hDc: ?wnd.HDC, text: [:0]const u8) void {
    _ = wnd.TextOutA(hDc, 0, 0, text, @intCast(text.len));
}
