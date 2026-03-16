const std = @import("std");
const wnd = @import("../wnd.zig");
const spec = @import("../spec/spec.zig");
const windows = std.os.windows;

const HWND = windows.HWND;
const WNDPROC = wnd.WNDPROC;
const HINSTANCE = windows.HINSTANCE;
const WNDCLASSEXW = wnd.WNDCLASSEXW;

const ShowWindow = wnd.ShowWindow;
const LoadCursorW = wnd.LoadCursorW;
const UpdateWindow = wnd.UpdateWindow;
const CreateWindowExW = wnd.CreateWindowExW;
const RegisterClassExW = wnd.RegisterClassExW;

pub fn createWindow(hInstance: ?HINSTANCE, wndproc: WNDPROC) ?HWND {
    const wndClassName = spec.getWndClassName();
    const windowName = spec.getWindowName();

    const wcex = WNDCLASSEXW{
        .cbSize = @sizeOf(WNDCLASSEXW),
        .style = wnd.CS_HREDRAW | wnd.CS_VREDRAW | wnd.CS_DBLCLKS,
        .lpfnWndProc = wndproc,
        .cbClsExtra = 0,
        .cbWndExtra = 0,
        .hInstance = hInstance,
        .hIcon = null,
        .hCursor = LoadCursorW(null, @ptrFromInt(wnd.IDC_ARROW)),
        .hbrBackground = @ptrFromInt(wnd.COLOR_WINDOW),
        .lpszMenuName = null,
        .lpszClassName = wndClassName,
        .hIconSm = null,
    };

    _ = RegisterClassExW(&wcex);

    const hWnd = CreateWindowExW(
        0,
        wndClassName,
        windowName,
        wnd.WS_SYSMENU | wnd.WS_MINIMIZEBOX | wnd.WS_MAXIMIZEBOX,
        @bitCast(@as(c_uint, wnd.CW_USEDEFAULT)),
        @bitCast(@as(c_uint, wnd.CW_USEDEFAULT)),
        @bitCast(@as(c_uint, wnd.CW_USEDEFAULT)),
        @bitCast(@as(c_uint, wnd.CW_USEDEFAULT)),
        null,
        null,
        hInstance,
        null,
    );

    _ = ShowWindow(hWnd, wnd.SW_SHOWDEFAULT);
    _ = UpdateWindow(hWnd);

    return hWnd;
}
