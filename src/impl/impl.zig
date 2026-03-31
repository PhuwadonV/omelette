const std = @import("std");
const wnd = @import("../wnd.zig");
const spec = @import("../spec/spec.zig");

pub fn createWindow(hInstance: ?wnd.HINSTANCE, wndproc: wnd.WNDPROC) ?wnd.HWND {
    const wndClassName = spec.getWndClassName();
    const windowName = spec.getWindowName();

    const wcex = wnd.WNDCLASSEXW{
        .cbSize = @sizeOf(wnd.WNDCLASSEXW),
        .style = 0,
        .lpfnWndProc = wndproc,
        .cbClsExtra = 0,
        .cbWndExtra = 0,
        .hInstance = hInstance,
        .hIcon = null,
        .hCursor = wnd.LoadCursorW(null, @ptrFromInt(wnd.IDC_ARROW)),
        .hbrBackground = null,
        .lpszMenuName = null,
        .lpszClassName = wndClassName,
        .hIconSm = null,
    };

    _ = wnd.RegisterClassExW(&wcex);

    const screen_width = wnd.GetSystemMetrics(wnd.SM_CXSCREEN);
    const screen_height = wnd.GetSystemMetrics(wnd.SM_CYSCREEN);

    const hWnd = wnd.CreateWindowExW(
        wnd.WS_EX_APPWINDOW,
        wndClassName,
        windowName,
        wnd.WS_POPUP,
        0,
        0,
        screen_width,
        screen_height,
        null,
        null,
        hInstance,
        null,
    );

    return hWnd;
}
