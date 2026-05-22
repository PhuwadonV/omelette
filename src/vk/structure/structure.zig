const vk = @import("../vk.zig");

pub const LayerProperties = extern struct {
    layerName: [vk.MAX_EXTENSION_NAME_SIZE]u8,
    specVersion: u32,
    implementationVersion: u32,
    description: [vk.MAX_DESCRIPTION_SIZE]u8,
};

pub const ExtensionProperties = extern struct {
    extensionName: [vk.MAX_EXTENSION_NAME_SIZE]u8,
    specVersion: u32,
};

pub const ApplicationInfo = extern struct {
    sType: vk.StructureType,
    pNext: ?*const anyopaque,
    pApplicationName: ?[*:0]const u8,
    applicationVersion: u32,
    pEngineName: ?[*:0]const u8,
    engineVersion: u32,
    apiVersion: u32,
};

pub const InstanceCreateInfo = extern struct {
    sType: vk.StructureType,
    pNext: ?*const anyopaque,
    flags: vk.InstanceCreateFlags,
    pApplicationInfo: ?*const ApplicationInfo,
    enabledLayerCount: u32,
    ppEnabledLayerNames: ?[*]const [*:0]const u8,
    enabledExtensionCount: u32,
    ppEnabledExtensionNames: ?[*]const [*:0]const u8,
};

pub const AllocationCallbacks = extern struct {
    pUserData: ?*anyopaque,
    pfnAllocation: vk.PFN_vkAllocationFunction,
    pfnReallocation: vk.PFN_vkReallocationFunction,
    pfnFree: vk.PFN_vkFreeFunction,
    pfnInternalAllocation: ?vk.PFN_vkInternalAllocationNotification,
    pfnInternalFree: ?vk.PFN_vkInternalFreeNotification,
};
