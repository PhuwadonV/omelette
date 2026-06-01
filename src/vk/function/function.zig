const vk = @import("../vk.zig");

pub const enumerateInstanceVersion = @extern(
    *const fn (pApiVersion: *u32) callconv(.winapi) vk.Result,
    .{
        .name = "vkEnumerateInstanceVersion",
    },
);

pub const enumerateInstanceLayerProperties = @extern(
    *const fn (pPropertyCount: *u32, pProperties: ?*vk.LayerProperties) callconv(.winapi) vk.Result,
    .{
        .name = "vkEnumerateInstanceLayerProperties",
    },
);

pub const enumerateInstanceExtensionProperties = @extern(
    *const fn (pLayerName: ?[*:0]const u8, pPropertyCount: *u32, pProperties: ?*vk.ExtensionProperties) callconv(.winapi) vk.Result,
    .{
        .name = "vkEnumerateInstanceExtensionProperties",
    },
);

pub const createInstance = @extern(
    *const fn (pCreateInfo: *const vk.InstanceCreateInfo, pAllocator: ?*const vk.AllocationCallbacks, pInstance: *vk.Instance) callconv(.winapi) vk.Result,
    .{
        .name = "vkCreateInstance",
    },
);

pub const getInstanceProcAddr = @extern(
    *const fn (instance: vk.Instance, pName: ?[*:0]const u8) callconv(.winapi) ?vk.PFN_VoidFunction,
    .{
        .name = "vkGetInstanceProcAddr",
    },
);
