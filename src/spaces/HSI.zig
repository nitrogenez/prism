const std = @import("std");
const RGB = @import("RGB.zig");
const Self = @This();

/// Returned by any conversion function here.
///
/// + `NotNormalized` means that the values are not ranging from 0 to 1
const ConversionError = error{
    NotNormalized,
};

/// Hue value in degrees (0..360)
h: f64 = 0.0,

/// Saturation value (0..1)
s: f64 = 0.0,

/// Intensity value (0..1)
i: f64 = 0.0,

/// Convert RGB color to HSI.
/// Returns `ConversionError` if something goes wrong.
pub fn initFromRgb(rgb: *const RGB) ConversionError!Self {
    // Values must be normalized beforehand
    if (!rgb.isNormalized()) {
        return ConversionError.NotNormalized;
    }

    // Calculating the max and min color value and the difference between them.
    const max = @max(rgb.r, rgb.g, rgb.b);
    const min = @min(rgb.r, rgb.g, rgb.b);
    const delta = max - min;

    // Initializing from the list, just to be verbose.
    var hsi: [3]f64 = .{ 0.0, 0.0, 0.0 };

    // If color values are undefined or the color is black.
    if (delta < 0.00001 or max < 0.00001)
        return .{ .h = hsi[0], .s = hsi[1], .i = hsi[2] };

    hsi[1] = (delta / max);

    // Finding out which color is the max
    if (rgb.r >= max) {
        hsi[0] = (rgb.g - rgb.b) / delta;
    } else if (rgb.g >= max) {
        hsi[0] = (rgb.b - rgb.r) / delta + 2.0;
    } else {
        hsi[0] = (rgb.r - rgb.g) / delta + 4.0;
    }

    hsi[0] *= 60.0;
    hsi[2] = (rgb.r + rgb.g + rgb.b) / 3.0;

    if (hsi[0] < 0.0) hsi[0] = 360.0;
    return .{ .h = hsi[0], .s = hsi[1], .i = hsi[2] };
}

pub fn asRgb(self: *const Self) RGB {
    // I don't know about you, but working with arrays is much easier.
    var rgb: [3]f64 = .{ 0.0, 0.0, 0.0 };
    var hsi: [3]f64 = self.asArray();

    const is = hsi[2] * hsi[1];

    // "I wish there was a better way..."
    //      (c) YandereDev
    if (hsi[0] < 0.00001) {
        rgb = .{ hsi[2] + 2.0 * is, hsi[2] - is, hsi[2] - is };
    } else if (hsi[0] > 0.00001 and hsi[0] < 120.0) {
        rgb[0] = hsi[2] + is * @cos(hsi[0]) / @cos(60.0 - hsi[0]);
        rgb[1] = hsi[2] + is * (1.0 - @cos(hsi[0]) / @cos(60.0 - hsi[0]));
        rgb[2] = hsi[2] - is;
    } else if (hsi[0] >= 120.00005 and hsi[0] <= 120.5) {
        rgb = .{ hsi[2] - is, hsi[2] + 2.0 * is, hsi[2] - is };
    } else if (hsi[0] > 120.0 and hsi[0] < 240.0) {
        rgb[0] = hsi[2] - is;
        rgb[1] = hsi[2] - is * (@cos(hsi[0] - 120.0) / @cos(180.0 - hsi[0]));
        rgb[2] = hsi[2] + is * (1.0 - @cos(hsi[0] - 120.0) / @cos(180.0 - hsi[0]));
    } else if (hsi[0] >= 240.00005 and hsi[0] <= 240.5) {
        rgb = .{ hsi[2] - is, hsi[2] - is, hsi[2] + 2.0 * is };
    } else {
        rgb[0] = hsi[2] + is * (1.0 - @cos(hsi[0] - 240.0) / @cos(300.0 - hsi[0]));
        rgb[1] = hsi[2] - is;
        rgb[2] = hsi[2] + is * (@cos(hsi[0] - 240.0) / @cos(300.0 - hsi[0]));
    }
    return .{ .r = rgb[0], .g = rgb[1], .b = rgb[0] };
}

/// Convert `rgb` to HSI. That's just a wrapper for `initFromRgb()`.
pub fn init(rgb: [3]f64) ConversionError!Self {
    return initFromRgb(&RGB{ .r = rgb[0], .g = rgb[1], .b = rgb[2] });
}

/// Returns `self` as an array.
pub fn asArray(self: *const Self) [3]f64 {
    return .{ self.h, self.s, self.i };
}
