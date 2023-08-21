const RGB = @import("rgb.zig").RGB;
const HSL = @import("hsl.zig").HSL;
const HSV = @import("hsv.zig").HSV;
const YIQ = @import("yiq.zig").YIQ;

const RGBA = struct {
    const Self = @This();

    r: f32 = 0.0,
    g: f32 = 0.0,
    b: f32 = 0.0,
    a: f32 = 0.0,

    pub fn fromRGB(rgb: *const RGB) RGBA {
        return .{ .r = rgb.r, .g = rgb.g, .b = rgb.b };
    }

    pub fn toRGB(self: *const Self) RGB {
        return .{ .r = self.r, .g = self.g, .b = self.b };
    }

    pub fn toHSL(self: *const Self) HSL {
        return self.toRGB().toHSL();
    }

    pub fn toHSV(self: *const Self) HSV {
        return self.toRGB().toSHV();
    }

    pub fn toYIQ(self: *const Self) YIQ {
        return self.toRGB().toYIQ();
    }
};
