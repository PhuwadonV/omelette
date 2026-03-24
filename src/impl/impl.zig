const std = @import("std");
const wnd = @import("../wnd.zig");
const spec = @import("../spec/spec.zig");
const windows = std.os.windows;

const HWND = windows.HWND;
const WNDPROC = wnd.WNDPROC;
const HINSTANCE = windows.HINSTANCE;
const WNDCLASSEXW = wnd.WNDCLASSEXW;

const SetFocus = wnd.SetFocus;
const ShowWindow = wnd.ShowWindow;
const UpdateWindow = wnd.UpdateWindow;
const CreateWindowExW = wnd.CreateWindowExW;
const GetSystemMetrics = wnd.GetSystemMetrics;
const RegisterClassExW = wnd.RegisterClassExW;
const SetForegroundWindow = wnd.SetForegroundWindow;

pub fn createWindow(hInstance: ?HINSTANCE, wndproc: WNDPROC) ?HWND {
    const wndClassName = spec.getWndClassName();
    const windowName = spec.getWindowName();

    const wcex = WNDCLASSEXW{
        .cbSize = @sizeOf(WNDCLASSEXW),
        .style = 0,
        .lpfnWndProc = wndproc,
        .cbClsExtra = 0,
        .cbWndExtra = 0,
        .hInstance = hInstance,
        .hIcon = null,
        .hCursor = null,
        .hbrBackground = null,
        .lpszMenuName = null,
        .lpszClassName = wndClassName,
        .hIconSm = null,
    };

    _ = RegisterClassExW(&wcex);

    const screen_width = GetSystemMetrics(wnd.SM_CXSCREEN);
    const screen_height = GetSystemMetrics(wnd.SM_CYSCREEN);

    const hWnd = CreateWindowExW(
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

    _ = ShowWindow(hWnd, wnd.SW_SHOW);
    _ = SetForegroundWindow(hWnd);
    _ = SetFocus(hWnd);

    return hWnd;
}
