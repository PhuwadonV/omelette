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

pub const WM_NULL = 0x0000;
pub const WM_CREATE = 0x0001;
pub const WM_DESTROY = 0x0002;
pub const WM_PAINT = 0x000F;
pub const WM_QUIT = 0x0012;
pub const WM_ACTIVATEAPP = 0x001C;
pub const WM_NCMOUSEMOVE = 0x00A0;
pub const WM_MOUSEMOVE = 0x0200;

pub const WM_LBUTTONUP = 0x0202;
pub const WM_RBUTTONUP = 0x0205;
pub const WM_MBUTTONUP = 0x0208;
pub const WM_NCHITTEST = 0x0084;
pub const WM_SETCURSOR = 0x0020;
pub const WM_ACTIVATE = 0x0006;
pub const WM_NCACTIVATE = 0x0086;
pub const WM_GETICON = 0x007F;
pub const WM_WINDOWPOSCHANGED = 0x0047;
pub const WM_MOUSEACTIVATE = 0x0021;
pub const WM_WINDOWPOSCHANGING = 0x0046;
pub const WM_NCMOUSELEAVE = 0x02A2;
pub const WM_KILLFOCUS = 0x0008;
pub const WM_IME_SETCONTEXT = 0x0281;
pub const WM_GETMINMAXINFO = 0x0024;
pub const WM_DWMNCRENDERINGCHANGED = 0x031F;
pub const WM_NCCALCSIZE = 0x0083;
pub const WM_SHOWWINDOW = 0x0018;
pub const WM_NCCREATE = 0x0081;
pub const WM_ERASEBKGND = 0x0014;
pub const WM_NCPAINT = 0x0085;
pub const WM_IME_NOTIFY = 0x0282;
pub const WM_SETFOCUS = 0x0007;
pub const WM_SIZE = 0x0005;
pub const WM_MOVE = 0x0003;
pub const WM_NCLBUTTONDOWN = 0x00A1;
pub const WM_NCLBUTTONUP = 0x00A2;
pub const WM_SYSCOMMAND = 0x0112;
pub const WM_CAPTURECHANGED = 0x0215;
pub const WM_CLOSE = 0x0010;
pub const WM_UAHDESTROYWINDOW = 0x0090;
pub const WM_IME_REQUEST = 0x0288;
pub const WM_LBUTTONDOWN = 0x0201;
pub const WM_ENTERSIZEMOVE = 0x0231;
pub const WM_EXITSIZEMOVE = 0x0232;
pub const WM_QUERYOPEN = 0x0013;
pub const WM_CANCELMODE = 0x001F;
pub const WM_IME_CHAR = 0x0216;
pub const WM_KEYUP = 0x0101;
pub const WM_NCRBUTTONDOWN = 0x00A4;
pub const WM_NCRBUTTONUP = 0x00A5;
pub const WM_NCRBUTTONDBLCLK = 0x00A7;
pub const WM_NCMBUTTONDOWN = 0x00A8;
pub const WM_CONTEXTMENU = 0x007B;
pub const WM_NCXBUTTONDOWN = 0x00AE;
pub const WM_ENTERMENULOOP = 0x0211;
pub const WM_EXITMENULOOP = 0x0212;
pub const WM_MENUCHAR = 0x011F;
pub const WM_INITMENU = 0x0116;
pub const WM_CHAR = 0x0102;
pub const WM_GETDLGCODE = 0x0087;
pub const WM_NCLBUTTONDBLCLK = 0x00A3;
pub const WM_INITMENUPOPUP = 0x0117;
pub const WM_NCMBUTTONUP = 0x00A6;
pub const WM_SYSKEYDOWN = 0x0104;
pub const WM_LBUTTONDBLCLK = 0x0203;
pub const WM_KEYDOWN = 0x0100;
pub const WM_RBUTTONDOWN = 0x0204;
