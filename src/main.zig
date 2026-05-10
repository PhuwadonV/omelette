const std = @import("std");
const debug = std.debug;
const config = @import("config");

pub const vk = @import("vk.zig");
pub const dbg = @import("dbg/dbg.zig");
pub const vkh = @import("vkh.zig");
pub const wnd = @import("wnd/wnd.zig");
pub const window = @import("window/window.zig");

const MainWindow = window.MainWindow;

pub const App = @import("app/App.zig");
pub const Renderer = @import("renderer/Renderer.zig");

pub const panic = debug.FullPanic(dbg.panic);

var main_app: App = undefined;
var main_window: MainWindow = undefined;
var main_renderer: Renderer = undefined;

pub fn main() void {
    if (config.dev_mode) _ = wnd.AttachConsole(0xFFFFFFFF);

    if (run()) |exit_code| {
        wnd.ExitProcess(exit_code);
    } else |err| {
        if (@errorReturnTrace()) |stack_trace| {
            debug.dumpErrorReturnTrace(stack_trace);
        }

        dbg.showError(err);
        wnd.ExitProcess(1);
    }
}

fn run() !wnd.UINT {
    try init();

    var exit_code: wnd.UINT = 0;
    var msg: wnd.MSG = undefined;

    running: while (true) {
        while (wnd.PeekMessageW(&msg, null, 0, 0, wnd.PM_REMOVE).toBool()) {
            if (msg.message == @intFromEnum(wnd.WM.QUIT)) {
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

fn init() !void {
    main_window = try MainWindow.create(wndproc);
    main_app = App.create(wnd.CreateSolidBrush(0x008080FF));
    main_renderer = Renderer.create();

    main_window.notifyReady();
}

fn wndproc(hWnd: ?wnd.HWND, uMsg: wnd.UINT, wParam: wnd.WPARAM, lParam: wnd.LPARAM) callconv(.winapi) wnd.LRESULT {
    const opt_msg: ?wnd.WM = if (uMsg < 0x400) @enumFromInt(uMsg) else null;

    if (opt_msg) |msg| switch (msg) {
        .DESTROY => if (hWnd == main_window.hWnd) {
            @branchHint(.unlikely);
            main_window.notifyInvalid();
            main_app.cleanup();
            wnd.PostQuitMessage(0);
            return 0;
        },
        .PAINT => if (hWnd == main_window.hWnd) {
            main_renderer.render(&main_app, hWnd);
            return 0;
        },
        .CREATE => {},
        .SIZE => {},
        .MOVE => {},
        .ACTIVATE => {},
        .SETFOCUS => {},
        .KILLFOCUS => {},
        .CLOSE => {},
        .ERASEBKGND => {},
        .SHOWWINDOW => {},
        .ACTIVATEAPP => {},
        .SETCURSOR => {},
        .MOUSEACTIVATE => {},
        .WINDOWPOSCHANGING => {},
        .WINDOWPOSCHANGED => {},
        .@"004D" => {},
        .INPUTLANGCHANGE => {},
        .HELP => {},
        .CONTEXTMENU => {},
        .GETICON => {},
        .NCCREATE => {},
        .NCCALCSIZE => {},
        .NCHITTEST => {},
        .NCPAINT => {},
        .NCACTIVATE => {},
        .@"0090" => {},
        .KEYDOWN => {},
        .KEYUP => {},
        .CHAR => {},
        .SYSKEYDOWN => {},
        .SYSKEYUP => {},
        .SYSCHAR => {},
        .SYSCOMMAND => {},
        .MOUSEMOVE => {},
        .LBUTTONDOWN => {},
        .LBUTTONUP => {},
        .RBUTTONDOWN => {},
        .RBUTTONUP => {},
        .MBUTTONDOWN => {},
        .MBUTTONUP => {},
        .MOUSEWHEEL => {},
        .XBUTTONDOWN => {},
        .XBUTTONUP => {},
        .IME_SETCONTEXT => {},
        .IME_NOTIFY => {},
        .IME_REQUEST => {},
        .APPCOMMAND => {},
        else => if (config.dev_mode) {
            _ = wnd.MessageBoxA(null, @tagName(msg), "WM", 0);
        },
    };

    return wnd.DefWindowProcW(hWnd, uMsg, wParam, lParam);
}
