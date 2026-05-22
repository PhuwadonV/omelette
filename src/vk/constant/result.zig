pub const Result = enum(c_int) {
    SUCCESS = 0,
    NOT_READY = 1,
    TIMEOUT = 2,
    EVENT_SET = 3,
    EVENT_RESET = 4,
    INCOMPLETE = 5,
    ERROR_OUT_OF_HOST_MEMORY = -1,
    ERROR_OUT_OF_DEVICE_MEMORY = -2,
    ERROR_INITIALIZATION_FAILED = -3,
    ERROR_DEVICE_LOST = -4,
    ERROR_MEMORY_MAP_FAILED = -5,
    ERROR_LAYER_NOT_PRESENT = -6,
    ERROR_EXTENSION_NOT_PRESENT = -7,
    ERROR_FEATURE_NOT_PRESENT = -8,
    ERROR_INCOMPATIBLE_DRIVER = -9,
    ERROR_TOO_MANY_OBJECTS = -10,
    ERROR_FORMAT_NOT_SUPPORTED = -11,
    ERROR_FRAGMENTED_POOL = -12,
    ERROR_UNKNOWN = -13,
    // Provided by VK_VERSION_1_0
    ERROR_VALIDATION_FAILED = -1000011001,
    // Provided by VK_VERSION_1_1
    ERROR_OUT_OF_POOL_MEMORY = -1000069000,
    // Provided by VK_VERSION_1_1
    ERROR_INVALID_EXTERNAL_HANDLE = -1000072003,
    // Provided by VK_VERSION_1_2
    ERROR_FRAGMENTATION = -1000161000,
    // Provided by VK_VERSION_1_2
    ERROR_INVALID_OPAQUE_CAPTURE_ADDRESS = -1000257000,
    // Provided by VK_VERSION_1_3
    PIPELINE_COMPILE_REQUIRED = 1000297000,
    // Provided by VK_VERSION_1_4
    ERROR_NOT_PERMITTED = -1000174001,
    // Provided by VK_KHR_surface
    ERROR_SURFACE_LOST_KHR = -1000000000,
    // Provided by VK_KHR_surface
    ERROR_NATIVE_WINDOW_IN_USE_KHR = -1000000001,
    // Provided by VK_KHR_swapchain
    SUBOPTIMAL_KHR = 1000001003,
    // Provided by VK_KHR_swapchain
    ERROR_OUT_OF_DATE_KHR = -1000001004,
    // Provided by VK_KHR_display_swapchain
    ERROR_INCOMPATIBLE_DISPLAY_KHR = -1000003001,
    // Provided by VK_KHR_video_queue
    ERROR_IMAGE_USAGE_NOT_SUPPORTED_KHR = -1000023000,
    // Provided by VK_KHR_video_queue
    ERROR_VIDEO_PICTURE_LAYOUT_NOT_SUPPORTED_KHR = -1000023001,
    // Provided by VK_KHR_video_queue
    ERROR_VIDEO_PROFILE_OPERATION_NOT_SUPPORTED_KHR = -1000023002,
    // Provided by VK_KHR_video_queue
    ERROR_VIDEO_PROFILE_FORMAT_NOT_SUPPORTED_KHR = -1000023003,
    // Provided by VK_KHR_video_queue
    ERROR_VIDEO_PROFILE_CODEC_NOT_SUPPORTED_KHR = -1000023004,
    // Provided by VK_KHR_video_queue
    ERROR_VIDEO_STD_VERSION_NOT_SUPPORTED_KHR = -1000023005,
    // Provided by VK_EXT_image_drm_format_modifier
    ERROR_INVALID_DRM_FORMAT_MODIFIER_PLANE_LAYOUT_EXT = -1000158000,
    // Provided by VK_EXT_full_screen_exclusive
    ERROR_FULL_SCREEN_EXCLUSIVE_MODE_LOST_EXT = -1000255000,
    // Provided by VK_KHR_deferred_host_operations
    THREAD_IDLE_KHR = 1000268000,
    // Provided by VK_KHR_deferred_host_operations
    THREAD_DONE_KHR = 1000268001,
    // Provided by VK_KHR_deferred_host_operations
    OPERATION_DEFERRED_KHR = 1000268002,
    // Provided by VK_KHR_deferred_host_operations
    OPERATION_NOT_DEFERRED_KHR = 1000268003,
    // Provided by VK_KHR_video_encode_queue
    ERROR_INVALID_VIDEO_STD_PARAMETERS_KHR = -1000299000,
    // Provided by VK_EXT_image_compression_control
    ERROR_COMPRESSION_EXHAUSTED_EXT = -1000338000,
    // Provided by VK_EXT_shader_object
    INCOMPATIBLE_SHADER_BINARY_EXT = 1000482000,
    // Provided by VK_KHR_pipeline_binary
    PIPELINE_BINARY_MISSING_KHR = 1000483000,
    // Provided by VK_KHR_pipeline_binary
    ERROR_NOT_ENOUGH_SPACE_KHR = -1000483000,
};
