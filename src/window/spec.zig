const std = @import("std");
const unicode = std.unicode;

const wndclass_name = unicode.utf8ToUtf16LeStringLiteral("WndClass_Omelette");
const window_name = unicode.utf8ToUtf16LeStringLiteral("Omelette");

pub fn getWndclassName() @TypeOf(wndclass_name) {
    return wndclass_name;
}

pub fn getWindowName() @TypeOf(window_name) {
    return window_name;
}
