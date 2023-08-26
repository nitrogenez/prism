const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const lib = b.addStaticLibrary(.{
        .name = "prism",
        .root_source_file = .{ .path = "src/prism.zig" },
        .target = target,
        .optimize = optimize,
    });

    const lib_shared = b.addSharedLibrary(.{
        .name = "prism",
        .root_source_file = .{ .path = "src/prism.zig" },
        .target = target,
        .optimize = optimize,
    });

    lib.linkLibC();
    lib_shared.linkLibC();

    const prism_mod = b.createModule(.{ .source_file = .{ .path = "src/prism.zig" } });

    const shades = b.addExecutable(.{
        .name = "shades",
        .root_source_file = .{ .path = "src/shades.zig" },
        .target = target,
        .optimize = optimize,
    });

    const rainbow = b.addExecutable(.{
        .name = "rainbow",
        .root_source_file = .{ .path = "src/rainbow.zig" },
        .target = target,
        .optimize = optimize,
    });
    rainbow.addModule("prism", prism_mod);
    shades.addModule("prism", prism_mod);

    b.installArtifact(lib);
    b.installArtifact(lib_shared);
    b.installArtifact(rainbow);
    b.installArtifact(shades);

    const main_tests = b.addTest(.{
        .root_source_file = .{ .path = "src/tests.zig" },
        .target = target,
        .optimize = optimize,
    });

    const run_main_tests = b.addRunArtifact(main_tests);
    const test_step = b.step("test", "Run library tests");
    test_step.dependOn(&run_main_tests.step);
}
