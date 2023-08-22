const HSI = @import("hsi.zig").HSI;
const HSV = @import("hsv.zig").HSV;
const HSL = @import("hsl.zig").HSL;
const YIQ = @import("yiq.zig").YIQ;
const LAB = @import("lab.zig").LAB;
const CMYK = @import("cmyk.zig").CMYK;

pub const RGB = struct {
    const Self = @This();

    r: f32 = 0.0,
    g: f32 = 0.0,
    b: f32 = 0.0,

    pub fn eql(self: *const Self, other: *const Self) bool {
        return self.r == other.r and self.g == other.g and self.b == other.b;
    }

    pub fn normalized(self: *const RGB) RGB {
        return .{
            .r = self.r / 255.0,
            .g = self.g / 255.0,
            .b = self.b / 255.0,
        };
    }

    pub fn lighten(self: *const Self, factor: f32) RGB {
        return .{
            .r = @min(255.0, self.r + 255.0 * factor),
            .g = @min(255.0, self.g + 255.0 * factor),
            .b = @min(255.0, self.b + 255.0 * factor),
        };
    }

    pub fn darken(self: *const Self, factor: f32) RGB {
        return .{
            .r = @min(255.0, self.r * (1.0 - factor)),
            .g = @min(255.0, self.g * (1.0 - factor)),
            .b = @min(255.0, self.b * (1.0 - factor)),
        };
    }

    pub fn blend(self: *const Self, other: *const Self) RGB {
        return .{
            .r = @min(255.0, 0.5 * self.r + 0.5 * other.r),
            .g = @min(255.0, 0.5 * self.g + 0.5 * other.g),
            .b = @min(255.0, 0.5 * self.b + 0.5 * other.b),
        };
    }

    pub fn saturate(self: *const Self, factor: f32) !RGB {
        var rgb1 = RGB{ .r = self.r / 255.0, .g = self.g / 255.0, .b = self.b / 255.0 };
        var hsl = HSL.fromRGB(&rgb1);

        hsl.s = factor;

        return try HSL.toRGB(&hsl);
    }

    pub fn fromHSV(hsv: *const HSV) RGB {
        var hh: f32 = 0;
        var p: f32 = 0;
        var q: f32 = 0;
        var t: f32 = 0;
        var ff: f32 = 0;
        var i: f32 = 0;

        var rgb: RGB = .{};

        if (hsv.s <= 0.0) {
            rgb.r = hsv.v;
            rgb.g = hsv.v;
            rgb.b = hsv.v;
            return rgb;
        }

        hh = hsv.h;

        if (hh >= 360.0) {
            hh = 0.0;
        }

        hh /= 60.0;

        i = hh;
        ff = hh - i;

        p = hsv.v * (1.0 - hsv.s);
        q = hsv.v * (1.0 - (hsv.s * ff));
        t = hsv.v * (1.0 - (hsv.s * (1.0 - ff)));

        switch (@as(u8, @intFromFloat(i))) {
            0 => {
                rgb.r = hsv.v;
                rgb.g = t;
                rgb.b = p;
            },
            1 => {
                rgb.r = q;
                rgb.g = hsv.v;
                rgb.b = t;
            },
            2 => {
                rgb.r = p;
                rgb.g = hsv.v;
                rgb.b = t;
            },
            3 => {
                rgb.r = p;
                rgb.g = q;
                rgb.b = hsv.v;
            },
            4 => {
                rgb.r = t;
                rgb.g = p;
                rgb.b = hsv.v;
            },
            5 => {},
            else => {
                rgb.r = hsv.v;
                rgb.g = p;
                rgb.b = q;
            },
        }
        return rgb;
    }

    pub fn fromHSL(from: *const HSL) RGB {
        return HSL.toRGB(from);
    }

    pub fn fromHSI(from: *const HSI) RGB {
        return HSI.toRGB(from);
    }

    pub fn fromLAB(from: *const LAB) RGB {
        return LAB.toRGB(from);
    }

    pub fn fromCMYK(from: *const CMYK) RGB {
        return CMYK.toRGB(from);
    }

    pub fn toHSV(rgb: *const Self) HSV {
        return HSV.fromRGB(rgb);
    }

    pub fn toHSL(self: *const Self) HSL {
        return HSL.fromRGB(self);
    }

    pub fn toHSI(self: *const RGB) HSI {
        return HSI.fromRGB(self);
    }

    pub fn toLAB(self: *const RGB) LAB {
        return LAB.fromRGB(self);
    }

    pub fn toCMYK(self: *const CMYK) CMYK {
        return CMYK.fromRGB(self);
    }

    pub fn toYIQ(self: *const Self) YIQ {
        return YIQ.fromRGB(self);
    }

    pub fn toHEX(self: *const Self) i32 {
        const r = @as(i32, @intFromFloat(self.r));
        const g = @as(i32, @intFromFloat(self.g));
        const b = @as(i32, @intFromFloat(self.b));
        return ((r & 0xff) << 16) + ((g & 0xff) << 8) + (b & 0xff);
    }
};
