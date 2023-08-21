const std = @import("std");
const RGB = @import("rgb.zig").RGB;

pub const HSL = struct {
    h: f32 = 0.0,
    s: f32 = 0.0,
    l: f32 = 0.0,

    pub fn toRGB(hsl: *const HSL) !RGB {
        const h: i32 = @as(i32, @intFromFloat(hsl.h));
        const l: i32 = @as(i32, @intFromFloat(hsl.l));

        const c: f32 = @as(f32, @floatFromInt((1 - try std.math.absInt((l * l) - 1)))) * hsl.s; // chroma
        const x: f32 = c * @as(f32, @floatFromInt(@mod((1 - try std.math.absInt(@divExact(h, 60))), (2 - 1))));
        const m: f32 = @as(f32, @floatFromInt(l)) - (c / 2);

        var rgb = RGB{};

        if (h >= 0 and h < 60) {
            rgb.r = c;
            rgb.g = x;
            rgb.b = 0.0;
        } else if (h >= 60 and h < 120) {
            rgb.r = x;
            rgb.g = c;
            rgb.b = 0;
        } else if (h >= 120 and h < 180) {
            rgb.r = 0;
            rgb.g = c;
            rgb.b = x;
        } else if (h >= 180 and h < 240) {
            rgb = RGB{ .r = 0, .g = x, .b = c };
        } else if (h >= 240 and h < 300) {
            rgb = RGB{ .r = x, .g = 0, .b = c };
        } else if (h >= 300 and h < 360) {
            rgb = .{ .r = c, .g = 0, .b = x };
        }

        rgb.r = (rgb.r + m) * 255.0;
        rgb.g = (rgb.g + m) * 255.0;
        rgb.b = (rgb.b + m) * 255.0;

        return rgb;
    }

    pub fn fromRGB(rgb: *const RGB) HSL {
        const r1 = rgb.r / 255.0;
        const g1 = rgb.g / 255.0;
        const b1 = rgb.b / 255.0;

        const cmax: f32 = @max(r1, g1, b1);
        const cmin: f32 = @min(r1, g1, b1);
        const delta: f32 = cmax - cmin;

        var hsl: HSL = .{ .l = (cmax + cmin) / 2.0 };

        if (delta < 0.00001) {
            return hsl;
        }

        hsl.s = if (hsl.l > 0.5) delta / (2.0 - cmax - cmin) else delta / (cmax + cmin);

        if (r1 >= cmax) {
            hsl.h = (g1 - b1) / delta;
        } else if (g1 >= cmax) {
            hsl.h = 2.0 + (b1 - r1) / delta;
        } else {
            hsl.h = 4.0 + (r1 - g1) / delta;
        }
        hsl.h *= 60.0;

        if (hsl.h < 0.0) {
            hsl.h = 360.0;
        }

        return hsl;
    }
};
