const wnd = root.wnd;
const root = @import("root");

pub const spec = @import("spec.zig");

const App = @This();

bg_color: ?wnd.HBRUSH,

pub fn create(bg_color: ?wnd.HBRUSH) App {
    return .{
        .bg_color = bg_color,
    };
}

pub fn cleanup(self: *App) void {
    if (self.bg_color != null) {
        defer self.bg_color = null;

        _ = wnd.DeleteObject(self.bg_color);
    }
}
