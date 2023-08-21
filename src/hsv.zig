const RGB = @import("rgb.zig").RGB;

pub const HSV = struct {
    const Self = @This();

    h: f32 = 0.0,
    s: f32 = 0.0,
    v: f32 = 0.0,

    pub fn eql(self: *const Self, other: *const Self) bool {
        return self.h == other.h and self.s == other.s and self.v == other.v;
    }

    pub fn lighten(self: *const Self, factor: f32) HSV {
        var c1 = RGB.fromHSV(self);
        return HSV.fromRGB(&c1.lighten(factor));
    }

    pub fn darken(self: *const Self, factor: f32) HSV {
        var c1 = RGB.fromHSV(self);
        return HSV.fromRGB(&c1.darken(factor));
    }

    pub fn blend(self: *const Self, other: *const Self) HSV {
        var c1 = RGB.fromHSV(self);
        var c2 = RGB.fromHSV(other);

        return HSV.fromRGB(&c1.blend(&c2));
    }

    // https://www.rapidtables.com/convert/color/rgb-to-hsv.html
    pub fn fromRGB(rgb: *const RGB) HSV {
        const r1: f32 = rgb.r / 255.0;
        const g1: f32 = rgb.g / 255.0;
        const b1: f32 = rgb.b / 255.0;

        var cmax: f32 = @max(r1, g1, b1);
        var cmin: f32 = @min(r1, g1, b1);
        var delta: f32 = cmax - cmin;

        var hsv: HSV = .{ .v = cmax };

        // maybe undefined
        if (delta < 0.00001) {
            hsv.s = 0;
            hsv.h = 0;
            return hsv;
        }

        if (cmax > 0.0) {
            hsv.s = (delta / cmax);
        } else {
            hsv.s = 0.0;
            hsv.h = 0.0;
            return hsv;
        }

        if (r1 >= cmax) {
            hsv.h = (g1 - b1) / delta;
        } else if (g1 >= cmax) {
            hsv.h = 2.0 + (b1 - r1) / delta;
        } else {
            hsv.h = 4.0 + (r1 - g1) / delta;
        }

        hsv.h *= 60.0;

        if (hsv.h < 0.0) {
            hsv.h = 360.0;
        }
        return hsv;
    }

    pub fn toRGB(hsv: *const HSV) RGB {
        return RGB.fromHSV(hsv);
    }
};
