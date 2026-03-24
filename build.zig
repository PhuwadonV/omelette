const std = @import("std");

const getEnvMap = std.process.getEnvMap;
const allocPrint = std.fmt.allocPrint;

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});
    const env_map = getEnvMap(b.allocator) catch @panic("Failed to get environment variables");

    const vk_sdk_path = if (env_map.get("VK_SDK_PATH")) |path|
        allocPrint(b.allocator, "{s}/lib", .{path}) catch |err| @panic(@errorName(err))
    else
        @panic("Vulkan SDK required");

    const exe = b.addExecutable(.{
        .name = "Omelette",
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/main.zig"),
            .target = target,
            .optimize = optimize,
        }),
        .win32_manifest = b.path("assets/platforms/windows/win32.manifest"),
    });

    exe.subsystem = .Windows;

    exe.addLibraryPath(.{ .cwd_relative = vk_sdk_path });
    exe.linkSystemLibrary("vulkan-1");

    b.installArtifact(exe);

    const run_step = b.step("run", "Run the app");

    const run_cmd = b.addRunArtifact(exe);
    run_step.dependOn(&run_cmd.step);

    run_cmd.step.dependOn(b.getInstallStep());
    run_cmd.setCwd(b.path("zig-out/bin"));

    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const exe_tests = b.addTest(.{
        .root_module = exe.root_module,
    });

    const run_exe_tests = b.addRunArtifact(exe_tests);

    const test_step = b.step("test", "Run tests");
    test_step.dependOn(&run_exe_tests.step);
}
