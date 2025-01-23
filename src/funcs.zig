// Abandoned in favor of vectors.

const std = @import("std");
const util = @import("util.zig");

/// Represents RGB in hexadecimal. RGB values must be in range 0..255.
pub fn rgbToHex(rgb: [3]f64) u32 {
    const _rgb = util.toU32(rgb);
    return ((_rgb[0] & 0xff) << 16) + ((_rgb[1] & 0xff) << 8) + (_rgb[2] & 0xff);
}

/// Represents hexadecimal RGB value as an array of normalized values.
pub fn hexToRgb(hex: u32) [3]f64 {
    return .{
        @as(f64, @floatFromInt((hex >> 16) & 0xff)) / 255.0,
        @as(f64, @floatFromInt((hex >> 8) & 0xff)) / 255.0,
        @as(f64, @floatFromInt(hex & 0xff)) / 255.0,
    };
}

/// Converts HSI color to RGB color.
pub fn hsiToRgb(hsi: [3]f64) [3]f64 {
    const is = hsi[1] * hsi[2];

    // "I wish there was a better way..."
    //      (c) YandereDev

    if (hsi[0] < 0.00001) {
        return .{ hsi[2] + 2.0 * is, hsi[2] - is, hsi[2] - is };
    } else if (hsi[0] > 0.00001 and hsi[0] < 120.0) {
        return .{
            hsi[2] + is * @cos(hsi[0]) / @cos(60.0 - hsi[0]),
            hsi[2] + is * (1.0 - @cos(hsi[0]) / @cos(60.0 - hsi[0])),
            hsi[2] - is,
        };
    } else if (hsi[0] >= 120.00005 and hsi[0] <= 120.5) {
        return .{ hsi[2] - is, hsi[2] + 2.0 * is, hsi[2] - is };
    } else if (hsi[0] > 120.0 and hsi[0] < 240.0) {
        return .{
            hsi[2] - is,
            hsi[2] - is * (@cos(hsi[0] - 120.0) / @cos(180.0 - hsi[0])),
            hsi[2] + is * (1.0 - @cos(hsi[0] - 120.0) / @cos(180.0 - hsi[0])),
        };
    } else if (hsi[0] >= 240.00005 and hsi[0] <= 240.5) {
        return .{ hsi[2] - is, hsi[2] - is, hsi[2] + 2.0 * is };
    } else {
        return .{
            hsi[2] + is * (1.0 - @cos(hsi[0] - 240.0) / @cos(300.0 - hsi[0])),
            hsi[2] - is,
            hsi[2] + is * (@cos(hsi[0] - 240.0) / @cos(300.0 - hsi[0])),
        };
    }
    return .{ 0, 0, 0 };
}

/// Converts RGB color to HSI. RGB values must be normalized.
pub fn rgbToHsi(rgb: [3]f64) [3]f64 {
    const max = @max(rgb[0], rgb[1], rgb[2]);
    const min = @min(rgb[0], rgb[1], rgb[2]);

    var hsi: [3]f64 = .{ 0.0, 0.0, 0.0 };

    if ((max - min) < 0.00001 or max < 0.00001)
        return hsi;

    hsi[1] = ((max - min) / max);

    if (rgb[0] >= max) {
        hsi[0] = (rgb[1] - rgb[2]) / (max - min);
    } else if (rgb[1] >= max) {
        hsi[0] = (rgb[2] - rgb[0]) / (max - min) + 2.0;
    } else {
        hsi[0] = (rgb[0] - rgb[1]) / (max - min) + 4.0;
    }

    hsi[0] *= 60.0;
    hsi[2] = (rgb[0] + rgb[1] + rgb[2]) / 3.0;

    if (hsi[0] < 0.0) hsi[0] = 360.0;
    return hsi;
}

