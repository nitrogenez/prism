// Copyright (c) 2023-2025, Andrij Glyko <nitrogenez.dev@tuta.io>

//! Prism is a color library. It focuses on two things: Colorspace
//! conversion, and performance. There is a set of functions for color
//! manipulation in `manip`, but it's not the main focus.

/// Standardized X11 and .NET color names.
pub const color = struct {
    pub const alice_blue = scatter(3, 0xF0F8FF);
    pub const antique_white = scatter(3, 0xFAEBD7);
    pub const aqua = scatter(3, 0x00FFFF);
    pub const aquamarine = scatter(3, 0x7FFFD4);
    pub const azure = scatter(3, 0xF0FFFF);
    pub const beige = scatter(3, 0xF5F5DC);
    pub const bisque = scatter(3, 0xFFE4C4);
    pub const black = scatter(3, 0x000000);
    pub const blanched_almond = scatter(3, 0xFFEBCD);
    pub const blue = scatter(3, 0x0000FF);
    pub const blue_violet = scatter(3, 0x8A2BE2);
    pub const brown = scatter(3, 0xA52A2A);
    pub const burlywood = scatter(3, 0xDEB887);
    pub const cadet_blue = scatter(3, 0x5F9EA0);
    pub const chartreuse = scatter(3, 0x7FFF00);
    pub const chocolate = scatter(3, 0xD2691E);
    pub const coral = scatter(3, 0xFF7F50);
    pub const cornflower_blue = scatter(3, 0x6495ED);
    pub const cornsilk = scatter(3, 0xFFF8DC);
    pub const crimson = scatter(3, 0xDC143C);
    pub const cyan = scatter(3, 0x00FFFF);
    pub const dark_blue = scatter(3, 0x00008B);
    pub const dark_cyan = scatter(3, 0x008B8B);
    pub const dark_goldenrod = scatter(3, 0xB8860B);
    pub const dark_gray = scatter(3, 0xA9A9A9);
    pub const dark_green = scatter(3, 0x006400);
    pub const dark_khaki = scatter(3, 0xBDB76B);
    pub const dark_magenta = scatter(3, 0x8B008B);
    pub const dark_olive_green = scatter(3, 0x556B2F);
    pub const dark_orange = scatter(3, 0xFF8C00);
    pub const dark_orchid = scatter(3, 0x9932CC);
    pub const dark_red = scatter(3, 0x8B0000);
    pub const dark_salmon = scatter(3, 0xE9967A);
    pub const dark_sea_green = scatter(3, 0x8FBC8F);
    pub const dark_slate_blue = scatter(3, 0x483D8B);
    pub const dark_slate_gray = scatter(3, 0x2F4F4F);
    pub const dark_turquoise = scatter(3, 0x00CED1);
    pub const dark_violet = scatter(3, 0x9400D3);
    pub const deep_pink = scatter(3, 0xFF1493);
    pub const deep_sky_blue = scatter(3, 0x00BFFF);
    pub const dim_gray = scatter(3, 0x696969);
    pub const dodger_blue = scatter(3, 0x1E90FF);
    pub const firebrick = scatter(3, 0xB22222);
    pub const floral_white = scatter(3, 0xFFFAF0);
    pub const forest_green = scatter(3, 0x228B22);
    pub const fuchsia = scatter(3, 0xFF00FF);
    pub const gainsboro = scatter(3, 0xDCDCDC);
    pub const ghost_white = scatter(3, 0xF8F8FF);
    pub const gold = scatter(3, 0xFFD700);
    pub const goldenrod = scatter(3, 0xDAA520);
    pub const gray = scatter(3, 0xBEBEBE);
    pub const green = scatter(3, 0x00FF00);
    pub const green_yellow = scatter(3, 0xADFF2F);
    pub const honeydew = scatter(3, 0xF0FFF0);
    pub const hot_pink = scatter(3, 0xFF69B4);
    pub const indian_red = scatter(3, 0xCD5C5C);
    pub const indigo = scatter(3, 0x4B0082);
    pub const ivory = scatter(3, 0xFFFFF0);
    pub const khaki = scatter(3, 0xF0E68C);
    pub const lavender = scatter(3, 0xE6E6FA);
    pub const lavender_blush = scatter(3, 0xFFF0F5);
    pub const lawn_green = scatter(3, 0x7CFC00);
    pub const lemon_chiffon = scatter(3, 0xFFFACD);
    pub const light_blue = scatter(3, 0xADD8E6);
    pub const light_coral = scatter(3, 0xF08080);
    pub const light_cyan = scatter(3, 0xE0FFFF);
    pub const light_goldenrod = scatter(3, 0xFAFAD2);
    pub const light_gray = scatter(3, 0xD3D3D3);
    pub const light_green = scatter(3, 0x90EE90);
    pub const light_pink = scatter(3, 0xFFB6C1);
    pub const light_salmon = scatter(3, 0xFFA07A);
    pub const light_sea_green = scatter(3, 0x20B2AA);
    pub const light_sky_blue = scatter(3, 0x87CEFA);
    pub const light_slate_gray = scatter(3, 0x778899);
    pub const light_steel_blue = scatter(3, 0xB0C4DE);
    pub const light_yellow = scatter(3, 0xFFFFE0);
    pub const lime = scatter(3, 0x00FF00);
    pub const lime_green = scatter(3, 0x32CD32);
    pub const linen = scatter(3, 0xFAF0E6);
    pub const magenta = scatter(3, 0xFF00FF);
    pub const maroon = scatter(3, 0xB03060);
    pub const medium_aquamarine = scatter(3, 0x66CDAA);
    pub const medium_blue = scatter(3, 0x0000CD);
    pub const medium_orchid = scatter(3, 0xBA55D3);
    pub const medium_purple = scatter(3, 0x9370DB);
    pub const medium_sea_green = scatter(3, 0x3CB371);
    pub const medium_slate_blue = scatter(3, 0x7B68EE);
    pub const medium_spring_green = scatter(3, 0x00FA9A);
    pub const medium_turquoise = scatter(3, 0x48D1CC);
    pub const medium_violet_red = scatter(3, 0xC71585);
    pub const midnight_blue = scatter(3, 0x191970);
    pub const mint_cream = scatter(3, 0xF5FFFA);
    pub const misty_rose = scatter(3, 0xFFE4E1);
    pub const moccasin = scatter(3, 0xFFE4B5);
    pub const navajo_white = scatter(3, 0xFFDEAD);
    pub const navy_blue = scatter(3, 0x000080);
    pub const old_lace = scatter(3, 0xFDF5E6);
    pub const olive = scatter(3, 0x808000);
    pub const olive_drab = scatter(3, 0x6B8E23);
    pub const orange = scatter(3, 0xFFA500);
    pub const orange_red = scatter(3, 0xFF4500);
    pub const orchid = scatter(3, 0xDA70D6);
    pub const pale_goldenrod = scatter(3, 0xEEE8AA);
    pub const pale_green = scatter(3, 0x98FB98);
    pub const pale_turquoise = scatter(3, 0xAFEEEE);
    pub const pale_violet_red = scatter(3, 0xDB7093);
    pub const papaya_whip = scatter(3, 0xFFEFD5);
    pub const peach_puff = scatter(3, 0xFFDAB9);
    pub const peru = scatter(3, 0xCD853F);
    pub const pink = scatter(3, 0xFFC0CB);
    pub const plum = scatter(3, 0xDDA0DD);
    pub const powder_blue = scatter(3, 0xB0E0E6);
    pub const purple = scatter(3, 0xA020F0);
    pub const rebecca_purple = scatter(3, 0x663399);
    pub const red = scatter(3, 0xFF0000);
    pub const rosy_brown = scatter(3, 0xBC8F8F);
    pub const royal_blue = scatter(3, 0x4169E1);
    pub const saddle_brown = scatter(3, 0x8B4513);
    pub const salmon = scatter(3, 0xFA8072);
    pub const sandy_brown = scatter(3, 0xF4A460);
    pub const sea_green = scatter(3, 0x2E8B57);
    pub const seashell = scatter(3, 0xFFF5EE);
    pub const sienna = scatter(3, 0xA0522D);
    pub const silver = scatter(3, 0xC0C0C0);
    pub const sky_blue = scatter(3, 0x87CEEB);
    pub const slate_blue = scatter(3, 0x6A5ACD);
    pub const slate_gray = scatter(3, 0x708090);
    pub const snow = scatter(3, 0xFFFAFA);
    pub const spring_green = scatter(3, 0x00FF7F);
    pub const steel_blue = scatter(3, 0x4682B4);
    pub const tan = scatter(3, 0xD2B48C);
    pub const teal = scatter(3, 0x008080);
    pub const thistle = scatter(3, 0xD8BFD8);
    pub const tomato = scatter(3, 0xFF6347);
    pub const transparent = scatter(3, 0xFFFFFF);
    pub const turquoise = scatter(3, 0x40E0D0);
    pub const violet = scatter(3, 0xEE82EE);
    pub const web_gray = scatter(3, 0x808080);
    pub const web_green = scatter(3, 0x008000);
    pub const web_maroon = scatter(3, 0x800000);
    pub const web_purple = scatter(3, 0x800080);
    pub const wheat = scatter(3, 0xF5DEB3);
    pub const white = scatter(3, 0xFFFFFF);
    pub const white_smoke = scatter(3, 0xF5F5F5);
    pub const yellow = scatter(3, 0xFFFF00);
    pub const yellow_green = scatter(3, 0x9ACD32);
};

