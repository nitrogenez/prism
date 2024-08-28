const std = @import("std");

pub fn build(b: *std.Build) void {
    const optimize = b.standardOptimizeOption(.{});
    const target = b.standardTargetOptions(.{});

    const mod = b.addModule("prism", .{ .root_source_file = b.path("src/root.zig") });

    const lib = b.addStaticLibrary(.{
        .name = "prism",
        .root_source_file = b.path("src/root.zig"),
        .target = target,
        .optimize = optimize,
    });
    b.installArtifact(lib);

    const test_step = b.step("test", "Run tests");
    const main_tests = b.addTest(.{
        .name = "tests",
        .root_source_file = b.path("src/root.zig"),
        .target = target,
        .optimize = optimize,
    });
    test_step.dependOn(&b.addRunArtifact(main_tests).step);

    const example_option = b.option(bool, "examples", "Build examples") orelse false;
    if (example_option) {
        const rainbow = b.addExecutable(.{
            .name = "rainbow",
            .root_source_file = b.path("src/examples/rainbow.zig"),
            .target = target,
            .optimize = optimize,
        });
        b.installArtifact(rainbow);
        rainbow.root_module.addImport("prism", mod);
    }
}
