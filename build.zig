const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    // Define array of source files
    const src_files = &[_][]const u8{
        "src/sorting.zig",
        "src/searching.zig",
        // Add more source files here that contain tests
    };

    // Add static library for algorithms
    const algorithms = b.addStaticLibrary(.{
        .name = "algorithms",
        .root_source_file = .{ .path = "src/main.zig" },
        .target = target,
        .optimize = optimize,
    });
    b.installArtifact(algorithms);

    // This step will be visible in the `zig build --help` menu
    const test_step = b.step("test", "Run all tests");

    // Add a test runner for each source file that contains tests
    for (src_files) |file| {
        const t = b.addTest(.{
            .root_source_file = .{ .path = file },
            .target = target,
            .optimize = optimize,
        });
        test_step.dependOn(&b.addRunArtifact(t).step);
    }
}
