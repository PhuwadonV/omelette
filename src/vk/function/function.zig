const vk = @import("../vk.zig");

pub const enumerateInstanceVersion = @extern(
    *const fn (pApiVersion: *u32) callconv(.c) vk.Result,
    .{
        .name = "vkEnumerateInstanceVersion",
    },
);

pub const enumerateInstanceLayerProperties = @extern(
    *const fn (pPropertyCount: *u32, pProperties: ?*vk.LayerProperties) callconv(.c) vk.Result,
    .{
        .name = "vkEnumerateInstanceLayerProperties",
    },
);

pub const enumerateInstanceExtensionProperties = @extern(
    *const fn (pLayerName: ?[*:0]const u8, pPropertyCount: *u32, pProperties: ?*vk.ExtensionProperties) callconv(.c) vk.Result,
    .{
        .name = "vkEnumerateInstanceExtensionProperties",
    },
);

pub const createInstance = @extern(
    *const fn (pCreateInfo: *const vk.InstanceCreateInfo, pAllocator: ?*const vk.AllocationCallbacks, pInstance: *vk.Instance) callconv(.c) vk.Result,
    .{
        .name = "vkCreateInstance",
    },
);
