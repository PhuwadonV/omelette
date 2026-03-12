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
const CreateWindowExW = wnd.CreateWindowExW;
const RegisterClassExW = wnd.RegisterClassExW;

pub fn createWindow(hInstance: ?HINSTANCE, wndproc: WNDPROC) ?HWND {
    const CS_VREDRAW = 0x0001;
    const CS_HREDRAW = 0x0002;
    const CS_DBLCLKS = 0x0008;

    const IDC_ARROW = 0x7F00;

    const COLOR_WINDOW = 5;

    const WS_MAXIMIZEBOX = 0x00010000;
    const WS_MINIMIZEBOX = 0x00020000;
    const WS_SYSMENU = 0x00080000;

    const CW_USEDEFAULT = 0x80000000;

    const SW_SHOWDEFAULT = 10;

    const wndClassName = spec.getWndClassName();
    const windowName = spec.getWindowName();

    const wcex = WNDCLASSEXW{
        .cbSize = @sizeOf(WNDCLASSEXW),
        .style = CS_HREDRAW | CS_VREDRAW | CS_DBLCLKS,
        .lpfnWndProc = wndproc,
        .cbClsExtra = 0,
        .cbWndExtra = 0,
        .hInstance = hInstance,
        .hIcon = null,
        .hCursor = LoadCursorW(null, @ptrFromInt(IDC_ARROW)),
        .hbrBackground = @ptrFromInt(COLOR_WINDOW),
        .lpszMenuName = null,
        .lpszClassName = wndClassName,
        .hIconSm = null,
    };

    _ = RegisterClassExW(&wcex);

    const hWnd = CreateWindowExW(
        0,
        wndClassName,
        windowName,
        WS_SYSMENU | WS_MINIMIZEBOX | WS_MAXIMIZEBOX,
        @bitCast(@as(c_uint, CW_USEDEFAULT)),
        @bitCast(@as(c_uint, CW_USEDEFAULT)),
        @bitCast(@as(c_uint, CW_USEDEFAULT)),
        @bitCast(@as(c_uint, CW_USEDEFAULT)),
        null,
        null,
        hInstance,
        null,
    );

    _ = ShowWindow(hWnd, SW_SHOWDEFAULT);

    return hWnd;
}
