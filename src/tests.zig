const std = @import("std");
const mem = std.mem;
const testing = std.testing;

const prism = @import("prism.zig");

test "RGB to HEX conversion" {
    const c = prism.RGB{ .r = 40, .g = 40, .b = 40 };
    const hex = c.toHEX();

    var buf: [7]u8 = undefined;
    _ = try std.fmt.bufPrint(&buf, "#{x}", .{hex});

    try testing.expectEqualStrings("#282828", &buf);
}

test "RGB to HSL conversion" {
    const c = prism.colors.Red;

    const hsl = c.toHSL();
    const expected = prism.HSL{ .h = 0.0, .s = 1.0, .l = 0.5 };

    try testing.expect((hsl.h == expected.h) and
        (hsl.s == expected.s) and
        (hsl.l == expected.l));
}

test "RGB to HSV conversion" {
    const c = prism.colors.Red;

    const hsv = c.toHSV();
    const expected = prism.HSV{ .h = 0.0, .s = 1.0, .v = 1.0 };

    try testing.expect((hsv.h == expected.h) and
        (hsv.s == expected.s) and
        (hsv.v == expected.v));
}

// BROKEN
test "RGB to YIQ conversion" {
    const c = prism.colors.Red;

    const yiq = c.toYIQ();
    const expected = prism.YIQ{ .y = 0.299, .i = -0.147, .q = 0.615 };

    try testing.expect((yiq.y == expected.y) and
        (yiq.i == expected.i) and
        (yiq.q == expected.q));
}
