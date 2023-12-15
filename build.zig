const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    // Define arrays of source files and test files
    const src_files = &[_][]const u8{
        "src/sorting.zig",
        "src/searching.zig",
        // Add more source files here
    };
    const test_files = &[_][]const u8{
        "tests/sorting.zig",
        "tests/searching.zig",
        // Add more test files here
    };

    // Add static library for algorithms
    const algorithms = b.addStaticLibrary(.{
        .name = "algorithms",
        .root_source_files = src_files,
        .target = target,
        .optimize = optimize,
    });
    b.installArtifact(algorithms);

    // Add tests
    const test_step = b.step("test", "Run all tests");
    for (test_files) |test_file| {
        const t = b.addTest(.{
            .root_source_file = .{ .path = test_file },
            .target = target,
            .optimize = optimize,
        });
        test_step.dependOn(&b.addRunArtifact(t).step);
    }
}
