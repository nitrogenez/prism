// Copyright (c) 2024-2025, Andrij Glyko <nitrogenez.dev@tuta.io>

//! This cute little file has functions for color manipulation.
//! Tinting, shading, etc. It's good enough.

/// Lightens (tints) the color by `factor`
pub fn tint(rgb: @Vector(3, f32), factor: f32) @Vector(3, f32) {
    return @Vector(3, f32){
        rgb[0] + (1.0 - rgb[0]) * factor,
        rgb[1] + (1.0 - rgb[1]) * factor,
        rgb[2] + (1.0 - rgb[2]) * factor,
    };
}

/// Darkens (shades) the color by `factor`
pub fn shade(rgb: @Vector(3, f32), factor: f32) @Vector(3, f32) {
    return @Vector(3, f32){
        rgb[0] * (1 - factor),
        rgb[1] * (1 - factor),
        rgb[2] * (1 - factor),
    };
}

/// Blends two colors together at a certain point t
pub fn blendAt(
    rgb_rhs: @Vector(3, f32),
    rgb_lhs: @Vector(3, f32),
    t: f32,
) @Vector(3, f32) {
    return @Vector(3, f32){
        @sqrt((1.0 - t) * (rgb_rhs[0] * rgb_rhs[0]) + t * (rgb_lhs[0] * rgb_lhs[0])),
        @sqrt((1.0 - t) * (rgb_rhs[1] * rgb_rhs[1]) + t * (rgb_lhs[1] * rgb_lhs[1])),
        @sqrt((1.0 - t) * (rgb_rhs[2] * rgb_rhs[2]) + t * (rgb_lhs[2] * rgb_lhs[2])),
    };
}

/// Blends two colors
pub fn blend(rgb_rhs: @Vector(3, f32), rgb_lhs: @Vector(3, f32)) @Vector(3, f32) {
    return @Vector(3, f32){
        0.5 * rgb_rhs[0] + 0.5 * rgb_lhs[0],
        0.5 * rgb_rhs[1] + 0.5 * rgb_lhs[1],
        0.5 * rgb_rhs[2] + 0.5 * rgb_lhs[2],
    };
}

/// Saturates the color. RGB values must be normalized.
pub fn saturate(rgb: @Vector(3, f32), amount: f32) @Vector(3, f32) {
    var hsl = prism.rgbToHsl(rgb);
    hsl[1] += amount;
    hsl[1] = std.math.clamp(hsl[1], 0.0, 1.0);
    return prism.hslToRgb(hsl);
}

/// Desaturates the color. RGB values must be normalized.
pub fn desaturate(rgb: @Vector(3, f32), amount: f32) @Vector(3, f32) {
    var hsl = prism.rgbToHsl(rgb);
    hsl[1] -= amount;
    hsl[1] = std.math.clamp(hsl[1], 0.0, 1.0);
    return prism.hslToRgb(hsl);
}

/// Sets saturation `value` for `rgb`. RGB values must be normalized.
pub fn setSaturation(rgb: @Vector(3, f32), value: f32) @Vector(3, f32) {
    var hsl = prism.rgbToHsl(rgb);
    hsl[1] = value;
    hsl[1] = std.math.clamp(hsl[1], 0.0, 1.0);
    return prism.hslToRgb(hsl);
}

/// Rotates the hue of `rgb`.
pub fn rotateHue(rgb: @Vector(3, f32), amount: f32) @Vector(3, f32) {
    var hsl = prism.rgbToHsl(rgb);
    hsl[0] += amount;
    hsl[0] = std.math.clamp(hsl[0], 0.0, 360.0);
    return prism.hslToRgb(hsl);
}

const std = @import("std");
const prism = @import("root.zig");
