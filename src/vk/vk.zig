comptime {
    debug.assert(builtin.target.ptrBitWidth() == 64);
}

const std = @import("std");
const debug = std.debug;
const builtin = @import("builtin");
const constant = @import("constant/constant.zig");
const function = @import("function/function.zig");
const structure = @import("structure/structure.zig");

// VK_VERSION_1_0
pub const TRUE = @as(u32, 1);
pub const FALSE = @as(u32, 0);
pub const UUID_SIZE = @as(u32, 16);
pub const WHOLE_SIZE = ~@as(u64, 0);
pub const LOD_CLAMP_NONE = 1000.0;
pub const MAX_MEMORY_HEAPS = @as(u32, 16);
pub const SUBPASS_EXTERNAL = ~@as(u32, 0);
pub const MAX_MEMORY_TYPES = @as(u32, 32);
pub const ATTACHMENT_UNUSED = ~@as(u32, 0);
pub const MAX_DESCRIPTION_SIZE = @as(u32, 256);
pub const REMAINING_MIP_LEVELS = ~@as(u32, 0);
pub const QUEUE_FAMILY_IGNORED = ~@as(u32, 0);
pub const REMAINING_ARRAY_LAYERS = ~@as(u32, 0);
pub const MAX_EXTENSION_NAME_SIZE = @as(u32, 256);
pub const MAX_PHYSICAL_DEVICE_NAME_SIZE = @as(u32, 256);

// VK_VERSION_1_1
const LUID_SIZE = @as(u32, 8);
const MAX_DEVICE_GROUP_SIZE = @as(u32, 32);
const QUEUE_FAMILY_EXTERNAL = ~@as(u32, 1);

// VK_VERSION_1_2
const MAX_DRIVER_NAME_SIZE = @as(u32, 256);
const MAX_DRIVER_INFO_SIZE = @as(u32, 256);

// VK_VERSION_1_4
const MAX_GLOBAL_PRIORITY_SIZE = @as(u32, 16);

// VK_VERSION_1_0
pub const Flags = u32;
pub const Bool32 = u32;
pub const DeviceSize = u64;
pub const SampleMask = u32;
pub const DeviceAddress = u64;
pub const InstanceCreateFlags = Flags;

// VK_VERSION_1_3
pub const Flags64 = u64;

// VK_VERSION_1_1 & HANDLE
pub const Queue = ?*opaque {};
pub const Device = ?*opaque {};
pub const Instance = ?*opaque {};
pub const CommandBuffer = ?*opaque {};
pub const PhysicalDevice = ?*opaque {};

// VK_VERSION_1_1 & NON_DISPATCHABLE_HANDLE
pub const Event = ?*opaque {};
pub const Fence = ?*opaque {};
pub const Image = ?*opaque {};
pub const Buffer = ?*opaque {};
pub const Sampler = ?*opaque {};
pub const Pipeline = ?*opaque {};
pub const ImageView = ?*opaque {};
pub const Semaphore = ?*opaque {};
pub const QueryPool = ?*opaque {};
pub const BufferView = ?*opaque {};
pub const RenderPass = ?*opaque {};
pub const CommandPool = ?*opaque {};
pub const Framebuffer = ?*opaque {};
pub const DeviceMemory = ?*opaque {};
pub const ShaderModule = ?*opaque {};
pub const DescriptorSet = ?*opaque {};
pub const PipelineCache = ?*opaque {};
pub const DescriptorPool = ?*opaque {};
pub const PipelineLayout = ?*opaque {};
pub const DescriptorSetLayout = ?*opaque {};

// VK_VERSION_1_1
pub const SamplerYcbcrConversion = ?*opaque {};
pub const DescriptorUpdateTemplate = ?*opaque {};

// VK_VERSION_1_3
pub const PrivateDataSlot = ?*opaque {};

// VK_VERSION_1_0
pub const Result = constant.Result;
pub const StructureType = constant.StructureType;
pub const PhysicalDeviceType = constant.PhysicalDeviceType;
pub const SystemAllocationScope = constant.SystemAllocationScope;
pub const InternalAllocationType = constant.InternalAllocationType;
pub const SampleCountFlags = Flags;

// VK_VERSION_1_0
pub const ApplicationInfo = structure.ApplicationInfo;
pub const LayerProperties = structure.LayerProperties;
pub const InstanceCreateInfo = structure.InstanceCreateInfo;
pub const AllocationCallbacks = structure.AllocationCallbacks;
pub const ExtensionProperties = structure.ExtensionProperties;
pub const PhysicalDeviceLimits = structure.PhysicalDeviceLimits;
pub const PhysicalDeviceProperties = structure.PhysicalDeviceProperties;
pub const PhysicalDeviceSparseProperties = structure.PhysicalDeviceSparseProperties;

// VK_VERSION_1_0 & PFN
pub const PFN_FreeFunction = *const fn (pUserData: ?*anyopaque, pMemory: ?*anyopaque) callconv(.winapi) void;
pub const PFN_VoidFunction = *const fn () callconv(.winapi) void;
pub const PFN_AllocationFunction = *const fn (pUserData: ?*anyopaque, size: usize, alignment: usize, allocationScope: SystemAllocationScope) callconv(.winapi) ?*anyopaque;
pub const PFN_ReallocationFunction = *const fn (pUserData: ?*anyopaque, pOriginal: ?*anyopaque, size: usize, alignment: usize, allocationScope: SystemAllocationScope) callconv(.winapi) ?*anyopaque;
pub const PFN_InternalFreeNotification = *const fn (pUserData: ?*anyopaque, size: usize, allocationType: InternalAllocationType, allocationScope: SystemAllocationScope) callconv(.winapi) void;
pub const PFN_InternalAllocationNotification = *const fn (pUserData: ?*anyopaque, size: usize, allocationType: InternalAllocationType, allocationScope: SystemAllocationScope) callconv(.winapi) void;

// VK_VERSION_1_0 & PFN Instance
pub const PFN_EnumeratePhysicalDevices = *const fn (instance: Instance, pPhysicalDeviceCount: *u32, pPhysicalDevices: ?*PhysicalDevice) callconv(.winapi) Result;
pub const PFN_GetPhysicalDeviceProperties = *const fn (physicalDevice: PhysicalDevice, pProperties: *PhysicalDeviceProperties) callconv(.winapi) void;

// VK_VERSION_1_0
pub const enumerateInstanceVersion = function.enumerateInstanceVersion;
pub const enumerateInstanceLayerProperties = function.enumerateInstanceLayerProperties;
pub const enumerateInstanceExtensionProperties = function.enumerateInstanceExtensionProperties;

// VK_VERSION_1_0 & Instance
pub const createInstance = function.createInstance;
pub const getInstanceProcAddr = function.getInstanceProcAddr;
