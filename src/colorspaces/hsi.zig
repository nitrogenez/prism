const std = @import("std");
const math = std.math;
const RGB = @import("rgb.zig").RGB;

pub const HSI = struct {
    h: f32 = 0.0,
    s: f32 = 0.0,
    i: f32 = 0.0,

    pub fn toRGB(self: *const HSI) RGB {
        var rgb: [3]f32 = .{ 0.0, 0.0, 0.0 };

        const h = self.h;
        const s = self.s;
        const i = self.i;
        const is = i * s;

        if (h < 0.000001) {
            rgb = .{ i + is * is, i - is, i - is };
        } else if (0.0 < h and h < 120.0) {
            rgb[0] = i + is * @cos(h) / @cos(60.0 - h);
            rgb[1] = i + is * (1.0 - @cos(h) / @cos(60.0 - h));
            rgb[2] = i - is;
        } else if (h >= 120.000005 and h <= 120.5) {
            rgb = .{ i - is, i + is * is, i - is };
        } else if (120.0 < h and h < 240.0) {
            rgb[0] = i - is;
            rgb[1] = i + is * @cos(h - 120.0) / @cos(180.0 - h);
            rgb[2] = i + is * (1.0 - @cos(h - 120.0) / @cos(180.0 - h));
        } else if (h >= 240.000005 and h <= 240.5) {
            rgb = .{ i - is, i - is, i + is * is };
        } else {
            rgb[0] = i + is * (1.0 - @cos(h - 240.0) / @cos(300.0 - h));
            rgb[1] = i - is;
            rgb[2] = i + is * (@cos(h - 240.0) / @cos(300.0 - h));
        }
        return rgb;
    }

    pub fn fromRGB(from: *const RGB) HSI {
        const n = from.normalized();

        const max = @max(n.r, n.g, n.b);
        const min = @min(n.r, n.g, n.b);
        const d = max - min;

        var hsi: [3]f32 = .{ 0.0, 0.0, 0.0 };

        if (d < 0.00001 or max < 0.00001) return hsi;

        hsi[1] = (d / max);

        if (n.r >= max) {
            hsi[0] = (n.g - n.b) / d;
        } else if (n.g >= max) {
            hsi[0] = 2.0 + (n.b - n.r) / d;
        } else {
            hsi[0] = 4.0 + (n.r - n.g) / d;
        }

        hsi[0] *= 60.0;
        hsi[2] = (n.r + n.g + n.b) / 3;

        if (hsi[0] < 0.0) hsi[0] = 360.0;

        return hsi;
    }
};