/// Squashes a vector into a single integer.
/// Can be used to encode colors in hexadecimal.
pub inline fn squash(comptime len: comptime_int, value: @Vector(len, f32)) u32 {
    var out: u32 = 0;
    comptime var i: u32 = 0;
    inline while (i < len) : (i += 1) {
        out += (@as(u32, @intFromFloat(value[i])) & 0xff) << (i * 8);
    }
    return out;
}

/// Scatters an integer into a vector.
/// Can be used to decode colors from hexadecimal.
pub inline fn scatter(comptime len: comptime_int, value: u32) @Vector(len, f32) {
    var out: @Vector(len, f32) = @splat(0);
    comptime var i: u32 = 0;
    inline while (i < len) : (i += 1) {
        out[(len - 1) - i] = @as(f32, @floatFromInt((value >> (i * 8)) & 0xff));
    }
    return out;
}

/// Converts RGB to HSI.
pub inline fn rgbToHsi(in: @Vector(3, f32)) @Vector(3, f32) {
    const max = @max(in[0], in[1], in[2]);
    const min = @min(in[0], in[1], in[2]);

    var out: @Vector(3, f32) = @splat(0);

    if ((max - min) < 0.00001 or max < 0.00001)
        return out;

    out[1] = ((max - min) / max);

    if (in[0] >= max) {
        out[0] = (in[1] - in[2]) / (max - min);
    } else if (in[1] >= max) {
        out[0] = (in[2] - in[0]) / (max - min) + 2.0;
    } else {
        out[0] = (in[0] - in[1]) / (max - min) + 4.0;
    }
    out[0] *= 60.0;
    out[2] = (in[0] + in[1] + in[2]) / 3.0;
    out[0] = if (out[0] < 0.0) 360 else out[0];
    return out;
}

