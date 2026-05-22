const vk = root.vk;
const std = @import("std");
const vkh = root.vkh;
const wnd = root.wnd;
const root = @import("root");
const spec = @import("spec.zig");

const App = root.App;

pub fn createVkInstance() !vk.Instance {
    const vk_application_info = vk.ApplicationInfo{
        .sType = .APPLICATION_INFO,
        .pNext = null,
        .pApplicationName = App.spec.getAppName(),
        .applicationVersion = App.spec.getAppVersion(),
        .pEngineName = App.spec.getEngineName(),
        .engineVersion = App.spec.getEngineVersion(),
        .apiVersion = spec.getRequiredVulkanApiVersion(),
    };

    var vk_instance_create_info = vk.InstanceCreateInfo{
        .sType = .INSTANCE_CREATE_INFO,
        .pNext = null,
        .flags = 0,
        .pApplicationInfo = &vk_application_info,
        .enabledLayerCount = @intCast(spec.getRequiredVulkanLayer().len),
        .ppEnabledLayerNames = spec.getRequiredVulkanLayer().ptr,
        .enabledExtensionCount = @intCast(spec.getRequiredVulkanExtension().len),
        .ppEnabledExtensionNames = spec.getRequiredVulkanExtension().ptr,
    };

    var vk_instance: vk.Instance = undefined;
    _ = try vkh.wrapResult(vk.createInstance(&vk_instance_create_info, null, &vk_instance));

    return vk_instance;
}

pub fn renderBackground(hWnd: ?wnd.HWND, hDc: ?wnd.HDC, hBr: ?wnd.HBRUSH) void {
    var rect: wnd.RECT = undefined;

    _ = wnd.GetClientRect(hWnd, &rect);
    _ = wnd.FillRect(hDc, &rect, hBr);
}

pub fn renderVkApiVersion(hDc: ?wnd.HDC) void {
    var buffer: [128]u8 = undefined;

    const vk_version = vkh.getApiVersion() catch return;

    const format =
        \\Variant = {d}, 
        \\Major = {d}, 
        \\Minor = {d}, 
        \\Patch = {d}
    ;

    renderText(
        hDc,
        std.fmt.bufPrintSentinel(
            &buffer,
            format,
            .{
                vk_version.variant,
                vk_version.major,
                vk_version.minor,
                vk_version.patch,
            },
            0,
        ) catch return,
    );
}

fn renderText(hDc: ?wnd.HDC, text: [:0]const u8) void {
    _ = wnd.TextOutA(hDc, 0, 0, text, @intCast(text.len));
}
