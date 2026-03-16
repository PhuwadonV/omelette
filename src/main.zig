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

const utf8ToUtf16LeStringLiteral = unicode.utf8ToUtf16LeStringLiteral;

const EndPaint = wnd.EndPaint;
const TextOutW = wnd.TextOutW;
const BeginPaint = wnd.BeginPaint;
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

    var msg: MSG = undefined;
    var exit_code: UINT = 0;

    defer ExitProcess(exit_code);

    running: while (true) {
        while (PeekMessageW(&msg, null, 0, 0, wnd.PM_REMOVE) != 0) {
            if (msg.message == wnd.WM_QUIT) {
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
        wnd.WM_PAINT => {
            renderText(hWnd, utf8ToUtf16LeStringLiteral("Hello, World"));
            return 0;
        },
        else => {},
    }

    return DefWindowProcW(hWnd, uMsg, wParam, lParam);
}

fn renderText(hWnd: ?HWND, text: [:0]const u16) void {
    var paint: PAINTSTRUCT = undefined;
    const hDc = BeginPaint(hWnd, &paint);
    defer _ = EndPaint(hWnd, &paint);

    _ = TextOutW(hDc, 0, 0, text, @intCast(text.len));
}