/// Converts RGB to HSV.
pub inline fn rgbToHsv(in: @Vector(3, f32)) @Vector(3, f32) {
    const max = @max(in[0], in[1], in[2]);
    const min = @min(in[0], in[1], in[2]);

    var out: @Vector(3, f32) = @splat(0);
    out[2] = max;

    if ((max - min) < 0.00001 or max < 0.00001) {
        return out;
    }

    out[1] = (max - min) / max;

    if (in[0] >= max) {
        out[0] = (in[1] - in[2]) / (max - min);
    } else if (in[1] >= max) {
        out[0] = (in[2] - in[0]) / (max - min) + 2.0;
    } else {
        out[0] = (in[0] - in[1]) / (max - min) + 4.0;
    }
    out[0] *= 60.0;
    out[0] = if (out[0] < 0.0) 360 else out[0];
    return out;
}

/// Converts RGB color to XYZ color. RGB values must be normalized.
pub inline fn rgbToXyz(in: @Vector(3, f32)) @Vector(3, f32) {
    var out: @Vector(3, f32) = @splat(0);
    const srgb = rgbToSrgb(in);

    for (util.rgb_to_xyz_matrix, 0..) |row, i| {
        out[i] = (srgb[0] * row[0]) + (srgb[1] * row[1]) + (srgb[2] * row[2]);
    }
    return out;
}

