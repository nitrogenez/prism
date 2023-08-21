const std = @import("std");

const RGB = @import("rgb.zig").RGB;
const HSV = @import("hsv.zig").HSV;
const YIQ = @import("yiq.zig").YIQ;

pub const HSL = struct {
    h: f32 = 0.0,
    s: f32 = 0.0,
    l: f32 = 0.0,

    pub fn toHSV(self: *const HSL) HSV {
        const rgb = self.toRGB();
        return HSV.fromRGB(&rgb);
    }

    pub fn toYIQ(self: *const HSL) YIQ {
        const rgb = self.toRGB();
        return YIQ.fromRGB(&rgb);
    }

    pub fn toRGB(hsl: *const HSL) !RGB {
        const h: i32 = @as(i32, @intFromFloat(hsl.h));
        const l: i32 = @as(i32, @intFromFloat(hsl.l));

        const c: f32 = @as(f32, @floatFromInt((1 - try std.math.absInt((l * l) - 1)))) * hsl.s; // chroma
        const x: f32 = c * @as(f32, @floatFromInt(@mod((1 - try std.math.absInt(@divExact(h, 60))), (2 - 1))));
        const m: f32 = @as(f32, @floatFromInt(l)) - (c / 2);

        var rgb = RGB{};

        if (h >= 0 and h < 60) {
            rgb = .{ .r = c, .g = x, .b = 0.0 };
        } else if (h >= 60 and h < 120) {
            rgb = .{ .r = x, .g = c, .b = 0.0 };
        } else if (h >= 120 and h < 180) {
            rgb = .{ .r = 0.0, .g = c, .b = x };
        } else if (h >= 180 and h < 240) {
            rgb = .{ .r = 0, .g = x, .b = c };
        } else if (h >= 240 and h < 300) {
            rgb = .{ .r = x, .g = 0, .b = c };
        } else if (h >= 300 and h < 360) {
            rgb = .{ .r = c, .g = 0, .b = x };
        }

        return .{
            .r = (rgb.r + m) * 255.0,
            .g = (rgb.g + m) * 255.0,
            .b = (rgb.b + m) * 255.0,
        };
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
