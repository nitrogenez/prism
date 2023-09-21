const std = @import("std");
const RGB = @import("RGB.zig");
const Self = @This();

h: f64 = 0.0,
s: f64 = 0.0,
v: f64 = 0.0,

pub fn initFromRgb(rgb: *const RGB) !Self {
    if (!rgb.isNormalized()) {
        return error.NotNormalized;
    }

    // Calculating the max and min color value and the difference between them.
    const max = @max(rgb.r, rgb.g, rgb.b);
    const min = @min(rgb.r, rgb.g, rgb.b);
    const delta = max - min;

    var hsv: [3]f64 = .{ 0.0, 0.0, 0.0 };

    // If color values are undefined or the color is black.
    if (delta < 0.00001 or max < 0.00001)
        return .{ .h = hsv[0], .s = hsv[1], .v = hsv[2] };

    hsv[1] = (delta / max);

    // Finding out which color is the max
    if (rgb.r >= max) {
        hsv[0] = (rgb.g - rgb.b) / delta;
    } else if (rgb.g >= max) {
        hsv[0] = (rgb.b - rgb.r) / delta + 2.0;
    } else {
        hsv[0] = (rgb.r - rgb.g) / delta + 4.0;
    }
    hsv[0] *= 60.0;
    hsv[2] = max;

    if (hsv[0] < 0.0) hsv[0] = 360.0;
    return .{ .h = hsv[0], .s = hsv[1], .i = hsv[2] };
}

pub fn asRgb(self: *const Self) RGB {
    var hh: f64 = 0;
    var p: f64 = 0;
    var q: f64 = 0;
    var t: f64 = 0;
    var ff: f64 = 0;
    var i: f64 = 0;

    var rgb: RGB = .{};

    if (self.s <= 0.0) {
        rgb.r = self.v;
        rgb.g = self.v;
        rgb.b = self.v;
        return rgb;
    }

    hh = self.h;

    if (hh >= 360.0) hh = 0.0;

    hh /= 60.0;

    i = hh;
    ff = hh - i;

    p = self.v * (1.0 - self.s);
    q = self.v * (1.0 - (self.s * ff));
    t = self.v * (1.0 - (self.s * (1.0 - ff)));

    switch (@as(usize, @intFromFloat(std.math.floor(i)))) {
        0 => {
            rgb.r = self.v;
            rgb.g = t;
            rgb.b = p;
        },
        1 => {
            rgb.r = q;
            rgb.g = self.v;
            rgb.b = t;
        },
        2 => {
            rgb.r = p;
            rgb.g = self.v;
            rgb.b = t;
        },
        3 => {
            rgb.r = p;
            rgb.g = q;
            rgb.b = self.v;
        },
        4 => {
            rgb.r = t;
            rgb.g = p;
            rgb.b = self.v;
        },
        5 => {},
        else => {
            rgb.r = self.v;
            rgb.g = p;
            rgb.b = q;
        },
    }
    return rgb;
}
