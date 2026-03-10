const std = @import("std");
const unicode = std.unicode;
const windows = std.os.windows;
const kernel32 = windows.kernel32;

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

const WNDPROC = *const fn (hWnd: ?HWND, uMsg: UINT, wParam: WPARAM, lParam: LPARAM) callconv(.winapi) LRESULT;

const WNDCLASSEXW = extern struct {
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

pub const MSG = extern struct {
    hWnd: ?HWND,
    message: UINT,
    wParam: WPARAM,
    lParam: LPARAM,
    time: DWORD,
    pt: POINT,
    lPrivate: DWORD,
};

const GetModuleHandleW = kernel32.GetModuleHandleW;
const utf8ToUtf16LeStringLiteral = unicode.utf8ToUtf16LeStringLiteral;

extern "user32" fn ShowWindow(hWnd: ?HWND, nCmdShow: c_int) callconv(.winapi) BOOL;
extern "user32" fn LoadCursorW(hInstance: ?HINSTANCE, lpCursorName: ?LPCWSTR) callconv(.winapi) ?HCURSOR;
extern "user32" fn PeekMessageW(lpMsg: ?*MSG, hWnd: ?HWND, wMsgFilterMin: UINT, wMsgFilterMax: UINT, wRemoveMsg: UINT) callconv(.winapi) BOOL;
extern "user32" fn DefWindowProcW(hWnd: ?HWND, Msg: UINT, wParam: WPARAM, lParam: LPARAM) callconv(.winapi) LRESULT;
extern "user32" fn CreateWindowExW(dwExStyle: DWORD, lpClassName: ?LPCWSTR, lpWindowName: ?LPCWSTR, dwStyle: DWORD, X: c_int, Y: c_int, nWidth: c_int, nHeight: c_int, hWndParent: ?HWND, hMenu: ?HMENU, hInstance: ?HINSTANCE, lpParam: ?LPVOID) callconv(.winapi) ?HWND;
extern "user32" fn PostQuitMessage(nExitCode: c_int) callconv(.winapi) void;
extern "user32" fn DispatchMessageW(lpMsg: ?*const MSG) callconv(.winapi) LRESULT;
extern "user32" fn RegisterClassExW(lpWndClass: ?*const WNDCLASSEXW) callconv(.winapi) ATOM;
extern "user32" fn TranslateMessage(lpMsg: ?*const MSG) callconv(.winapi) BOOL;

pub fn main() void {
    const CS_VREDRAW = 0x0001;
    const CS_HREDRAW = 0x0002;
    const CS_DBLCLKS = 0x0008;

    const IDC_ARROW = 0x7F00;

    const COLOR_WINDOW = 5;

    const WS_MAXIMIZEBOX = 0x00010000;
    const WS_MINIMIZEBOX = 0x00020000;
    const WS_SYSMENU = 0x00080000;

    const CW_USEDEFAULT = 0x80000000;

    const SW_SHOWDEFAULT = 10;

    const className = utf8ToUtf16LeStringLiteral("Omelette");
    const windowName = utf8ToUtf16LeStringLiteral("Omelette");

    const hInstance: ?HINSTANCE = @ptrCast(GetModuleHandleW(null));

    const wcex = WNDCLASSEXW{
        .cbSize = @sizeOf(WNDCLASSEXW),
        .style = CS_HREDRAW | CS_VREDRAW | CS_DBLCLKS,
        .lpfnWndProc = wndproc,
        .cbClsExtra = 0,
        .cbWndExtra = 0,
        .hInstance = hInstance,
        .hIcon = null,
        .hCursor = LoadCursorW(null, @ptrFromInt(IDC_ARROW)),
        .hbrBackground = @ptrFromInt(COLOR_WINDOW),
        .lpszMenuName = null,
        .lpszClassName = className,
        .hIconSm = null,
    };

    _ = RegisterClassExW(&wcex);

    const hWnd = CreateWindowExW(
        0,
        className,
        windowName,
        WS_SYSMENU | WS_MINIMIZEBOX | WS_MAXIMIZEBOX,
        @bitCast(@as(c_uint, CW_USEDEFAULT)),
        @bitCast(@as(c_uint, CW_USEDEFAULT)),
        @bitCast(@as(c_uint, CW_USEDEFAULT)),
        @bitCast(@as(c_uint, CW_USEDEFAULT)),
        null,
        null,
        hInstance,
        null,
    );

    const PM_REMOVE = 0x0001;
    const WM_QUIT = 0x0012;

    _ = ShowWindow(hWnd, SW_SHOWDEFAULT);

    var msg: MSG = undefined;
    var exit_code: WPARAM = 0;

    running: while (true) {
        while (PeekMessageW(&msg, null, 0, 0, PM_REMOVE) != 0) {
            if (msg.message == WM_QUIT) {
                exit_code = msg.wParam;
                break :running;
            }

            _ = TranslateMessage(&msg);
            _ = DispatchMessageW(&msg);
        }
    }
}

fn wndproc(hWnd: ?HWND, uMsg: UINT, wParam: WPARAM, lParam: LPARAM) callconv(.winapi) LRESULT {
    const WM_DESTROY = 0x0002;

    if (uMsg == WM_DESTROY) {
        PostQuitMessage(0);
    }

    return DefWindowProcW(hWnd, uMsg, wParam, lParam);
}
