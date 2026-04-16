const std = @import("std");
const windows = std.os.windows;
const kernel32 = windows.kernel32;

pub const HDC = windows.HDC;
pub const ATOM = windows.ATOM;
pub const BOOL = windows.BOOL;
pub const BYTE = windows.BYTE;
pub const HWND = windows.HWND;
pub const RECT = windows.RECT;
pub const UINT = windows.UINT;
pub const DWORD = windows.DWORD;
pub const HICON = windows.HICON;
pub const HMENU = windows.HMENU;
pub const POINT = windows.POINT;
pub const HBRUSH = windows.HBRUSH;
pub const LPARAM = windows.LPARAM;
pub const LPCSTR = windows.LPCSTR;
pub const LPVOID = windows.LPVOID;
pub const WPARAM = windows.WPARAM;
pub const HCURSOR = windows.HCURSOR;
pub const LPCWSTR = windows.LPCWSTR;
pub const LRESULT = windows.LRESULT;
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
pub const MB_YESNO = 0x00000004;
pub const MB_ICONERROR = 0x00000010;

pub const IDNO = 7;

pub const IDC_ARROW = 0x7F00;

pub const SM_CXSCREEN = 0;
pub const SM_CYSCREEN = 1;

pub const PM_REMOVE = 0x0001;

pub const SW_SHOWDEFAULT = 10;

pub const WS_EX_APPWINDOW = 0x00040000;
pub const WS_POPUP = 0x80000000;

pub const WM_NULL = 0x0000;
pub const WM_CREATE = 0x0001;
pub const WM_DESTROY = 0x0002;
pub const WM_MOVE = 0x0003;
pub const WM_SIZE = 0x0005;
pub const WM_ACTIVATE = 0x0006;
pub const WM_SETFOCUS = 0x0007;
pub const WM_KILLFOCUS = 0x0008;
pub const WM_PAINT = 0x000F;
pub const WM_CLOSE = 0x0010;
pub const WM_QUERYENDSESSION = 0x0011;
pub const WM_QUIT = 0x0012;
pub const WM_ERASEBKGND = 0x0014;
pub const WM_ENDSESSION = 0x0016;
pub const WM_SHOWWINDOW = 0x0018;
pub const WM_ACTIVATEAPP = 0x001C;
pub const WM_TIMECHANGE = 0x001E;
pub const WM_SETCURSOR = 0x0020;
pub const WM_MOUSEACTIVATE = 0x0021;
pub const WM_WINDOWPOSCHANGING = 0x0046;
pub const WM_WINDOWPOSCHANGED = 0x0047;
pub const WM_NOTIFY = 0x004D;
pub const WM_INPUTLANGCHANGE = 0x0051;
pub const WM_HELP = 0x0053;
pub const WM_CONTEXTMENU = 0x007B;
pub const WM_DISPLAYCHANGE = 0x007E;
pub const WM_GETICON = 0x007F;
pub const WM_NCCREATE = 0x0081;
pub const WM_NCDESTROY = 0x0082;
pub const WM_NCCALCSIZE = 0x0083;
pub const WM_NCHITTEST = 0x0084;
pub const WM_NCPAINT = 0x0085;
pub const WM_NCACTIVATE = 0x0086;
pub const WM_UAHDESTROYWINDOW = 0x0090;
pub const WM_INPUT = 0x00FF;
pub const WM_KEYDOWN = 0x0100;
pub const WM_KEYUP = 0x0101;
pub const WM_CHAR = 0x0102;
pub const WM_SYSKEYDOWN = 0x0104;
pub const WM_SYSKEYUP = 0x0105;
pub const WM_SYSCHAR = 0x0106;
pub const WM_SYSCOMMAND = 0x0112;
pub const WM_MOUSEMOVE = 0x0200;
pub const WM_LBUTTONDOWN = 0x0201;
pub const WM_LBUTTONUP = 0x0202;
pub const WM_RBUTTONDOWN = 0x0204;
pub const WM_RBUTTONUP = 0x0205;
pub const WM_MBUTTONDOWN = 0x0207;
pub const WM_MBUTTONUP = 0x0208;
pub const WM_MOUSEWHEEL = 0x020A;
pub const WM_XBUTTONDOWN = 0x020B;
pub const WM_XBUTTONUP = 0x020C;
pub const WM_CAPTURECHANGED = 0x0215;
pub const WM_MENUDRAG = 0x0218;
pub const WM_MENUGETOBJECT = 0x0219;
pub const WM_IME_SETCONTEXT = 0x0281;
pub const WM_IME_NOTIFY = 0x0282;
pub const WM_IME_REQUEST = 0x0288;
pub const WM_MOUSELEAVE = 0x02A3;
pub const WM_DPICHANGED = 0x02E0;
pub const WM_APPCOMMAND = 0x0319;
pub const WM_DWMCOLORIZATIONCOLORCHANGED = 0x0320;

