const app = root.app;
const std = @import("std");
const wnd = root.wnd;
const root = @import("root");
const debug = std.debug;
const config = @import("config");
const builtin = @import("builtin");
const unicode = std.unicode;

const StackTrace = std.builtin.StackTrace;

const defaultPanic = debug.defaultPanic;
const writeStackTrace = debug.writeStackTrace;
const getSelfDebugInfo = debug.getSelfDebugInfo;
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

pub fn logStackTrace(stack_trace: *StackTrace) void {
    if (builtin.strip_debug_info) return;
    if (@min(stack_trace.index, stack_trace.instruction_addresses.len) <= 0) return;

    const file = std.fs.cwd().createFile("stack_trace.txt", .{}) catch return;
    defer file.close();

    var buffer: [1024]u8 = undefined;
    var file_writer = file.writer(&buffer);

    writeStackTrace(
        stack_trace.*,
        &file_writer.interface,
        getSelfDebugInfo() catch return,
        .no_color,
    ) catch return;

    file_writer.interface.flush() catch {};
}

pub fn panic(msg: []const u8, first_trace_addr: ?usize) noreturn {
    @branchHint(.cold);

    if (@errorReturnTrace()) |stack_trace| {
        logStackTrace(stack_trace);
    }

    if (msg.ptr[msg.len] == 0) {
        showErrorMsg(@as([*:0]const u8, @ptrCast(msg.ptr))[0..msg.len :0]);
    }

    defaultPanic(msg, first_trace_addr);
}