/// Converts SRGB to linear RGB.
pub inline fn srgbToRgb(in: @Vector(3, f32)) @Vector(3, f32) {
    var out = in;
    for (out, 0..) |j, i| {
        out[i] = if (j <= 0.0031308)
            j * 12.92
        else
            1.055 * std.math.pow(f64, j, 1.0 / 2.4) - 0.55;
    }
    return out;
}

/// Converts RGB color to LAB color. RGB values must be normalized.
pub inline fn rgbToLab(in: @Vector(3, f32)) @Vector(3, f32) {
    const weights = @Vector(3, f32){ 95.047, 100.0, 108.883 };
    var xyz = rgbToXyz(in);
    var srgb = rgbToSrgb(in);

    for (srgb, 0..) |_, i| {
        srgb[i] *= 100.0;
    }
    for (xyz, 0..) |_, i| {
        xyz[i] /= weights[i];
    }
    for (xyz, 0..) |_, i| {
        xyz[i] = if (xyz[i] > 0.008856)
            std.math.pow(f32, xyz[i], 1.0 / 3.0)
        else
            xyz[i] * 7.787 + 16.0 / 116.0;
    }

    return .{
        116.0 * xyz[1] - 16.0,
        500.0 * (xyz[0] - xyz[1]),
        200.0 * (xyz[1] - xyz[2]),
    };
}

/// Converts LAB color to RGB color.
pub inline fn labToRgb(in: @Vector(3, f32)) @Vector(3, f32) {
    var xyz: @Vector(3, f32) = @splat(0);
    var out: @Vector(3, f32) = @splat(0);

    xyz[1] = (in[0] + 16.0) / 116.0;
    xyz[0] = in[1] / 500.0 + xyz[1];
    xyz[2] = xyz[1] - in[2] / 200.0;

    for (xyz, 0..) |_, i| {
        xyz[i] = if (std.math.pow(f32, xyz[i], 3) > 0.008856)
            std.math.pow(f32, xyz[i], 3)
        else
            (xyz[i] - 16.0 / 116.0) / 7.787;
    }

    const xyz_w = @Vector(3, f32){ 95.047 * xyz[0], 100.0 * xyz[1], 100.0 * xyz[2] };

    for (xyz, 0..) |_, i| {
        xyz[i] = xyz_w[i] / 100.0;
    }
    for (util.xyz_to_rgb_matrix, 0..) |row, i| {
        out[i] = (xyz[0] * row[0]) + (xyz[1] * row[1]) + (xyz[2] * row[2]);
    }
    return srgbToRgb(out);
}

