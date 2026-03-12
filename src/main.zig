const std = @import("std");
const wnd = @import("wnd.zig");
const impl = @import("impl/impl.zig");
const windows = std.os.windows;
const kernel32 = windows.kernel32;

const MSG = wnd.MSG;
const HWND = windows.HWND;
const UINT = windows.UINT;
const LPARAM = windows.LPARAM;
const WPARAM = windows.WPARAM;
const LRESULT = windows.LRESULT;
const HINSTANCE = windows.HINSTANCE;

const PeekMessageW = wnd.PeekMessageW;
const DefWindowProcW = wnd.DefWindowProcW;
const PostQuitMessage = wnd.PostQuitMessage;
const DispatchMessageW = wnd.DispatchMessageW;
const GetModuleHandleW = kernel32.GetModuleHandleW;
const TranslateMessage = wnd.TranslateMessage;

pub fn main() void {
    const PM_REMOVE = 0x0001;
    const WM_QUIT = 0x0012;

    const hInstance: ?HINSTANCE = @ptrCast(GetModuleHandleW(null));

    _ = impl.createWindow(hInstance, wndproc);

    var msg: MSG = undefined;
    var exit_code: WPARAM = 0;

    running: while (true) {
        while (PeekMessageW(&msg, null, 0, 0, PM_REMOVE) != 0) {
            if (msg.message == WM_QUIT) {
                exit_code = msg.wParam;
                break :running;
            }

            _ = TranslateMessage(&msg);
            _ = DispatchMessageW(&msg);
        }
    }
}

fn wndproc(hWnd: ?HWND, uMsg: UINT, wParam: WPARAM, lParam: LPARAM) callconv(.winapi) LRESULT {
    const WM_DESTROY = 0x0002;

    if (uMsg == WM_DESTROY) {
        PostQuitMessage(0);
    }

    return DefWindowProcW(hWnd, uMsg, wParam, lParam);
}
