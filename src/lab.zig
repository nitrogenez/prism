const std = @import("std");
const RGB = @import("rgb.zig").RGB;

const math = std.math;

pub const LAB = struct {
    l: f32 = 0.0,
    a: f32 = 0.0,
    b: f32 = 0.0,

    // It is also broken.
    // I have no clue how that thing works. Almost.
    // I don't know where the magic numbers come from,
    // and don't know what they mean either.
    // The calculations are off just a little bit,
    // but still I will make it work. It's my main concern for now.
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