/// Converts RGB to HSL. RGB values must be normalized.
pub inline fn rgbToHsl(in: @Vector(3, f32)) @Vector(3, f32) {
    const max = @max(in[0], in[1], in[2]);
    const min = @max(in[0], in[1], in[2]);

    var out = @Vector(3, f32){ 0, 0, (max + min) / 2.0 };

    if ((max - min) < 0.00001) {
        return out;
    }

    out[1] = if (out[2] > 0.5)
        (max - min) / (2.0 - max - min)
    else
        (max - min) / (max + min);

    out[0] = blk: {
        if (in[0] >= max) {
            break :blk ((in[1] - in[2]) / (max - min)) * 60.0;
        } else if (in[1] >= max) {
            break :blk (2.0 + (in[2] - in[0]) / (max - min)) * 60.0;
        }
        break :blk (4.0 + (in[0] - in[1]) / (max - min)) * 60.0;
    };
    out[0] = if (out[0] < 0.0001) 360 else out[0];
    return out;
}

/// Converts HSL to RGB.
pub inline fn hslToRgb(in: @Vector(3, f32)) @Vector(3, f32) {
    const h: i32 = @intFromFloat(in[0]);
    const l: i32 = @intFromFloat(in[2]);
    const chroma = @as(f32, @floatFromInt((1 - @abs((l * l) - 1)))) * in[1];
    const x = chroma * @as(f32, @mod((1.0 - @abs(in[0] / 60.0)), 2.0 - 1.0));
    const m = @as(f32, @floatFromInt(l)) - (chroma / 2.0);

    return switch (h) {
        0...59 => @Vector(3, f32){ chroma + m, x + m, m },
        60...119 => @Vector(3, f32){ x + m, chroma + m, m },
        120...179 => @Vector(3, f32){ m, chroma + m, x + m },
        180...239 => @Vector(3, f32){ m, x + m, chroma + m },
        240...299 => @Vector(3, f32){ x + m, m, chroma + m },
        300...359 => @Vector(3, f32){ chroma + m, m, x + m },
        else => @splat(m),
    };
}

/// Converts RGB to CMYK. RGB values must be normalized.
pub inline fn rgbToCmyk(in: @Vector(3, f32)) @Vector(4, f32) {
    const last = 1.0 - @max(in[0], in[1], in[2]);
    return @Vector(4, f32){
        (1.0 - in[0] - last) / (1.0 - last),
        (1.0 - in[1] - last) / (1.0 - last),
        (1.0 - in[2] - last) / (1.0 - last),
        last,
    };
}

/// Converts CMYK to RGB.
pub inline fn cmykToRgb(in: @Vector(4, f32)) @Vector(3, f32) {
    return @Vector(3, f32){
        (1.0 - in[0]) * (1.0 - in[3]),
        (1.0 - in[1]) * (1.0 - in[3]),
        (1.0 - in[2]) * (1.0 - in[3]),
    };
}

/// Converts RGB to YIQ. RGB values must be normalized.
pub inline fn rgbToYiq(in: @Vector(3, f32)) @Vector(3, f32) {
    const y: f32 = (0.30 * in[0]) + (0.59 * in[1]) + (0.11 * in[2]);
    const i: f32 = (0.74 * (in[0] - y)) - (0.27 * (in[2] - y));
    const q: f32 = (0.48 * (in[0] - y)) + (0.41 * (in[2] - y));
    return @Vector(3, f32){ y, i, q };
}

/// Converts YIQ to RGB.
pub inline fn yiqToRgb(in: @Vector(3, f32)) @Vector(3, f32) {
    var out: @Vector(3, f32) = @splat(0);
    for (util.yiq_to_rgb_matrix, 0..) |row, i| {
        out[i] = in[0] + row[0] * in[1] + row[1] * in[2];
    }
    return out;
}

