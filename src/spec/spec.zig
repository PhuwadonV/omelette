const std = @import("std");
const unicode = std.unicode;

const utf8ToUtf16LeStringLiteral = unicode.utf8ToUtf16LeStringLiteral;

const wndclass_name = utf8ToUtf16LeStringLiteral("WndClass_Omelette");
const window_name = utf8ToUtf16LeStringLiteral("Omelette");

pub fn getWndclassName() @TypeOf(wndclass_name) {
    return wndclass_name;
}

pub fn getWindowName() @TypeOf(window_name) {
    return window_name;
}
