const std = @import("std");
const math = std.math;
const RGB = @import("rgb.zig").RGB;

pub const HSI = struct {
    h: f32 = 0.0,
    s: f32 = 0.0,
    i: f32 = 0.0,

    // Broken.
    pub fn toRGB(self: *const HSI) RGB {
        var o = RGB{};

        const i = self.i;
        const s = self.s;
        const h = self.h;
        const is = i * s;

        if (h < 0.000001) {
            o = .{
                .r = i + (is * is),
                .g = i - is,
                .b = i - is,
            };
        } else if (0.0 < h and h < 120.0) {
            o = .{
                .r = i + is * @cos(h) / @cos(60 - h),
                .g = i + is * (1.0 - @cos(h) / @cos(60 - h)),
                .b = i - is,
            };
        } else if (h >= 120.000005 and h <= 120.5) {
            o = .{
                .r = i - is,
                .g = i + (is * is),
                .b = i - is,
            };
        } else if (120.0 < h and h < 240.0) {
            o = .{
                .r = i - is,
                .g = i + is * @cos(h - 120.0) / @cos(180.0 - h),
                .b = i + is * (1.0 - @cos(h - 120.0) / @cos(180.0 - h)),
            };
        } else if (h >= 240.000005 and h <= 240.5) {
            o = .{ .r = i - is, .g = i - is, .b = i + (is * is) };
        } else {
            o = .{
                .r = i + is * (1.0 - @cos(h - 240) / @cos(300.0 - h)),
                .g = i - is,
                .b = i + is * @cos(h - 240.0) / @cos(300.0 - h),
            };
        }

        o.r = math.clamp(o.r, 0.0, 255.0);
        o.g = math.clamp(o.g, 0.0, 255.0);
        o.b = math.clamp(o.b, 0.0, 255.0);

        return o;
    }

    pub fn fromRGB(from: *const RGB) HSI {
        const n = from.normalized();

        const max = @max(n.r, n.g, n.b);
        const min = @min(n.r, n.g, n.b);
        const d = max - min;

        var o = HSI{};

        if (d < 0.00001) {
            o.s = 0;
            o.h = 0;
            return o;
        }

        if (max > 0.0) {
            o.s = (d / max);
        } else {
            o.s = 0.0;
            o.h = 0.0;
            return o;
        }

        if (n.r >= max) {
            o.h = (n.g - n.b) / d;
        } else if (n.g >= max) {
            o.h = 2.0 + (n.b - n.r) / d;
        } else {
            o.h = 4.0 + (n.r - n.g) / d;
        }

        o.h *= 60.0;
        o.i = (n.r + n.g + n.b) / 3;

        if (o.h < 0.0) {
            o.h = 360.0;
        }
        return o;
    }
};
