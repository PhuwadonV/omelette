pub const vk = @import("vk.zig");
pub const app = @import("app/app.zig");
pub const dbg = @import("dbg/dbg.zig");
pub const vkh = @import("vkh.zig");
pub const wnd = @import("wnd.zig");
pub const window = @import("window/window.zig");

const MainWindow = window.MainWindow;

var main_window: MainWindow = undefined;

pub fn main() void {
    if (run()) |exit_code| {
        wnd.ExitProcess(exit_code);
    } else |_| {
        wnd.ExitProcess(1);
    }
}

fn run() !wnd.UINT {
    main_window = try MainWindow.create(app.getMainWndproc(&main_window));
    main_window.notifyReady();

    var exit_code: wnd.UINT = 0;
    var msg: wnd.MSG = undefined;

    running: while (true) {
        while (wnd.PeekMessageW(&msg, null, 0, 0, wnd.PM_REMOVE) != 0) {
            if (msg.message == wnd.WM_QUIT) {
                @branchHint(.unlikely);
                exit_code = @intCast(msg.wParam);
                break :running;
            }

            _ = wnd.TranslateMessage(&msg);
            _ = wnd.DispatchMessageW(&msg);
        }
    }

    return exit_code;
}
