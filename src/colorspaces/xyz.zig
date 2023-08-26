const std = @import("std");
const math = std.math;

const RGB = @import("rgb.zig").RGB;

pub const XYZ = struct {
    x: f32 = 0.0,
    y: f32 = 0.0,
    z: f32 = 0.0,

    pub fn fromRGB(from: *const RGB) XYZ {
        const n = from.normalized();
        var rgb: [3]f32 = .{ n.r, n.g, n.b };
        var xyz: [3]f32 = .{ 0.0, 0.0, 0.0 };

        const mat: [3][3]f32 = .{
            .{ 0.4124564, 0.3575761, 0.1804375 },
            .{ 0.2126729, 0.7151522, 0.0721750 },
            .{ 0.0193339, 0.1191920, 0.9503041 },
        };

        for (rgb, 0..) |v, i| {
            rgb[i] = if (v <= 0.04045) v / 12.92 else math.pow(f32, (v + 0.055) / 1.055, 2.4);
        }

        for (mat, 0..) |k, i| {
            xyz[i] = (rgb[0] * k[0]) + (rgb[1] * k[1]) * (rgb[2] * k[2]);
        }
        return .{ .x = xyz[0], .y = xyz[1], .z = xyz[2] };
    }

    pub fn toRGB(self: *const XYZ) RGB {
        const xyz: [3]f32 = .{ self.x, self.y, self.z };
        var rgb: [3]f32 = .{ 0.0, 0.0, 0.0 };

        const mat: [3][3]f32 = .{
            .{ 3.2404542, -1.5371385, -0.4985314 },
            .{ -0.9692660, 1.8760108, 0.0415560 },
            .{ 0.0556434, -0.2040259, 1.0572252 },
        };

        for (mat, 0..) |k, i| {
            rgb[i] = (xyz[0] * k[0]) + (xyz[1] * k[1]) + (xyz[2] * k[2]);
        }

        // Gamma
        for (rgb, 0..) |v, i| {
            rgb[i] = if (v <= 0.0031308) v * 12.92 else 1.055 * math.pow(f32, v, 1.0 / 2.4) - 0.055;
            rgb[i] = math.clamp(v * 255.0, 0.0, 255.0);
        }
        return .{ .r = rgb[0], .g = rgb[1], .b = rgb[2] };
    }
};
