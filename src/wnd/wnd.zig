const std = @import("std");
const windows = std.os.windows;

pub const HDC = windows.HDC;
pub const ATOM = windows.ATOM;
pub const BOOL = windows.BOOL;
pub const BYTE = windows.BYTE;
pub const HWND = windows.HWND;
pub const LONG = windows.LONG;
pub const UINT = windows.UINT;
pub const DWORD = windows.DWORD;
pub const HICON = windows.HICON;
pub const HMENU = windows.HMENU;
pub const HBRUSH = windows.HBRUSH;
pub const LPARAM = windows.LPARAM;
pub const LPCSTR = windows.LPCSTR;
pub const LPVOID = windows.LPVOID;
pub const SIZE_T = windows.SIZE_T;
pub const WPARAM = usize;
pub const HCURSOR = windows.HCURSOR;
pub const HMODULE = windows.HMODULE;
pub const LPCWSTR = windows.LPCWSTR;
pub const LRESULT = isize;
pub const HINSTANCE = windows.HINSTANCE;

pub const MSG = extern struct {
    hWnd: ?HWND,
    message: UINT,
    wParam: WPARAM,
    lParam: LPARAM,
    time: DWORD,
    pt: POINT,
    lPrivate: DWORD,
};

pub const RECT = extern struct {
    left: LONG,
    top: LONG,
    right: LONG,
    bottom: LONG,
};

pub const POINT = extern struct {
    x: LONG,
    y: LONG,
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

pub const MB_OK = 0x00000000;
pub const MB_ICONERROR = 0x00000010;

pub const IDC_ARROW = 0x7F00;

pub const SM_CXSCREEN = 0;
pub const SM_CYSCREEN = 1;

pub const PM_REMOVE = 0x0001;

pub const SW_SHOWDEFAULT = 10;

pub const WS_EX_APPWINDOW = 0x00040000;
pub const WS_POPUP = 0x80000000;

pub const MEM_COMMIT = 0x00001000;
pub const MEM_RESERVE = 0x00002000;
pub const MEM_DECOMMIT = 0x00004000;
pub const MEM_RELEASE = 0x00008000;
pub const MEM_RESET = 0x00080000;

pub const PAGE_READWRITE = 0x04;

pub const WM = @import("wm.zig").WM;

pub extern "kernel32" fn ExitProcess(exit_code: UINT) callconv(.winapi) noreturn;
pub extern "kernel32" fn VirtualFree(lpAddress: ?LPVOID, dwSize: SIZE_T, dwFreeType: DWORD) callconv(.winapi) BOOL;
pub extern "kernel32" fn VirtualAlloc(lpAddress: ?LPVOID, dwSize: SIZE_T, flAllocationType: DWORD, flProtect: DWORD) callconv(.winapi) ?LPVOID;
pub extern "kernel32" fn AttachConsole(dwProcessId: DWORD) callconv(.winapi) BOOL;
pub extern "kernel32" fn GetModuleHandleW(lpModuleName: ?LPCWSTR) callconv(.winapi) ?HMODULE;
pub extern "kernel32" fn IsDebuggerPresent() callconv(.winapi) BOOL;

pub extern "user32" fn EndPaint(hWnd: ?HWND, lpPaint: ?*const PAINTSTRUCT) callconv(.winapi) BOOL;
pub extern "user32" fn FillRect(hDC: ?HDC, lprc: ?*const RECT, hBr: ?HBRUSH) callconv(.winapi) c_int;
pub extern "user32" fn BeginPaint(hWnd: ?HWND, lpPaint: ?*PAINTSTRUCT) callconv(.winapi) ?HDC;
pub extern "user32" fn ShowWindow(hWnd: ?HWND, nCmdShow: c_int) callconv(.winapi) BOOL;
pub extern "user32" fn LoadCursorW(hInstance: ?HINSTANCE, lpCursorName: ?LPCWSTR) callconv(.winapi) ?HCURSOR;
pub extern "user32" fn MessageBoxA(hWnd: ?HWND, lpText: ?LPCSTR, lpCaption: ?LPCSTR, uType: UINT) callconv(.winapi) c_int;
pub extern "user32" fn MessageBoxW(hWnd: ?HWND, lpText: ?LPCWSTR, lpCaption: ?LPCWSTR, uType: UINT) callconv(.winapi) c_int;
pub extern "user32" fn PeekMessageW(lpMsg: ?*MSG, hWnd: ?HWND, wMsgFilterMin: UINT, wMsgFilterMax: UINT, wRemoveMsg: UINT) callconv(.winapi) BOOL;
pub extern "user32" fn GetClientRect(hWnd: ?HWND, lpRect: ?*RECT) callconv(.winapi) BOOL;
pub extern "user32" fn DefWindowProcW(hWnd: ?HWND, Msg: UINT, wParam: WPARAM, lParam: LPARAM) callconv(.winapi) LRESULT;
pub extern "user32" fn CreateWindowExW(dwExStyle: DWORD, lpClassName: ?LPCWSTR, lpWindowName: ?LPCWSTR, dwStyle: DWORD, X: c_int, Y: c_int, nWidth: c_int, nHeight: c_int, hWndParent: ?HWND, hMenu: ?HMENU, hInstance: ?HINSTANCE, lpParam: ?LPVOID) callconv(.winapi) ?HWND;
pub extern "user32" fn PostQuitMessage(nExitCode: c_int) callconv(.winapi) void;
pub extern "user32" fn DispatchMessageW(lpMsg: ?*const MSG) callconv(.winapi) LRESULT;
pub extern "user32" fn GetSystemMetrics(nIndex: c_int) c_int;
pub extern "user32" fn RegisterClassExW(lpWndClass: ?*const WNDCLASSEXW) callconv(.winapi) ATOM;
pub extern "user32" fn TranslateMessage(lpMsg: ?*const MSG) callconv(.winapi) BOOL;

pub extern "gdi32" fn TextOutA(hDc: ?HDC, x: c_int, y: c_int, lpString: ?LPCSTR, c: c_int) callconv(.winapi) BOOL;
pub extern "gdi32" fn DeleteObject(?*anyopaque) callconv(.winapi) BOOL;
pub extern "gdi32" fn CreateSolidBrush(color: DWORD) callconv(.winapi) HBRUSH;
