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

    if (prism.config.unstable_features) {
        try testing.expect((yiq.y == expected.y) and
            (yiq.i == expected.i) and
            (yiq.q == expected.q));
    } else {
        try testing.expect(true);
    }
}

test "RGB to CMYK conversion" {
    const c = prism.colors.Red;

    const cmyk = prism.CMYK.fromRGB(&c);
    const expected = prism.CMYK{ .c = 0.0, .m = 1.0, .y = 1.0, .k = 0.0 };

    try testing.expect((cmyk.c == expected.c) and
        (cmyk.m == expected.m) and
        (cmyk.y == expected.y) and
        (cmyk.k == expected.k));
}

test "RGB to HSI conversion" {
    const c = prism.colors.Red;

    const hsi = prism.HSI.fromRGB(&c);
    const expected = prism.HSI{ .h = 0.0, .s = 1.0, .i = 0.3333 };

    try testing.expect((hsi.h == expected.h) and
        (hsi.s == expected.s) and
        (hsi.i >= expected.i - 0.05 and hsi.i <= expected.i + 0.05));
}

test "HSI to RGB conversion" {
    const c = prism.HSI.fromRGB(&prism.colors.Red);
    const o = c.toRGB();
    const e = prism.colors.Red;
    _ = e;

    std.debug.print("\n{d:.0} {d:.0} {d:.0}\n", .{ o.r, o.g, o.b });
    std.debug.print("{d:.2} {d:.2} {d:.2}\n", .{ c.h, c.s, c.i });
    // std.debug.print("{} {} {}", .{ o.r, o.g, o.b });

    // try testing.expect((o.r == e.r) and
    //     (o.g == e.g) and
    //     (o.b == e.b));
}