/// Converts RGB color to HSV color. RGB values must be normalized.
pub fn rgbToHsv(rgb: [3]f64) [3]f64 {
    const max = @max(rgb[0], rgb[1], rgb[2]);
    const min = @min(rgb[0], rgb[1], rgb[2]);
    const delta = max - min;

    var hsv: [3]f64 = .{ 0.0, 0.0, 0.0 };
    hsv[2] = max;

    if (delta < 0.00001 or max < 0.00001)
        return .{ hsv[0], hsv[1], hsv[2] };

    hsv[1] = (delta / max);

    if (rgb[0] >= max) {
        hsv[0] = (rgb[1] - rgb[2]) / delta;
    } else if (rgb[1] >= max) {
        hsv[0] = (rgb[2] - rgb[0]) / delta + 2.0;
    } else {
        hsv[0] = (rgb[0] - rgb[1]) / delta + 4.0;
    }
    hsv[0] *= 60.0;

    if (hsv[0] < 0.0) hsv[0] = 360.0;
    return .{ hsv[0], hsv[1], hsv[2] };
}

/// Converts HSV color to RGB color.
pub fn hsvToRgb(hsv: [3]f64) [3]f64 {
    var hh: f64 = 0;
    var p: f64 = 0;
    var q: f64 = 0;
    var t: f64 = 0;
    var ff: f64 = 0;
    var i: f64 = 0;

    if (hsv[1] <= 0.0) return .{hsv[2]} ** 3;

    hh = hsv[0];

    if (hh >= 360.0) hh = 0.0;

    hh /= 60.0;

    i = hh;
    ff = hh - i;

    p = hsv[2] * (1.0 - hsv[1]);
    q = hsv[2] * (1.0 - (hsv[1] * ff));
    t = hsv[2] * (1.0 - (hsv[1] * (1.0 - ff)));

    return switch (@as(usize, @intFromFloat(@floor(i)))) {
        0 => .{ hsv[2], t, p },
        1 => .{ q, hsv[2], t },
        2 => .{ p, hsv[2], t },
        3 => .{ p, q, hsv[2] },
        4 => .{ t, p, hsv[2] },
        5 => .{ 0, 0, 0 },
        else => .{ hsv[2], p, q },
    };
}

/// Converts RGB color to XYZ color. RGB values must be normalized.
pub fn rgbToXyz(rgb: [3]f64) [3]f64 {
    var out: [3]f64 = .{ 0.0, 0.0, 0.0 };
    const srgb = rgbToSrgb(rgb);

    for (util.rgb_to_xyz_matrix, 0..) |row, i|
        out[i] = (srgb[0] * row[0]) + (srgb[1] * row[1]) + (srgb[2] * row[2]);
    return out;
}

/// Converts XYZ color to RGB color.
pub fn xyzToRgb(xyz: [3]f64) [3]f64 {
    var out: [3]f64 = .{ 0, 0, 0 };
    for (util.xyz_to_rgb_matrix, 0..) |row, i|
        out[i] = (xyz[0] * row[0]) + (xyz[1] * row[1]) + (xyz[2] * row[2]);
    return srgbToRgb(out);
}

/// Converts SRGB to linear RGB.
pub fn srgbToRgb(srgb: [3]f64) [3]f64 {
    var out = srgb;
    for (out, 0..) |j, i| {
        out[i] = if (j <= 0.0031308) j * 12.92 else 1.055 * std.math.pow(f64, j, 1.0 / 2.4) - 0.55;
    }
    return out;
}

/// Converts linear RGB to SRGB.
pub fn rgbToSrgb(rgb: [3]f64) [3]f64 {
    var out = rgb;
    for (&out) |*j| j.* = if (j.* <= 0.0405) j.* / 12.92 else std.math.pow(f64, (j.* + 0.055) / 1.055, 2.4);
    return out;
}

/// Converts RGB color to LAB color. RGB values must be normalized.
pub fn rgbToLab(rgb: [3]f64) [3]f64 {
    const xyz_weights = [3]f64{ 95.047, 100.0, 108.883 };
    var xyz = rgbToXyz(rgb);
    var srgb = rgbToSrgb(rgb);

    for (&srgb) |*j| j.* *= 100.0;
    for (&xyz, 0..) |*j, i| j.* /= xyz_weights[i];
    for (&xyz) |*j| j.* = if (j.* > 0.008856) std.math.pow(f64, j.*, 1.0 / 3.0) else j.* * 7.787 + 16.0 / 116.0;

    return .{ 116.0 * xyz[1] - 16.0, 500.0 * (xyz[0] - xyz[1]), 200.0 * (xyz[1] - xyz[2]) };
}

