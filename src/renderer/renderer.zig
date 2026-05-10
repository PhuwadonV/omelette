const wnd = root.wnd;
const impl = @import("impl.zig");
const root = @import("root");
const config = @import("config");
const window = root.window;

const App = root.App;
const MainWindow = window.MainWindow;

pub const MainRenderer = struct {
    valid: bool = false,

    pub fn create(main_window: *const MainWindow) !MainRenderer {
        if (!main_window.valid) return error.InvalidMainWindow;

        return .{
            .valid = true,
        };
    }

    pub fn destroy(self: *MainRenderer) void {
        if (!self.valid) return;
        defer self.valid = false;
    }

    pub fn renderFirstFrame(self: *MainRenderer) void {
        _ = self;
    }

    pub fn render(self: *MainRenderer, app: *App, hWnd: ?wnd.HWND) void {
        _ = self;

        var paint: wnd.PAINTSTRUCT = undefined;
        const hDc = wnd.BeginPaint(hWnd, &paint);
        defer _ = wnd.EndPaint(hWnd, &paint);

        impl.renderBackground(hWnd, hDc, app.bg_color);

        if (!config.dev_mode) return;

        impl.renderVkApiVersion(hDc);
    }
};
