const std = @import("std");
const prism = @import("root.zig");

/// Lightens (tints) the color by `factor`
pub fn tint(rgb: [3]f64, factor: f64) [3]f64 {
    return .{
        rgb[0] + (1.0 - rgb[0]) * factor,
        rgb[1] + (1.0 - rgb[1]) * factor,
        rgb[2] + (1.0 - rgb[2]) * factor,
    };
}

/// Darkens (shades) the color by `factor`
pub fn shade(rgb: [3]f64, factor: f64) [3]f64 {
    return .{ rgb[0] * (1 - factor), rgb[1] * (1 - factor), rgb[2] * (1 - factor) };
}

/// Blends two colors together at a certain point t
pub fn blendAt(rgb_rhs: [3]f64, rgb_lhs: [3]f64, t: f64) [3]f64 {
    return [3]f64{
        @sqrt((1.0 - t) * (rgb_rhs[0] * rgb_rhs[0]) + t * (rgb_lhs[0] * rgb_lhs[0])),
        @sqrt((1.0 - t) * (rgb_rhs[1] * rgb_rhs[1]) + t * (rgb_lhs[1] * rgb_lhs[1])),
        @sqrt((1.0 - t) * (rgb_rhs[2] * rgb_rhs[2]) + t * (rgb_lhs[2] * rgb_lhs[2])),
    };
}

/// Blends two colors
pub fn blend(rgb_rhs: [3]f64, rgb_lhs: [3]f64) [3]f64 {
    return [3]f64{
        0.5 * rgb_rhs[0] + 0.5 * rgb_lhs[0],
        0.5 * rgb_rhs[1] + 0.5 * rgb_lhs[1],
        0.5 * rgb_rhs[2] + 0.5 * rgb_lhs[2],
    };
}

/// Saturates the color. RGB values must be normalized. `amount` = 0...1
pub fn saturate(rgb: [3]f64, amount: f64) [3]f64 {
    var hsl = prism.rgbToHsl(rgb);
    hsl[1] += amount;
    hsl[1] = std.math.clamp(hsl[1], 0.0, 1.0);
    return prism.hslToRgb(hsl);
}

/// Desaturates the color. RGB values must be normalized. `amount` = 0...1
pub fn desaturate(rgb: [3]f64, amount: f64) [3]f64 {
    var hsl = prism.rgbToHsl(rgb);
    hsl[1] -= amount;
    hsl[1] = std.math.clamp(hsl[1], 0.0, 1.0);
    return prism.hslToRgb(hsl);
}

/// Sets saturation `value` for `rgb`. RGB values must be normalized. `value` = 0...1
pub fn setSaturation(rgb: [3]f64, value: f64) [3]f64 {
    var hsl = prism.rgbToHsl(rgb);
    hsl[1] = value;
    hsl[1] = std.math.clamp(hsl[1], 0.0, 1.0);
    return prism.hslToRgb(hsl);
}

/// Rotates the hue of `rgb`. `amount` = 0...1
pub fn rotateHue(rgb: [3]f64, amount: f64) [3]f64 {
    var hsl = prism.rgbToHsl(rgb);
    hsl[0] += amount;
    hsl[0] = std.math.clamp(hsl[0], 0.0, 360.0);
    return prism.hslToRgb(hsl);
}
