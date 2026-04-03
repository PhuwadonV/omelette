const std = @import("std");
const vkh = root.vkh;
const wnd = root.wnd;
const root = @import("root");
const window = root.window;
const unicode = std.unicode;

const MainWindow = window.MainWindow;
const FixedBufferAllocator = std.heap.FixedBufferAllocator;

const allocPrint = std.fmt.allocPrint;
const utf8ToUtf16LeAllocZ = unicode.utf8ToUtf16LeAllocZ;
const utf8ToUtf16LeStringLiteral = unicode.utf8ToUtf16LeStringLiteral;

pub fn getMainWndproc(comptime main_window: *MainWindow) wnd.WNDPROC {
    return struct {
        fn wndproc(hWnd: ?wnd.HWND, uMsg: wnd.UINT, wParam: wnd.WPARAM, lParam: wnd.LPARAM) callconv(.winapi) wnd.LRESULT {
            if (uMsg == wnd.WM_DESTROY and hWnd == main_window.hWnd) {
                @branchHint(.unlikely);
                main_window.notifyInvalid();
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
                wnd.WM_GETTEXT => {},
                wnd.WM_PAINT => {
                    render(main_window.hWnd);
                    return 0;
                },
                wnd.WM_CLOSE => {},
                wnd.WM_QUERYOPEN => {},
                wnd.WM_ERASEBKGND => {},
                wnd.WM_SHOWWINDOW => {},
                wnd.WM_ACTIVATEAPP => {},
                wnd.WM_CANCELMODE => {},
                wnd.WM_SETCURSOR => {},
                wnd.WM_MOUSEACTIVATE => {},
                wnd.WM_GETMINMAXINFO => {},
                wnd.WM_WINDOWPOSCHANGING => {},
                wnd.WM_WINDOWPOSCHANGED => {},
                wnd.WM_NOTIFY => {},
                wnd.WM_INPUTLANGCHANGE => {},
                wnd.WM_HELP => {},
                wnd.WM_CONTEXTMENU => {},
                wnd.WM_GETICON => {},
                wnd.WM_NCCREATE => {},
                wnd.WM_NCCALCSIZE => {},
                wnd.WM_NCHITTEST => {},
                wnd.WM_NCPAINT => {},
                wnd.WM_NCACTIVATE => {},
                wnd.WM_GETDLGCODE => {},
                wnd.WM_UAHDESTROYWINDOW => {},
                wnd.WM_GETOBJECT => {},
                wnd.WM_UAHNCACTIVATE => {},
                wnd.WM_NCMOUSEMOVE => {},
                wnd.WM_NCLBUTTONDOWN => {},
                wnd.WM_NCLBUTTONUP => {},
                wnd.WM_NCLBUTTONDBLCLK => {},
                wnd.WM_NCRBUTTONDOWN => {},
                wnd.WM_NCRBUTTONUP => {},
                wnd.WM_NCRBUTTONDBLCLK => {},
                wnd.WM_NCMBUTTONDOWN => {},
                wnd.WM_NCMBUTTONUP => {},
                wnd.WM_NCMBUTTONDBLCLK => {},
                wnd.WM_NCXBUTTONDOWN => {},
                wnd.WM_NCXBUTTONUP => {},
                wnd.WM_NCXBUTTONDBLCLK => {},
                wnd.WM_KEYDOWN => {},
                wnd.WM_KEYUP => {},
                wnd.WM_CHAR => {},
                wnd.WM_SYSKEYDOWN => {},
                wnd.WM_SYSKEYUP => {},
                wnd.WM_SYSCHAR => {},
                wnd.WM_SYSCOMMAND => {},
                wnd.WM_INITMENU => {},
                wnd.WM_INITMENUPOPUP => {},
                wnd.WM_MENUCHAR => {},
                wnd.WM_MENUSELECT => {},
                wnd.WM_ENTERIDLE => {},
                wnd.WM_UNINITMENUPOPUP => {},
                wnd.WM_MOUSEMOVE => {},
                wnd.WM_LBUTTONDOWN => {},
                wnd.WM_LBUTTONUP => {},
                wnd.WM_LBUTTONDBLCLK => {},
                wnd.WM_RBUTTONDOWN => {},
                wnd.WM_RBUTTONUP => {},
                wnd.WM_RBUTTONDBLCLK => {},
                wnd.WM_MBUTTONDOWN => {},
                wnd.WM_MBUTTONUP => {},
                wnd.WM_MBUTTONDBLCLK => {},
                wnd.WM_MOUSEWHEEL => {},
                wnd.WM_XBUTTONDOWN => {},
                wnd.WM_XBUTTONUP => {},
                wnd.WM_XBUTTONDBLCLK => {},
                wnd.WM_ENTERMENULOOP => {},
                wnd.WM_EXITMENULOOP => {},
                wnd.WM_CAPTURECHANGED => {},
                wnd.WM_IME_CHAR => {},
                wnd.WM_ENTERSIZEMOVE => {},
                wnd.WM_EXITSIZEMOVE => {},
                wnd.WM_IME_SETCONTEXT => {},
                wnd.WM_IME_NOTIFY => {},
                wnd.WM_IME_REQUEST => {},
                wnd.WM_NCMOUSELEAVE => {},
                wnd.WM_APPCOMMAND => {},
                wnd.WM_DWMNCRENDERINGCHANGED => {},
                else => showUMsg(uMsg),
            }

            return wnd.DefWindowProcW(hWnd, uMsg, wParam, lParam);
        }
    }.wndproc;
}

fn render(hWnd: ?wnd.HWND) void {
    var paint: wnd.PAINTSTRUCT = undefined;
    const hDc = wnd.BeginPaint(hWnd, &paint);
    defer _ = wnd.EndPaint(hWnd, &paint);

    const hBr = wnd.CreateSolidBrush(0x008080FF);
    defer _ = wnd.DeleteObject(hBr);

    renderBackground(hWnd, hDc, hBr);

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

    const text_u8 = allocPrint(
        allocator,
        format,
        .{
            vk_version.variant,
            vk_version.major,
            vk_version.minor,
            vk_version.patch,
        },
    ) catch return;

    const text_u16 = utf8ToUtf16LeAllocZ(allocator, text_u8) catch return;

    renderText(hDc, text_u16);
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
    var buffer: [64]u8 = undefined;
    var fixed_buffer = FixedBufferAllocator.init(&buffer);
    const allocator = fixed_buffer.allocator();

    const text_u8 = allocPrint(allocator, "{x}", .{uMsg}) catch return;
    const text_u16 = utf8ToUtf16LeAllocZ(allocator, text_u8) catch return;

    _ = wnd.MessageBoxW(null, text_u16, utf8ToUtf16LeStringLiteral("uMsg"), 0);
}
