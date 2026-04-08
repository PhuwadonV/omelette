const wnd = root.wnd;
const impl = @import("impl.zig");
const root = @import("root");

pub const spec = @import("spec.zig");

pub const MainWindow = struct {
    const Status = enum {
        invalid,
        created,
        ready,
    };

    hInstance: ?wnd.HINSTANCE = null,
    hWnd: ?wnd.HWND = null,
    status: Status = .invalid,

    pub fn create(wndproc: wnd.WNDPROC) !MainWindow {
        const hInstance: ?wnd.HINSTANCE = @ptrCast(wnd.GetModuleHandleW(null));
        const hWnd = try impl.createBorderlessFullscreenWindow(hInstance, wndproc);

        return MainWindow{
            .hInstance = hInstance,
            .hWnd = hWnd,
            .status = .created,
        };
    }

    pub fn notifyReady(self: *MainWindow) void {
        if (self.status != .created) return;
        defer self.status = .ready;

        _ = wnd.ShowWindow(self.hWnd, wnd.SW_SHOWDEFAULT);
    }

    pub fn notifyInvalid(self: *MainWindow) void {
        self.status = .invalid;
    }
};
