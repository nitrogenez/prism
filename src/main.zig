const std = @import("std");
const testing = std.testing;

const colors = @import("colors.zig");

test "RGB to HSV conversion" {
    var out: colors.HSV = colors.Red.toHSV();
    var rgb_hsv: colors.HSV = .{ .h = 0.0, .s = 1.0, .v = 1.0 };

    try testing.expect(out.eql(&rgb_hsv));
}

test "lighten, darken, staturate, blend" {
    var c1 = colors.RGB{ .r = 20, .g = 20, .b = 20 };
    var c2 = colors.RGB{ .r = 252, .g = 27, .b = 27 };

    _ = c1.lighten(0.1);
    _ = c2.darken(0.1);
    _ = c1.darken(0.1);
    _ = c2.lighten(0.1);
    _ = c1.blend(&c2);
    _ = c2.blend(&c1);
    _ = c1.toHSV().lighten(0.1);
    _ = c1.toHSV().darken(0.1);
    _ = c1.toHSV().blend(&c2.toHSV());
    _ = try c1.saturate(0.5);
}

test "RGB to HSL" {
    const rgb = colors.RGB{ .r = 255 };
    const hsl = colors.HSL.fromRGB(&rgb);
    _ = hsl;
}
