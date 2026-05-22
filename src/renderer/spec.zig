const vkh = root.vkh;
const root = @import("root");

pub fn getRequiredVulkanApiVersion() u32 {
    return vkh.makeApiVersion(0, 1, 4, 0);
}

pub fn getRequiredVulkanLayer() []const [*:0]const u8 {
    return &.{};
}

pub fn getRequiredVulkanExtension() []const [*:0]const u8 {
    return &.{};
}
