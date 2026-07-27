const std = @import("std");

const Alignment = std.mem.Alignment;
const Allocator = std.mem.Allocator;

pub const sandwich_allocator: Allocator = .{
    .ptr = undefined,
    .vtable = &.{
        .alloc = alloc,
        .resize = resize,
        .remap = remap,
        .free = free,
    },
};

fn alloc(ctx: *anyopaque, len: usize, alignment: Alignment, return_address: usize) ?[*]u8 {
    return std.heap.page_allocator.vtable.alloc(ctx, len, alignment, return_address);
}

fn resize(ctx: *anyopaque, memory: []u8, alignment: Alignment, new_len: usize, return_address: usize) bool {
    return std.heap.page_allocator.vtable.resize(ctx, memory, alignment, new_len, return_address);
}

fn remap(ctx: *anyopaque, memory: []u8, alignment: Alignment, new_len: usize, return_address: usize) ?[*]u8 {
    return std.heap.page_allocator.vtable.remap(ctx, memory, alignment, new_len, return_address);
}

fn free(ctx: *anyopaque, memory: []u8, alignment: Alignment, return_address: usize) void {
    std.heap.page_allocator.vtable.free(ctx, memory, alignment, return_address);
}