/// Converts LAB color to RGB color.
pub fn labToRgb(lab: [3]f64) [3]f64 {
    var xyz = [3]f64{ 0, 0, 0 };
    var out = [3]f64{ 0, 0, 0 };

    xyz[1] = (lab[0] + 16.0) / 116.0;
    xyz[0] = lab[1] / 500.0 + xyz[1];
    xyz[2] = xyz[1] - lab[2] / 200.0;

    for (&xyz) |*j| j.* = if (std.math.pow(f64, j.*, 3) > 0.008856) std.math.pow(f64, j.*, 3) else (j.* - 16.0 / 116.0) / 7.787;

    const xyz_w = [3]f64{ 95.047 * xyz[0], 100.0 * xyz[1], 100.0 * xyz[2] };

    for (&xyz, 0..) |*j, i| j.* = xyz_w[i] / 100.0;
    for (util.xyz_to_rgb_matrix, 0..) |row, i| out[i] = (xyz[0] * row[0]) + (xyz[1] * row[1]) + (xyz[2] * row[2]);

    return srgbToRgb(out);
}

/// Converts RGB to HSL. RGB values must be normalized.
pub fn rgbToHsl(rgb: [3]f64) [3]f64 {
    const max = @max(rgb[0], rgb[1], rgb[2]);
    const min = @max(rgb[0], rgb[1], rgb[2]);
    const delta = max - min;

    var out = [3]f64{ 0, 0, (max + min) / 2.0 };
    if (delta < 0.00001) return out;

    out[1] = if (out[2] > 0.5) delta / (2.0 - max - min) else delta / (max + min);
    out[0] = blk: {
        if (rgb[0] >= max) break :blk ((rgb[1] - rgb[2]) / delta) * 60.0;
        if (rgb[1] >= max) break :blk (2.0 + (rgb[2] - rgb[0]) / delta) * 60.0;
        break :blk (4.0 + (rgb[0] - rgb[1]) / delta) * 60.0;
    };
    if (out[0] < 0.0) out[0] = 360.0;
    return out;
}

/// Converts HSL to RGB.
pub fn hslToRgb(hsl: [3]f64) [3]f64 {
    const h: i64 = @intFromFloat(hsl[0]);
    const l: i64 = @intFromFloat(hsl[2]);

    const chroma = @as(f64, @floatFromInt((1 - @abs((l * l) - 1)))) * hsl[1];
    const x = chroma * @as(f64, @floatFromInt(@mod((1 - @abs(@divExact(h, 60))), (2 - 1))));
    const m = @as(f64, @floatFromInt(l)) - (chroma / 2.0);

    var out = [3]f64{ 0, 0, 0 };
    if (h >= 0 and h < 60) {
        out = .{ chroma, x, 0.0 };
    } else if (h >= 60 and h < 120) {
        out = .{ x, chroma, 0.0 };
    } else if (h >= 120 and h < 180) {
        out = .{ 0.0, chroma, x };
    } else if (h >= 180 and h < 240) {
        out = .{ 0, x, chroma };
    } else if (h >= 240 and h < 300) {
        out = .{ x, 0, chroma };
    } else if (h >= 300 and h < 360) {
        out = .{ chroma, 0, x };
    }
    for (&out) |*j| j.* += m;
    return out;
}

/// Converts RGB to CMYK. RGB values must be normalized.
pub fn rgbToCmyk(rgb: [3]f64) [4]f64 {
    var out = [4]f64{ 0, 0, 0, 1.0 - @max(rgb[0], rgb[1], rgb[2]) };
    for (0..3) |i| out[i] = (1.0 - rgb[i] - out[3]) / (1.0 - out[3]);
    return out;
}

