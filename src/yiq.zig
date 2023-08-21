const conf = @import("config.zig");

const RGB = @import("rgb.zig").RGB;
const HSL = @import("hsl.zig").HSL;
const HSV = @import("hsv.zig").HSV;

const math = @import("std").math;
const clamp = math.clamp;

pub const YIQ = struct {
    const Self = @This();

    const matrix: [3][3]f32 = .{
        .{ 0.299, 0.587, 0.114 },
        .{ 0.59590059, -0.27455667, -0.32134392 },
        .{ 0.21153661, -0.52273617, 0.31119955 },
    };

    y: f32 = 0.0,
    i: f32 = 0.0,
    q: f32 = 0.0,

    pub fn toHSL(self: *const Self) HSL {
        if (!conf.unstable_features) return HSL{};
        const rgb = self.toRGB();
        return HSL.fromRGB(&rgb);
    }

    pub fn toHSV(self: *const Self) HSV {
        if (!conf.unstable_features) return HSV{};
        const rgb = self.toRGB();
        return HSV.fromRGB(&rgb);
    }

    // I have no idea if it's working properly or not.
    // Different sources show different values, not even achieved by flooring
    // or changing display precision, so now it's marked unstable.
    pub fn fromRGB(rgb: *const RGB) YIQ {
        if (!conf.unstable_features) return YIQ{};
        const r = rgb.r / 255.0;
        const g = rgb.g / 255.0;
        const b = rgb.b / 255.0;

        const y: f32 = (0.30 * r) + (0.59 * g) + (0.11 * b);
        const i: f32 = (0.74 * (r - y)) - (0.27 * (b - y));
        const q: f32 = (0.48 * (r - y)) + (0.41 * (b - y));

        return .{ .y = y, .i = i, .q = q };
    }

    pub fn toRGB(self: *const Self) RGB {
        if (!conf.unstable_features) return RGB{};

        var r = self.y + 0.9468822170900693 * self.i + 0.6235565819861433 * self.q;
        var g = self.y - 0.27478764629897834 * self.i - 0.6356910791873801 * self.q;
        var b = self.y - 1.1085450346420322 * self.i + 1.7090069284064666 * self.q;

        r = math.clamp(r, 0.0, 1.0);
        g = math.clamp(g, 0.0, 1.0);
        b = math.clamp(b, 0.0, 1.0);

        return .{ r, g, b };
    }
};
