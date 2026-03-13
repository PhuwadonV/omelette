const std = @import("std");
const windows = std.os.windows;

const ATOM = windows.ATOM;
const BOOL = windows.BOOL;
const HWND = windows.HWND;
const UINT = windows.UINT;
const DWORD = windows.DWORD;
const HICON = windows.HICON;
const HMENU = windows.HMENU;
const POINT = windows.POINT;
const HBRUSH = windows.HBRUSH;
const LPARAM = windows.LPARAM;
const LPVOID = windows.LPVOID;
const WPARAM = windows.WPARAM;
const HCURSOR = windows.HCURSOR;
const LPCWSTR = windows.LPCWSTR;
const LRESULT = windows.LRESULT;
const HINSTANCE = windows.HINSTANCE;

pub const MSG = extern struct {
    hWnd: ?HWND,
    message: UINT,
    wParam: WPARAM,
    lParam: LPARAM,
    time: DWORD,
    pt: POINT,
    lPrivate: DWORD,
};

pub const WNDPROC = *const fn (hWnd: ?HWND, uMsg: UINT, wParam: WPARAM, lParam: LPARAM) callconv(.winapi) LRESULT;

pub const WNDCLASSEXW = extern struct {
    cbSize: UINT,
    style: UINT,
    lpfnWndProc: ?WNDPROC,
    cbClsExtra: c_int,
    cbWndExtra: c_int,
    hInstance: ?HINSTANCE,
    hIcon: ?HICON,
    hCursor: ?HCURSOR,
    hbrBackground: ?HBRUSH,
    lpszMenuName: ?LPCWSTR,
    lpszClassName: ?LPCWSTR,
    hIconSm: ?HICON,
};

pub extern "user32" fn ShowWindow(hWnd: ?HWND, nCmdShow: c_int) callconv(.winapi) BOOL;
pub extern "user32" fn LoadCursorW(hInstance: ?HINSTANCE, lpCursorName: ?LPCWSTR) callconv(.winapi) ?HCURSOR;
pub extern "user32" fn PeekMessageW(lpMsg: ?*MSG, hWnd: ?HWND, wMsgFilterMin: UINT, wMsgFilterMax: UINT, wRemoveMsg: UINT) callconv(.winapi) BOOL;
pub extern "user32" fn UpdateWindow(hWnd: ?HWND) callconv(.winapi) BOOL;
pub extern "user32" fn DefWindowProcW(hWnd: ?HWND, Msg: UINT, wParam: WPARAM, lParam: LPARAM) callconv(.winapi) LRESULT;
pub extern "user32" fn CreateWindowExW(dwExStyle: DWORD, lpClassName: ?LPCWSTR, lpWindowName: ?LPCWSTR, dwStyle: DWORD, X: c_int, Y: c_int, nWidth: c_int, nHeight: c_int, hWndParent: ?HWND, hMenu: ?HMENU, hInstance: ?HINSTANCE, lpParam: ?LPVOID) callconv(.winapi) ?HWND;
pub extern "user32" fn PostQuitMessage(nExitCode: c_int) callconv(.winapi) void;
pub extern "user32" fn DispatchMessageW(lpMsg: ?*const MSG) callconv(.winapi) LRESULT;
pub extern "user32" fn RegisterClassExW(lpWndClass: ?*const WNDCLASSEXW) callconv(.winapi) ATOM;
pub extern "user32" fn TranslateMessage(lpMsg: ?*const MSG) callconv(.winapi) BOOL;