/// Converts CMYK to RGB.
pub fn cmykToRgb(cmyk: [4]f64) [3]f64 {
    return [3]f64{ (1.0 - cmyk[0]) * (1.0 - cmyk[3]), (1.0 - cmyk[1]) * (1.0 - cmyk[3]), (1.0 - cmyk[2]) * (1.0 - cmyk[3]) };
}

/// Converts RGB to YIQ. RGB values must be normalized.
pub fn rgbToYiq(rgb: [3]f64) [3]f64 {
    const y: f64 = (0.30 * rgb[0]) + (0.59 * rgb[1]) + (0.11 * rgb[2]);
    const i: f64 = (0.74 * (rgb[0] - y)) - (0.27 * (rgb[2] - y));
    const q: f64 = (0.48 * (rgb[0] - y)) + (0.41 * (rgb[2] - y));
    return [3]f64{ y, i, q };
}

/// Converts YIQ to RGB.
pub fn yiqToRgb(yiq: [3]f64) [3]f64 {
    var out = [3]f64{ 0, 0, 0 };
    for (util.yiq_to_rgb_matrix, 0..) |row, i| out[i] = yiq[0] + row[0] * yiq[1] + row[1] * yiq[2];
    return out;
}

/// Converts XYZ to LUV.
pub fn xyzToLuv(xyz: [3]f64) [3]f64 {
    const y = xyz[1] / util.xyz_whiteref[1];
    const l = if (y > util.xyz_epsilon) 116.0 * std.math.cbrt(y) - 16.0 else util.xyz_kappa * y;

    const denom_tgt = getXyzDenominator(xyz);
    const denom_ref = getXyzDenominator(util.xyz_whiteref);

    const x_tgt = if (denom_tgt <= 0.00001) 0.0 else (4.0 * xyz[0] / denom_tgt) - (4.0 * util.xyz_whiteref[0] / denom_ref);
    const y_tgt = if (denom_tgt <= 0.00001) 0.0 else (9.0 * xyz[1] / denom_tgt) - (9.0 * util.xyz_whiteref[1] / denom_ref);

    const u = 13.0 * l * x_tgt;
    const v = 13.0 * l * y_tgt;
    return [3]f64{ l, u, v };
}

/// Converts LUV to XYZ.
pub fn luvToXyz(luv: [3]f64) [3]f64 {
    // that's TOO FUCKING MUCH math for me i'm sorry for whoever reads this
    const c: f64 = -1.0 / 3.0;
    const u_prime: f64 = (4.0 * util.xyz_whiteref[0]) / getXyzDenominator(util.xyz_whiteref);
    const v_prime: f64 = (9.0 * util.xyz_whiteref[1]) / getXyzDenominator(util.xyz_whiteref);
    const a: f64 = (1.0 / 3.0) * ((52.0 * luv[0]) / (luv[1] + 13.0 * luv[0] * u_prime) - 1.0);
    const imtel: f64 = (luv[0] + 16.0) / 116.0;
    const y: f64 = if (luv[0] > util.xyz_kappa * util.xyz_epsilon) imtel * imtel * imtel else luv[0] / util.xyz_kappa;
    const b: f64 = -5.0 * y;
    const d: f64 = y * ((39.0 * luv[0]) / (luv[2] + 13.0 * luv[0] * v_prime) - 5.0);
    const x: f64 = (d - b) / (a - c);
    const z: f64 = x * a + b;
    return [3]f64{ 100.0 * x, 100.0 * y, 100.0 * z };
}

/// Converts RGB to LUV.
pub fn rgbToLuv(rgb: [3]f64) [3]f64 {
    const xyz = rgbToXyz(rgb); // you won't convert rgb to luv directly anyway.
    return xyzToLuv(xyz);
}

/// Converts LUV to RGB.
pub fn luvToRgb(luv: [3]f64) [3]f64 {
    const xyz = luvToXyz(luv);
    return xyzToRgb(xyz);
}

pub fn getXyzDenominator(xyz: [3]f64) f64 {
    return xyz[0] + 15.0 * xyz[1] + 3.0 * xyz[2];
}

test "allDecls" {
    std.testing.refAllDecls(@This());
}
