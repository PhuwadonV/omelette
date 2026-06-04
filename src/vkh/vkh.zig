const vk = root.vk;
const root = @import("root");

pub const Error = error{
    VkUnhandled,
    VkOutOfHostMemory,
    VkOutOfDeviceMemory,
    VkInitializationFailed,
    VkDeviceLost,
    VkMemoryMapFailed,
    VkLayerNotPresent,
    VkExtensionNotPresent,
    VkFeatureNotPresent,
    VkIncompatibleDriver,
    VkTooManyObjects,
    VkFormatNotSupported,
    VkFragmentedPool,
    VkUnknown,
    VkValidationFailed,
    VkOutOfPoolMemory,
    VkInvalidExternalHandle,
    VkFragmentation,
    VkInvalidOpaqueCaptureAddress,
    VkNotPermitted,
    VkSurfaceLostKhr,
    VkNativeWindowInUseKhr,
    VkOutOfDateKhr,
    VkIncompatibleDisplayKhr,
    VkImageUsageNotSupportedKhr,
    VkVideoPictureLayoutNotSupportedKhr,
    VkVideoProfileOperationNotSupportedKhr,
    VkVideoProfileFormatNotSupportedKhr,
    VkVideoProfileCodecNotSupportedKhr,
    VkVideoStdVersionNotSupportedKhr,
    VkInvalidDrmFormatModifierPlaneLayoutExt,
    VkFullScreenExclusiveModeLostExt,
    VkInvalidVideoStdParametersKhr,
    VkCompressionExhaustedExt,
    VkNotEnoughSpaceKhr,
};

pub const Version = extern struct {
    variant: u32,
    major: u32,
    minor: u32,
    patch: u32,
};

pub const InstanceProcs = struct {
    vkEnumeratePhysicalDevices: vk.PFN_EnumeratePhysicalDevices,
    vkGetPhysicalDeviceProperties: vk.PFN_GetPhysicalDeviceProperties,
};

pub fn translateError(result: vk.Result) Error {
    return switch (result) {
        .ERROR_OUT_OF_HOST_MEMORY => error.VkOutOfHostMemory,
        .ERROR_OUT_OF_DEVICE_MEMORY => error.VkOutOfDeviceMemory,
        .ERROR_INITIALIZATION_FAILED => error.VkInitializationFailed,
        .ERROR_DEVICE_LOST => error.VkDeviceLost,
        .ERROR_MEMORY_MAP_FAILED => error.VkMemoryMapFailed,
        .ERROR_LAYER_NOT_PRESENT => error.VkLayerNotPresent,
        .ERROR_EXTENSION_NOT_PRESENT => error.VkExtensionNotPresent,
        .ERROR_FEATURE_NOT_PRESENT => error.VkFeatureNotPresent,
        .ERROR_INCOMPATIBLE_DRIVER => error.VkIncompatibleDriver,
        .ERROR_TOO_MANY_OBJECTS => error.VkTooManyObjects,
        .ERROR_FORMAT_NOT_SUPPORTED => error.VkFormatNotSupported,
        .ERROR_FRAGMENTED_POOL => error.VkFragmentedPool,
        .ERROR_UNKNOWN => error.VkUnknown,
        .ERROR_VALIDATION_FAILED => error.VkValidationFailed,
        .ERROR_OUT_OF_POOL_MEMORY => error.VkOutOfPoolMemory,
        .ERROR_INVALID_EXTERNAL_HANDLE => error.VkInvalidExternalHandle,
        .ERROR_FRAGMENTATION => error.VkFragmentation,
        .ERROR_INVALID_OPAQUE_CAPTURE_ADDRESS => error.VkInvalidOpaqueCaptureAddress,
        .ERROR_NOT_PERMITTED => error.VkNotPermitted,
        .ERROR_SURFACE_LOST_KHR => error.VkSurfaceLostKhr,
        .ERROR_NATIVE_WINDOW_IN_USE_KHR => error.VkNativeWindowInUseKhr,
        .ERROR_OUT_OF_DATE_KHR => error.VkOutOfDateKhr,
        .ERROR_INCOMPATIBLE_DISPLAY_KHR => error.VkIncompatibleDisplayKhr,
        .ERROR_IMAGE_USAGE_NOT_SUPPORTED_KHR => error.VkImageUsageNotSupportedKhr,
        .ERROR_VIDEO_PICTURE_LAYOUT_NOT_SUPPORTED_KHR => error.VkVideoPictureLayoutNotSupportedKhr,
        .ERROR_VIDEO_PROFILE_OPERATION_NOT_SUPPORTED_KHR => error.VkVideoProfileOperationNotSupportedKhr,
        .ERROR_VIDEO_PROFILE_FORMAT_NOT_SUPPORTED_KHR => error.VkVideoProfileFormatNotSupportedKhr,
        .ERROR_VIDEO_PROFILE_CODEC_NOT_SUPPORTED_KHR => error.VkVideoProfileCodecNotSupportedKhr,
        .ERROR_VIDEO_STD_VERSION_NOT_SUPPORTED_KHR => error.VkVideoStdVersionNotSupportedKhr,
        .ERROR_INVALID_DRM_FORMAT_MODIFIER_PLANE_LAYOUT_EXT => error.VkInvalidDrmFormatModifierPlaneLayoutExt,
        .ERROR_FULL_SCREEN_EXCLUSIVE_MODE_LOST_EXT => error.VkFullScreenExclusiveModeLostExt,
        .ERROR_INVALID_VIDEO_STD_PARAMETERS_KHR => error.VkInvalidVideoStdParametersKhr,
        .ERROR_COMPRESSION_EXHAUSTED_EXT => error.VkCompressionExhaustedExt,
        .ERROR_NOT_ENOUGH_SPACE_KHR => error.VkNotEnoughSpaceKhr,
        else => error.VkUnhandled,
    };
}

pub inline fn wrapResult(result: vk.Result) Error!vk.Result {
    if (@intFromEnum(result) >= 0) {
        @branchHint(.likely);
        return result;
    } else {
        @branchHint(.unlikely);
        return translateError(result);
    }
}

pub inline fn makeApiVersion(variant: u3, major: u7, minor: u10, patch: u12) u32 {
    return @as(u32, @intCast(variant)) << 29 |
        @as(u32, @intCast(major)) << 22 |
        @as(u32, @intCast(minor)) << 12 |
        @as(u32, @intCast(patch));
}

pub fn translateApiVersion(api_version: u32) Version {
    return .{
        .variant = api_version >> 29,
        .major = (api_version >> 22) & 0x7F,
        .minor = (api_version >> 12) & 0x3FF,
        .patch = api_version & 0xFFF,
    };
}

pub fn getApiVersion() !Version {
    var version: u32 = undefined;

    _ = try wrapResult(vk.enumerateInstanceVersion(&version));

    return translateApiVersion(version);
}

pub fn getInstanceProcs(vk_instance: vk.Instance) !InstanceProcs {
    var instance_procs: InstanceProcs = undefined;

    inline for (@typeInfo(InstanceProcs).@"struct".fields) |field| {
        @field(instance_procs, field.name) =
            @ptrCast(vk.getInstanceProcAddr(vk_instance, field.name) orelse
                return @field(anyerror, "RequiredProcV" ++ field.name[1..field.name.len]));
    }

    return instance_procs;
}
