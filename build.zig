const std = @import("std");

pub fn build(b: *std.Build) void {
    const optimize = b.standardOptimizeOption(.{});
    const target = b.standardTargetOptions(.{});

    _ = b.addModule("prism", .{
        .source_file = .{ .path = "src/prism.zig" },
    });

    const lib = b.addStaticLibrary(.{
        .name = "prism",
        .root_source_file = .{ .path = "src/prism.zig" },
        .target = target,
        .optimize = optimize,
    });
    b.installArtifact(lib);

    const test_step = b.step("test", "Run tests");
    const main_tests = b.addTest(.{
        .name = "prism-tests",
        .root_source_file = .{ .path = "src/prism.zig" },
        .target = target,
        .optimize = optimize,
    });
    main_tests.linkLibrary(lib);
    test_step.dependOn(&b.addRunArtifact(main_tests).step);

    const examples = [_]*std.Build.Step.Compile{
        b.addExecutable(.{
            .name = "madness",
            .root_source_file = .{ .path = "src/examples/madness.zig" },
            .target = target,
            .optimize = optimize,
        }),
    };

    for (examples) |e| {
        e.addModule("prism", b.modules.get("prism").?);
        e.linkLibrary(lib);
        b.installArtifact(e);
    }
}
