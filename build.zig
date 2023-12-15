const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    // Define array of source files
    const src_files = &[_][]const u8{
        "src/sorting/utilities.zig",
        "src/sorting/bubble.zig",
        // Add more source files here that contain tests
    };

    const lib = b.addStaticLibrary(.{
        .name = "algorithms_and_datastructures",
        // In this case the main source file is merely a path, however, in more
        // complicated build scripts, this could be a generated file.
        .root_source_file = .{ .path = "src/main.zig" },
        .target = target,
        .optimize = optimize,
    });

    // This declares intent for the library to be installed into the standard
    // location when the user invokes the "install" step (the default step when
    // running `zig build`).
    b.installArtifact(lib);

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
