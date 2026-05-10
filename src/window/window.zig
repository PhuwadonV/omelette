const wnd = root.wnd;
const impl = @import("impl.zig");
const root = @import("root");

pub const spec = @import("spec.zig");

pub const MainWindow = struct {
    valid: bool = false,
    hInstance: ?wnd.HINSTANCE = null,
    hWnd: ?wnd.HWND = null,

    pub fn create(wndproc: wnd.WNDPROC) !MainWindow {
        const hInstance: ?wnd.HINSTANCE = @ptrCast(wnd.GetModuleHandleW(null));
        const hWnd = try impl.createBorderlessFullscreenWindow(hInstance, wndproc);

        return MainWindow{
            .valid = true,
            .hInstance = hInstance,
            .hWnd = hWnd,
        };
    }

    pub fn destroy(self: *MainWindow) void {
        if (!self.valid) return;
        defer self.valid = false;
    }

    pub fn notifyClose(self: *MainWindow) void {
        _ = self;
    }

    pub fn notifyFirstFrameRendered(self: *MainWindow) void {
        _ = wnd.ShowWindow(self.hWnd, wnd.SW_SHOWDEFAULT);
    }
};
