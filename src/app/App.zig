const wnd = root.wnd;
const root = @import("root");
const window = root.window;
const renderer = root.renderer;

pub const spec = @import("spec.zig");

const App = @This();
const MainWindow = window.MainWindow;
const MainRenderer = renderer.MainRenderer;

valid: bool = false,
bg_color: ?wnd.HBRUSH,

pub fn create(main_window: *const MainWindow, main_renderer: *const MainRenderer) !App {
    if (!main_window.valid) return error.InvalidMainWindow;
    if (!main_renderer.valid) return error.InvalidMainRenderer;

    return .{
        .valid = true,
        .bg_color = wnd.CreateSolidBrush(0x008080FF),
    };
}

pub fn destroy(self: *App) void {
    if (!self.valid) return;
    defer self.valid = false;

    if (self.bg_color != null) {
        defer self.bg_color = null;

        _ = wnd.DeleteObject(self.bg_color);
    }
}
