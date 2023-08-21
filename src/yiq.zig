const RGB = @import("rgb.zig").RGB;
const HSL = @import("hsl.zig").HSL;
const HSV = @import("hsv.zig").HSV;

const math = @import("std").math;

pub const YIQ = struct {
    const Self = @This();

    y: f32 = 0.0,
    i: f32 = 0.0,
    q: f32 = 0.0,

    pub fn toHSL(self: *const Self) HSL {
        const rgb = self.toRGB();
        return HSL.fromRGB(&rgb);
    }

    pub fn toHSV(self: *const Self) HSV {
        const rgb = self.toRGB();
        return HSV.fromRGB(&rgb);
    }

    pub fn fromRGB(rgb: *const RGB) YIQ {
        const y: f32 = (0.30 * rgb.r) + (0.59 * rgb.g) + (0.11 * rgb.b);
        const i: f32 = (0.74 * (rgb.r - y)) - (0.27 * (rgb.b - y));
        const q: f32 = (0.48 * (rgb.r - y)) + (0.41 * (rgb.b - y));

        return .{ .y = y, .i = i, .q = q };
    }

    pub fn toRGB(self: *const Self) RGB {
        var r = self.y + 0.9468822170900693 * self.i + 0.6235565819861433 * self.q;
        var g = self.y - 0.27478764629897834 * self.i - 0.6356910791873801 * self.q;
        var b = self.y - 1.1085450346420322 * self.i + 1.7090069284064666 * self.q;

        r = math.clamp(r, 0.0, 1.0);
        g = math.clamp(g, 0.0, 1.0);
        b = math.clamp(b, 0.0, 1.0);

        return .{ r, g, b };
    }
};
