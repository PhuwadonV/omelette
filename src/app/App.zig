const wnd = root.wnd;
const impl = @import("impl.zig");
const root = @import("root");

const App = @This();

hInstance: ?wnd.HINSTANCE,
hWnd: ?wnd.HWND,

pub fn createApp(wndproc: wnd.WNDPROC) App {
    const hInstance: ?wnd.HINSTANCE = @ptrCast(wnd.GetModuleHandleW(null));
    const hWnd = impl.createWindow(hInstance, wndproc);

    _ = wnd.ShowWindow(hWnd, wnd.SW_SHOWDEFAULT);

    return App{
        .hInstance = hInstance,
        .hWnd = hWnd,
    };
}
