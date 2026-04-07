const wnd = root.wnd;
const spec = @import("spec.zig");
const root = @import("root");

pub fn createBorderlessFullscreenWindow(hInstance: ?wnd.HINSTANCE, wndproc: wnd.WNDPROC) !?wnd.HWND {
    const wndclass_name = spec.getWndclassName();
    const window_name = spec.getWindowName();

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
        .lpszClassName = wndclass_name,
        .hIconSm = null,
    };

    if (wnd.RegisterClassExW(&wcex) == 0) {
        return error.WindowClassRegistrationFailed;
    }

    const screen_width = wnd.GetSystemMetrics(wnd.SM_CXSCREEN);
    const screen_height = wnd.GetSystemMetrics(wnd.SM_CYSCREEN);

    const hWnd = wnd.CreateWindowExW(
        wnd.WS_EX_APPWINDOW,
        wndclass_name,
        window_name,
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

    if (hWnd == null) {
        return error.WindowCreationFailed;
    }

    return hWnd;
}