pub const ExitProcess = kernel32.ExitProcess;
pub const GetModuleHandleW = kernel32.GetModuleHandleW;

pub extern "user32" fn EndPaint(hWnd: ?HWND, lpPaint: ?*const PAINTSTRUCT) callconv(.winapi) BOOL;
pub extern "user32" fn FillRect(hDC: ?HDC, lprc: ?*const RECT, hBr: ?HBRUSH) c_int;
pub extern "user32" fn BeginPaint(hWnd: ?HWND, lpPaint: ?*PAINTSTRUCT) callconv(.winapi) ?HDC;
pub extern "user32" fn ShowWindow(hWnd: ?HWND, nCmdShow: c_int) callconv(.winapi) BOOL;
pub extern "user32" fn LoadCursorW(hInstance: ?HINSTANCE, lpCursorName: ?LPCWSTR) callconv(.winapi) ?HCURSOR;
pub extern "user32" fn MessageBoxA(hWnd: ?HWND, lpText: ?LPCSTR, lpCaption: ?LPCSTR, uType: UINT) callconv(.winapi) c_int;
pub extern "user32" fn MessageBoxW(hWnd: ?HWND, lpText: ?LPCWSTR, lpCaption: ?LPCWSTR, uType: UINT) callconv(.winapi) c_int;
pub extern "user32" fn PeekMessageW(lpMsg: ?*MSG, hWnd: ?HWND, wMsgFilterMin: UINT, wMsgFilterMax: UINT, wRemoveMsg: UINT) callconv(.winapi) BOOL;
pub extern "user32" fn GetClientRect(hWnd: ?HWND, lpRect: ?*const RECT) BOOL;
pub extern "user32" fn DefWindowProcW(hWnd: ?HWND, Msg: UINT, wParam: WPARAM, lParam: LPARAM) callconv(.winapi) LRESULT;
pub extern "user32" fn CreateWindowExW(dwExStyle: DWORD, lpClassName: ?LPCWSTR, lpWindowName: ?LPCWSTR, dwStyle: DWORD, X: c_int, Y: c_int, nWidth: c_int, nHeight: c_int, hWndParent: ?HWND, hMenu: ?HMENU, hInstance: ?HINSTANCE, lpParam: ?LPVOID) callconv(.winapi) ?HWND;
pub extern "user32" fn PostQuitMessage(nExitCode: c_int) callconv(.winapi) void;
pub extern "user32" fn DispatchMessageW(lpMsg: ?*const MSG) callconv(.winapi) LRESULT;
pub extern "user32" fn GetSystemMetrics(nIndex: c_int) c_int;
pub extern "user32" fn RegisterClassExW(lpWndClass: ?*const WNDCLASSEXW) callconv(.winapi) ATOM;
pub extern "user32" fn TranslateMessage(lpMsg: ?*const MSG) callconv(.winapi) BOOL;

pub extern "gdi32" fn TextOutW(hDc: ?HDC, x: c_int, y: c_int, lpString: ?LPCWSTR, c: c_int) callconv(.winapi) BOOL;
pub extern "gdi32" fn DeleteObject(?*anyopaque) callconv(.winapi) BOOL;
pub extern "gdi32" fn CreateSolidBrush(color: DWORD) callconv(.winapi) HBRUSH;
