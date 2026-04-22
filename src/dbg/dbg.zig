const app = root.app;
const std = @import("std");
const wnd = root.wnd;
const root = @import("root");
const debug = std.debug;
const config = @import("config");
const unicode = std.unicode;

const defaultPanic = debug.defaultPanic;
const utf8ToUtf16LeStringLiteral = unicode.utf8ToUtf16LeStringLiteral;

pub fn showMsg(msg: [:0]const u8) void {
    _ = wnd.MessageBoxA(
        null,
        msg,
        app.spec.getAppTitle(),
        wnd.MB_OK,
    );
}

pub fn showMsgW(msg: [:0]const u16) void {
    _ = wnd.MessageBoxW(
        null,
        msg,
        utf8ToUtf16LeStringLiteral(app.spec.getAppTitle()),
        wnd.MB_OK,
    );
}

pub fn showErrorMsg(msg: [:0]const u8) void {
    if (config.dev_mode) {
        if (wnd.MessageBoxA(
            null,
            msg,
            "Skip this error breakpoint?",
            wnd.MB_YESNO | wnd.MB_ICONERROR,
        ) == wnd.IDNO) @breakpoint();
    } else {
        _ = wnd.MessageBoxA(
            null,
            msg,
            app.spec.getAppTitle(),
            wnd.MB_ICONERROR,
        );
    }
}

pub fn showError(err: anyerror) void {
    showErrorMsg(@errorName(err));
}

pub fn panic(msg: []const u8, first_trace_addr: ?usize) noreturn {
    @branchHint(.cold);

    if (@errorReturnTrace()) |stack_trace| {
        debug.dumpErrorReturnTrace(stack_trace);
    }

    if (msg.ptr[msg.len] == 0) {
        showErrorMsg(@as([*:0]const u8, @ptrCast(msg.ptr))[0..msg.len :0]);
    }

    defaultPanic(msg, first_trace_addr);
}
