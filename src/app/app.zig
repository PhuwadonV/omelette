const std = @import("std");
const vkh = root.vkh;
const wnd = root.wnd;
const root = @import("root");
const window = root.window;
const unicode = std.unicode;

pub const spec = @import("spec.zig");

const MainWindow = window.MainWindow;
const FixedBufferAllocator = std.heap.FixedBufferAllocator;

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
                    if (uMsg == wnd.WM_DESTROY and hWnd == main_window.hWnd) {
                        @branchHint(.unlikely);
                        main_window.notifyInvalid();
                        self.cleanup();
                        wnd.PostQuitMessage(0);
                        return 0;
                    }

                    switch (uMsg) {
                        wnd.WM_CREATE => {},
                        wnd.WM_MOVE => {},
                        wnd.WM_SIZE => {},
                        wnd.WM_ACTIVATE => {},
                        wnd.WM_SETFOCUS => {},
                        wnd.WM_KILLFOCUS => {},
                        wnd.WM_PAINT => if (hWnd == main_window.hWnd) {
                            self.render();
                            return 0;
                        },
                        wnd.WM_CLOSE => {},
                        wnd.WM_QUERYENDSESSION => {},
                        wnd.WM_ERASEBKGND => {},
                        wnd.WM_ENDSESSION => {},
                        wnd.WM_SHOWWINDOW => {},
                        wnd.WM_ACTIVATEAPP => {},
                        wnd.WM_TIMECHANGE => {},
                        wnd.WM_SETCURSOR => {},
                        wnd.WM_MOUSEACTIVATE => {},
                        wnd.WM_WINDOWPOSCHANGING => {},
                        wnd.WM_WINDOWPOSCHANGED => {},
                        wnd.WM_NOTIFY => {},
                        wnd.WM_INPUTLANGCHANGE => {},
                        wnd.WM_HELP => {},
                        wnd.WM_CONTEXTMENU => {},
                        wnd.WM_DISPLAYCHANGE => {},
                        wnd.WM_GETICON => {},
                        wnd.WM_NCCREATE => {},
                        wnd.WM_NCDESTROY => {},
                        wnd.WM_NCCALCSIZE => {},
                        wnd.WM_NCHITTEST => {},
                        wnd.WM_NCPAINT => {},
                        wnd.WM_NCACTIVATE => {},
                        wnd.WM_UAHDESTROYWINDOW => {},
                        wnd.WM_INPUT => {},
                        wnd.WM_KEYDOWN => {},
                        wnd.WM_KEYUP => {},
                        wnd.WM_CHAR => {},
                        wnd.WM_SYSKEYDOWN => {},
                        wnd.WM_SYSKEYUP => {},
                        wnd.WM_SYSCHAR => {},
                        wnd.WM_SYSCOMMAND => {},
                        wnd.WM_MOUSEMOVE => {},
                        wnd.WM_LBUTTONDOWN => {},
                        wnd.WM_LBUTTONUP => {},
                        wnd.WM_RBUTTONDOWN => {},
                        wnd.WM_RBUTTONUP => {},
                        wnd.WM_MBUTTONDOWN => {},
                        wnd.WM_MBUTTONUP => {},
                        wnd.WM_MOUSEWHEEL => {},
                        wnd.WM_XBUTTONDOWN => {},
                        wnd.WM_XBUTTONUP => {},
                        wnd.WM_CAPTURECHANGED => {},
                        wnd.WM_MENUDRAG => {},
                        wnd.WM_MENUGETOBJECT => {},
                        wnd.WM_IME_SETCONTEXT => {},
                        wnd.WM_IME_NOTIFY => {},
                        wnd.WM_IME_REQUEST => {},
                        wnd.WM_MOUSELEAVE => {},
                        wnd.WM_DPICHANGED => {},
                        wnd.WM_APPCOMMAND => {},
                        wnd.WM_DWMCOLORIZATIONCOLORCHANGED => {},
                        else => showUMsg(uMsg),
                    }

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

            const vk_version = vkh.getApiVersion() catch return;

            var buffer: [256]u8 = undefined;
            var fixed_buffer = FixedBufferAllocator.init(&buffer);
            const allocator = fixed_buffer.allocator();

            const format =
                \\Variant = {d}, 
                \\Major = {d}, 
                \\Minor = {d}, 
                \\Patch = {d}
            ;

            const text_u8 = std.fmt.allocPrint(
                allocator,
                format,
                .{
                    vk_version.variant,
                    vk_version.major,
                    vk_version.minor,
                    vk_version.patch,
                },
            ) catch return;

            const text_u16 = unicode.utf8ToUtf16LeAllocZ(allocator, text_u8) catch return;

            renderText(hDc, text_u16);
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

fn renderText(hDc: ?wnd.HDC, text: [:0]const u16) void {
    _ = wnd.TextOutW(hDc, 0, 0, text, @intCast(text.len));
}

fn showUMsg(uMsg: wnd.UINT) void {
    var buffer: [256]u8 = undefined;
    var fixed_buffer = FixedBufferAllocator.init(&buffer);
    const allocator = fixed_buffer.allocator();

    const text_u8 = std.fmt.allocPrint(allocator, "{x}", .{uMsg}) catch return;
    const text_u16 = unicode.utf8ToUtf16LeAllocZ(allocator, text_u8) catch return;

    _ = wnd.MessageBoxW(null, text_u16, unicode.utf8ToUtf16LeStringLiteral("uMsg"), 0);
}
