const RGB = @import("rgb.zig").RGB;

pub const CMYK = struct {
    c: f32 = 0.0,
    m: f32 = 0.0,
    y: f32 = 0.0,
    k: f32 = 0.0,

    pub fn fromRGB(rgb: *const RGB) CMYK {
        const n = rgb.normalized();

        const k = 1.0 - @max(n.r, n.g, n.b);
        const c = (1.0 - n.r - k) / (1.0 - k);
        const m = (1.0 - n.g - k) / (1.0 - k);
        const y = (1.0 - n.b - k) / (1.0 - k);

        return .{ .c = c, .m = m, .y = y, .k = k };
    }

    pub fn toRGB(self: *const CMYK) RGB {
        return .{
            .r = 255.0 * (1.0 - self.c) * (1.0 - self.k),
            .g = 255.0 * (1.0 - self.m) * (1.0 - self.k),
            .b = 255.0 * (1.0 - self.y) * (1.0 - self.k),
        };
    }
};
