const std = @import("std");
const unicode = std.unicode;

const utf8ToUtf16LeStringLiteral = unicode.utf8ToUtf16LeStringLiteral;

const wndClassName = utf8ToUtf16LeStringLiteral("WndClass_Omelette");
const windowName = utf8ToUtf16LeStringLiteral("Omelette");

pub fn getWndClassName() @TypeOf(wndClassName) {
    return wndClassName;
}

pub fn getWindowName() @TypeOf(windowName) {
    return windowName;
}
