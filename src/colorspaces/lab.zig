const std = @import("std");

const RGB = @import("rgb.zig").RGB;

const math = std.math;

pub const LAB = struct {
    l: f32 = 0.0,
    a: f32 = 0.0,
    b: f32 = 0.0,

    pub fn toRGB(self: *const LAB) RGB {
        var xyz: [3]f32 = undefined;
        var rgb: [3]f32 = undefined;

        xyz[1] = (self.l + 16.0) / 116.0;
        xyz[0] = self.a / 500.0 + xyz[1];
        xyz[2] = xyz[1] - self.b / 200.0;

        for (xyz, 0..) |c, i| {
            if (math.pow(f32, c, 3) > 0.008856) {
                xyz[i] = math.pow(f32, c, 3);
            } else {
                xyz[i] = (c - 16.0 / 116.0) / 7.787;
            }
        }

        const x: f32 = 95.047 * xyz[0];
        const y: f32 = 100.000 * xyz[1];
        const z: f32 = 100.000 * xyz[2];

        xyz[0] = x / 100.0;
        xyz[1] = y / 100.0;
        xyz[2] = z / 100.0;

        rgb[0] = xyz[0] * 3.2406 + xyz[1] * -1.5372 + xyz[2] * -0.4986;
        rgb[1] = xyz[0] * -0.9689 + xyz[1] * 1.8758 + xyz[2] * 0.0415;
        rgb[2] = xyz[0] * 0.0557 + xyz[1] * -0.2040 + xyz[2] * 1.0570;

        for (rgb, 0..) |c, i| {
            if (c > 0.0031308) {
                rgb[i] = 1.055 * math.pow(f32, c, (1.0 / 2.4)) - 0.055;
            } else {
                rgb[i] = 12.92 * c;
            }
        }

        rgb[0] *= 255.0;
        rgb[1] *= 255.0;
        rgb[2] *= 255.0;

        rgb[0] = math.clamp(math.floor(rgb[0]), 0.0, 255.0);
        rgb[1] = math.clamp(math.floor(rgb[1]), 0.0, 255.0);
        rgb[2] = math.clamp(math.floor(rgb[2]), 0.0, 255.0);

        return .{ .r = rgb[0], .g = rgb[1], .b = rgb[2] };
    }

    pub fn fromRGB(from: *const RGB) LAB {
        var xyz: [3]f32 = undefined;
        var lab = LAB{};
        var n = from.normalized();
        var rgb: [3]f32 = .{ n.r, n.g, n.b };

        for (rgb, 0..) |c, i| {
            if (c > 0.04045) {
                rgb[i] = math.pow(f32, (c + 0.055) / 1.055, 2.4);
            } else {
                rgb[i] = c / 12.92;
            }
        }

        for (rgb, 0..) |c, i| {
            rgb[i] = c * 100.0;
        }

        n.r = rgb[0];
        n.g = rgb[1];
        n.b = rgb[2];

        // TODO: Make that thing a matrix multiplication
        xyz[0] = ((n.r * 0.412453) + (n.g * 0.357580) + (n.b * 0.180423));
        xyz[1] = ((n.r * 0.212671) + (n.g * 0.715160) + (n.b * 0.072169));
        xyz[2] = ((n.r * 0.019334) + (n.g * 0.119193) + (n.b * 0.950227));

        xyz[0] /= 95.047;
        xyz[1] /= 100.0;
        xyz[2] /= 108.883;

        for (xyz, 0..) |c, i| {
            if (c > 0.008856) {
                xyz[i] = math.pow(f32, c, 1.0 / 3.0);
            } else {
                xyz[i] = (c * 7.787) + (16.0 / 116.0);
            }
        }

        lab.l = (116.0 * xyz[1]) - 16.0;
        lab.a = 500.0 * (xyz[0] - xyz[1]);
        lab.b = 200.0 * (xyz[1] - xyz[2]);

        return lab;
    }
};
