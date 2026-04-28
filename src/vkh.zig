const vk = @import("vk.zig");

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

pub fn translateError(result: vk.VkResult) Error {
    return switch (result) {
        .VK_ERROR_OUT_OF_HOST_MEMORY => error.VkOutOfHostMemory,
        .VK_ERROR_OUT_OF_DEVICE_MEMORY => error.VkOutOfDeviceMemory,
        .VK_ERROR_INITIALIZATION_FAILED => error.VkInitializationFailed,
        .VK_ERROR_DEVICE_LOST => error.VkDeviceLost,
        .VK_ERROR_MEMORY_MAP_FAILED => error.VkMemoryMapFailed,
        .VK_ERROR_LAYER_NOT_PRESENT => error.VkLayerNotPresent,
        .VK_ERROR_EXTENSION_NOT_PRESENT => error.VkExtensionNotPresent,
        .VK_ERROR_FEATURE_NOT_PRESENT => error.VkFeatureNotPresent,
        .VK_ERROR_INCOMPATIBLE_DRIVER => error.VkIncompatibleDriver,
        .VK_ERROR_TOO_MANY_OBJECTS => error.VkTooManyObjects,
        .VK_ERROR_FORMAT_NOT_SUPPORTED => error.VkFormatNotSupported,
        .VK_ERROR_FRAGMENTED_POOL => error.VkFragmentedPool,
        .VK_ERROR_UNKNOWN => error.VkUnknown,
        .VK_ERROR_VALIDATION_FAILED => error.VkValidationFailed,
        .VK_ERROR_OUT_OF_POOL_MEMORY => error.VkOutOfPoolMemory,
        .VK_ERROR_INVALID_EXTERNAL_HANDLE => error.VkInvalidExternalHandle,
        .VK_ERROR_FRAGMENTATION => error.VkFragmentation,
        .VK_ERROR_INVALID_OPAQUE_CAPTURE_ADDRESS => error.VkInvalidOpaqueCaptureAddress,
        .VK_ERROR_NOT_PERMITTED => error.VkNotPermitted,
        .VK_ERROR_SURFACE_LOST_KHR => error.VkSurfaceLostKhr,
        .VK_ERROR_NATIVE_WINDOW_IN_USE_KHR => error.VkNativeWindowInUseKhr,
        .VK_ERROR_OUT_OF_DATE_KHR => error.VkOutOfDateKhr,
        .VK_ERROR_INCOMPATIBLE_DISPLAY_KHR => error.VkIncompatibleDisplayKhr,
        .VK_ERROR_IMAGE_USAGE_NOT_SUPPORTED_KHR => error.VkImageUsageNotSupportedKhr,
        .VK_ERROR_VIDEO_PICTURE_LAYOUT_NOT_SUPPORTED_KHR => error.VkVideoPictureLayoutNotSupportedKhr,
        .VK_ERROR_VIDEO_PROFILE_OPERATION_NOT_SUPPORTED_KHR => error.VkVideoProfileOperationNotSupportedKhr,
        .VK_ERROR_VIDEO_PROFILE_FORMAT_NOT_SUPPORTED_KHR => error.VkVideoProfileFormatNotSupportedKhr,
        .VK_ERROR_VIDEO_PROFILE_CODEC_NOT_SUPPORTED_KHR => error.VkVideoProfileCodecNotSupportedKhr,
        .VK_ERROR_VIDEO_STD_VERSION_NOT_SUPPORTED_KHR => error.VkVideoStdVersionNotSupportedKhr,
        .VK_ERROR_INVALID_DRM_FORMAT_MODIFIER_PLANE_LAYOUT_EXT => error.VkInvalidDrmFormatModifierPlaneLayoutExt,
        .VK_ERROR_FULL_SCREEN_EXCLUSIVE_MODE_LOST_EXT => error.VkFullScreenExclusiveModeLostExt,
        .VK_ERROR_INVALID_VIDEO_STD_PARAMETERS_KHR => error.VkInvalidVideoStdParametersKhr,
        .VK_ERROR_COMPRESSION_EXHAUSTED_EXT => error.VkCompressionExhaustedExt,
        .VK_ERROR_NOT_ENOUGH_SPACE_KHR => error.VkNotEnoughSpaceKhr,
        else => error.VkUnhandled,
    };
}

pub inline fn wrapResult(result: vk.VkResult) Error!vk.VkResult {
    if (@intFromEnum(result) >= 0) {
        @branchHint(.likely);
        return result;
    } else {
        @branchHint(.unlikely);
        return translateError(result);
    }
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

    _ = try wrapResult(vk.vkEnumerateInstanceVersion(&version));

    return translateApiVersion(version);
}
