const std = @import("std");

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
