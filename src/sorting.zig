const std = @import("std");
const testing = std.testing;

pub fn swap(list: []u8, index_a: u8, index_b: u8) ![]u8 {
    if (index_a >= list.len) {
        std.debug.print("Error: 'index_a' (value: {}) is out of bounds. The list length is {}.\n", .{ index_a, list.len });
        return error.IndexAOutOfBounds;
    }
    if (index_b >= list.len) {
        std.debug.print("Error: 'index_b' (value: {}) is out of bounds. The list length is {}.\n", .{ index_b, list.len });
        return error.IndexBOutOfBounds;
    }

    const temp = list[index_a];
    list[index_a] = list[index_b];
    list[index_b] = temp;

    return list;
}

test "swap function test" {
    var list: [5]u8 = [5]u8{ 2, 3, 1, 5, 4 };

    // Test swapping non-boundary elements with out-of-bounds indices
    try testing.expectError(error.IndexAOutOfBounds, swap(list[0..], 10, 1));
    try testing.expectError(error.IndexBOutOfBounds, swap(list[0..], 0, 10));

    // Test successful swapping
    _ = try swap(list[0..], 1, 3);
    try testing.expectEqual(list, [5]u8{ 2, 5, 1, 3, 4 });

    // Test swapping boundary elements
    _ = try swap(list[0..], 0, 4);
    try testing.expectEqual(list, [5]u8{ 4, 5, 1, 3, 2 });
}

pub fn bubblesort(list: []u8) []u8 {
    return list;
}
