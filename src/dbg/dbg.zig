const app = root.app;
const std = @import("std");
const wnd = root.wnd;
const root = @import("root");

pub fn showMsg(msg: [:0]const u8) void {
    _ = wnd.MessageBoxA(null, msg, app.spec.getAppTitle(), wnd.MB_OK);
}
