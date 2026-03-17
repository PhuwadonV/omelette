const std = @import("std");
const windows = std.os.windows;

const HDC = windows.HDC;
const ATOM = windows.ATOM;
const BOOL = windows.BOOL;
const BYTE = windows.BYTE;
const HWND = windows.HWND;
const RECT = windows.RECT;
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

pub const PAINTSTRUCT = extern struct {
    hDc: HDC,
    fErase: BOOL,
    rcPaint: RECT,
    fRestore: BOOL,
    fIncUpdate: BOOL,
    rgbReserved: [32]BYTE,
};

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

pub extern "user32" fn EndPaint(hWnd: ?HWND, lpPaint: ?*const PAINTSTRUCT) callconv(.winapi) BOOL;
pub extern "user32" fn BeginPaint(hWnd: ?HWND, lpPaint: ?*PAINTSTRUCT) callconv(.winapi) ?HDC;
pub extern "user32" fn ShowWindow(hWnd: ?HWND, nCmdShow: c_int) callconv(.winapi) BOOL;
pub extern "user32" fn LoadCursorW(hInstance: ?HINSTANCE, lpCursorName: ?LPCWSTR) callconv(.winapi) ?HCURSOR;
pub extern "user32" fn MessageBoxW(hWnd: ?HWND, lpText: ?LPCWSTR, lpCaption: ?LPCWSTR, uType: UINT) callconv(.winapi) c_int;
pub extern "user32" fn PeekMessageW(lpMsg: ?*MSG, hWnd: ?HWND, wMsgFilterMin: UINT, wMsgFilterMax: UINT, wRemoveMsg: UINT) callconv(.winapi) BOOL;
pub extern "user32" fn UpdateWindow(hWnd: ?HWND) callconv(.winapi) BOOL;
pub extern "user32" fn DefWindowProcW(hWnd: ?HWND, Msg: UINT, wParam: WPARAM, lParam: LPARAM) callconv(.winapi) LRESULT;
pub extern "user32" fn CreateWindowExW(dwExStyle: DWORD, lpClassName: ?LPCWSTR, lpWindowName: ?LPCWSTR, dwStyle: DWORD, X: c_int, Y: c_int, nWidth: c_int, nHeight: c_int, hWndParent: ?HWND, hMenu: ?HMENU, hInstance: ?HINSTANCE, lpParam: ?LPVOID) callconv(.winapi) ?HWND;
pub extern "user32" fn PostQuitMessage(nExitCode: c_int) callconv(.winapi) void;
pub extern "user32" fn DispatchMessageW(lpMsg: ?*const MSG) callconv(.winapi) LRESULT;
pub extern "user32" fn RegisterClassExW(lpWndClass: ?*const WNDCLASSEXW) callconv(.winapi) ATOM;
pub extern "user32" fn TranslateMessage(lpMsg: ?*const MSG) callconv(.winapi) BOOL;

pub extern "gdi32" fn TextOutW(hDc: ?HDC, x: c_int, y: c_int, lpString: ?LPCWSTR, c: c_int) callconv(.winapi) BOOL;

pub const COLOR_WINDOW = 5;

pub const CS_VREDRAW = 0x0001;
pub const CS_HREDRAW = 0x0002;
pub const CS_DBLCLKS = 0x0008;

pub const CW_USEDEFAULT = 0x80000000;

pub const IDC_ARROW = 0x7F00;

pub const PM_REMOVE = 0x0001;

pub const SW_SHOWDEFAULT = 10;

pub const WS_MAXIMIZEBOX = 0x00010000;
pub const WS_MINIMIZEBOX = 0x00020000;
pub const WS_SYSMENU = 0x00080000;

pub const WM_DESTROY = 0x0002;
pub const WM_PAINT = 0x000F;
pub const WM_QUIT = 0x0012;
