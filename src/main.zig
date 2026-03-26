const std = @import("std");
const wnd = @import("wnd.zig");
const impl = @import("impl/impl.zig");
const unicode = std.unicode;
const windows = std.os.windows;
const kernel32 = windows.kernel32;

const MSG = wnd.MSG;
const HWND = windows.HWND;
const UINT = windows.UINT;
const LPARAM = windows.LPARAM;
const WPARAM = windows.WPARAM;
const LRESULT = windows.LRESULT;
const HINSTANCE = windows.HINSTANCE;
const PAINTSTRUCT = wnd.PAINTSTRUCT;
const FixedBufferAllocator = std.heap.FixedBufferAllocator;

const allocPrint = std.fmt.allocPrint;
const utf8ToUtf16LeAllocZ = unicode.utf8ToUtf16LeAllocZ;
const utf8ToUtf16LeStringLiteral = unicode.utf8ToUtf16LeStringLiteral;

const EndPaint = wnd.EndPaint;
const TextOutW = wnd.TextOutW;
const BeginPaint = wnd.BeginPaint;
const ShowWindow = wnd.ShowWindow;
const ExitProcess = kernel32.ExitProcess;
const PeekMessageW = wnd.PeekMessageW;
const DefWindowProcW = wnd.DefWindowProcW;
const PostQuitMessage = wnd.PostQuitMessage;
const DispatchMessageW = wnd.DispatchMessageW;
const GetModuleHandleW = kernel32.GetModuleHandleW;
const TranslateMessage = wnd.TranslateMessage;

var main_hWnd: ?HWND = null;

pub fn main() void {
    const hInstance: ?HINSTANCE = @ptrCast(GetModuleHandleW(null));

    main_hWnd = impl.createWindow(hInstance, wndproc);

    _ = ShowWindow(main_hWnd, wnd.SW_SHOW);
    renderText(main_hWnd, utf8ToUtf16LeStringLiteral("Hello, World"));

    var msg: MSG = undefined;
    var exit_code: UINT = 0;

    defer ExitProcess(exit_code);

    running: while (true) {
        while (PeekMessageW(&msg, null, 0, 0, wnd.PM_REMOVE) != 0) {
            if (msg.message == wnd.WM_QUIT) {
                @branchHint(.unlikely);
                exit_code = @intCast(msg.wParam);
                break :running;
            }

            _ = TranslateMessage(&msg);
            _ = DispatchMessageW(&msg);
        }
    }
}

fn wndproc(hWnd: ?HWND, uMsg: UINT, wParam: WPARAM, lParam: LPARAM) callconv(.winapi) LRESULT {
    if (uMsg == wnd.WM_DESTROY and hWnd == main_hWnd) {
        @branchHint(.unlikely);
        PostQuitMessage(0);
        return 0;
    }

    switch (uMsg) {
        wnd.WM_CREATE => {},
        wnd.WM_MOVE => {},
        wnd.WM_SIZE => {},
        wnd.WM_ACTIVATE => {},
        wnd.WM_SETFOCUS => {},
        wnd.WM_KILLFOCUS => {},
        wnd.WM_PAINT => {},
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

    return DefWindowProcW(hWnd, uMsg, wParam, lParam);
}

fn renderText(hWnd: ?HWND, text: [:0]const u16) void {
    var paint: PAINTSTRUCT = undefined;
    const hDc = BeginPaint(hWnd, &paint);
    defer _ = EndPaint(hWnd, &paint);

    _ = TextOutW(hDc, 0, 0, text, @intCast(text.len));
}

fn showUMsg(uMsg: UINT) void {
    var buffer: [64]u8 = undefined;
    var fixed_buffer = FixedBufferAllocator.init(&buffer);
    const allocator = fixed_buffer.allocator();

    const text_u8 = allocPrint(allocator, "{x}", .{uMsg}) catch return;
    const text_u16 = utf8ToUtf16LeAllocZ(allocator, text_u8) catch return;

    _ = wnd.MessageBoxW(null, text_u16, utf8ToUtf16LeStringLiteral("uMsg"), 0);
}
