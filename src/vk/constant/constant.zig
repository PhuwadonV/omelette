pub const Result = @import("result.zig").Result;
pub const StructureType = @import("structure_type.zig").StructureType;

pub const SystemAllocationScope = enum(c_int) {
    COMMAND = 0,
    OBJECT = 1,
    CACHE = 2,
    DEVICE = 3,
    INSTANCE = 4,
};

pub const InternalAllocationType = enum(c_int) {
    EXECUTABLE = 0,
};

pub const PhysicalDeviceType = enum(c_int) {
    OTHER = 0,
    INTEGRATED_GPU = 1,
    DISCRETE_GPU = 2,
    VIRTUAL_GPU = 3,
    CPU = 4,
};
