const std = @import("std");
const unicode = std.unicode;
const windows = std.os.windows;

const HWND = windows.HWND;
const UINT = windows.UINT;
const LPCWSTR = windows.LPCWSTR;

const utf8ToUtf16LeStringLiteral = unicode.utf8ToUtf16LeStringLiteral;

extern "user32" fn MessageBoxW(hWnd: ?HWND, lpText: ?LPCWSTR, lpCaption: ?LPCWSTR, uType: UINT) callconv(.winapi) c_int;

pub fn main() void {
    _ = MessageBoxW(
        null,
        utf8ToUtf16LeStringLiteral("Hello, World!"),
        utf8ToUtf16LeStringLiteral("Omelette"),
        0,
    );
}