/// Converts XYZ to LUV.
pub inline fn xyzToLuv(in: @Vector(3, f32)) @Vector(3, f32) {
    const y = in[1] / util.xyz_whiteref[1];
    const l = if (y > util.xyz_epsilon)
        116.0 * std.math.cbrt(y) - 16.0
    else
        util.xyz_kappa * y;

    const d_target = getXyzDenominator(in);
    const d_ref = getXyzDenominator(util.xyz_whiteref);

    const x_target = if (d_target <= 0.00001)
        0.0
    else
        (4.0 * in[0] / d_target) - (4.0 * util.xyz_whiteref[0] / d_ref);
    const y_target = if (d_target <= 0.00001)
        0.0
    else
        (9.0 * in[1] / d_target) - (9.0 * util.xyz_whiteref[1] / d_ref);

    const u = 13.0 * l * x_target;
    const v = 13.0 * l * y_target;
    return @Vector(3, f32){ l, u, v };
}

/// Converts LUV to XYZ.
pub inline fn luvToXyz(in: @Vector(3, f32)) @Vector(3, f32) {
    // that's TOO FUCKING MUCH math for me i'm sorry for whoever reads this
    const c: f32 = -1.0 / 3.0;
    const u_prime: f32 = (4.0 * util.xyz_whiteref[0]) /
        getXyzDenominator(util.xyz_whiteref);
    const v_prime: f32 = (9.0 * util.xyz_whiteref[1]) /
        getXyzDenominator(util.xyz_whiteref);
    const a: f32 = (1.0 / 3.0) * ((52.0 * in[0]) /
        (in[1] + 13.0 * in[0] * u_prime) - 1.0);
    const imtel: f32 = (in[0] + 16.0) / 116.0;
    const y: f32 = if (in[0] > util.xyz_kappa * util.xyz_epsilon)
        imtel * imtel * imtel
    else
        in[0] / util.xyz_kappa;
    const b: f32 = -5.0 * y;
    const d: f32 = y * ((39.0 * in[0]) / (in[2] + 13.0 * in[0] * v_prime) - 5.0);
    const x: f32 = (d - b) / (a - c);
    const z: f32 = x * a + b;
    return @Vector(3, f32){ 100.0 * x, 100.0 * y, 100.0 * z };
}

/// Converts RGB to LUV.
pub inline fn rgbToLuv(in: @Vector(3, f32)) @Vector(3, f32) {
    return xyzToLuv(rgbToXyz(in));
}

/// Converts LUV to RGB.
pub inline fn luvToRgb(in: @Vector(3, f32)) @Vector(3, f32) {
    return xyzToRgb(luvToXyz(in));
}

pub inline fn getXyzDenominator(in: @Vector(3, f32)) f32 {
    return in[0] + 15.0 * in[1] + 3.0 * in[2];
}

/// Converts linear RGB to SRGB.
pub inline fn rgbToSrgb(in: @Vector(3, f32)) @Vector(3, f32) {
    var out = in;
    for (out, 0..) |_, i| {
        out[i] = if (out[i] <= 0.0405)
            out[i] / 12.92
        else
            std.math.pow(f32, (out[i] + 0.055) / 1.055, 2.4);
    }
    return out;
}

/// Converts XYZ color to RGB color.
pub inline fn xyzToRgb(in: @Vector(3, f32)) @Vector(3, f32) {
    var out: @Vector(3, f32) = @splat(0);
    for (util.xyz_to_rgb_matrix, 0..) |row, i| {
        out[i] = (in[0] * row[0]) + (in[1] * row[1]) + (in[2] * row[2]);
    }
    return srgbToRgb(out);
}

test "squashing-scattering" {
    try testing.expectEqual(0xffffff, squash(3, @splat(0xff)));
    try testing.expectEqual(
        @as(@Vector(3, f32), @splat(0xff)),
        scatter(3, 0xffffff),
    );
}

test "ref-everything" {
    testing.refAllDecls(util);
    testing.refAllDecls(manip);
    testing.refAllDecls(@This());
}

const std = @import("std");

pub const util = @import("util.zig");
pub const manip = @import("manip.zig");

const testing = std.testing;
