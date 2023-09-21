const std = @import("std");
const RGB = @import("RGB.zig");
const Self = @This();

const ConversionError = error{
    NotNormalized,
};

/// This is a matrix used to convert RGB values to XYZ.
pub const from_rgb_matrix = [3][3]f64{
    .{ 0.4124564, 0.3575761, 0.1804375 },
    .{ 0.2126729, 0.7151522, 0.0721750 },
    .{ 0.0193339, 0.1191920, 0.9503041 },
};

/// And that matrix is used to convert XYZ values to RGB.
pub const to_rgb_matrix = [3][3]f64{
    .{ 3.2404542, -1.5371385, -0.4985314 },
    .{ -0.9692660, 1.8760108, 0.0415560 },
    .{ 0.0556434, -0.2040259, 1.0572252 },
};

x: f64 = 0.0,
y: f64 = 0.0,
z: f64 = 0.0,

/// Turns `self` into `[3]f64`.
pub fn asArray(self: *const Self) [3]f64 {
    return .{ self.x, self.y, self.z };
}

/// This function is used to create XYZ values from RGB
pub fn initFromRgb(rgb: *const RGB) ConversionError!Self {
    if (!rgb.isNormalized()) {
        return ConversionError.NotNormalized;
    }

    var rgb_: [3]f64 = rgb.asArray();
    var xyz: [3]f64 = .{ 0.0, 0.0, 0.0 };

    for (rgb_, 0..) |j, i| {
        rgb_[i] = if (j <= 0.0405) j / 12.92 else std.math.pow(f64, (j + 0.055) / 1.055, 2.4);
    }

    for (from_rgb_matrix, 0..) |j, i| {
        xyz[i] = (rgb_[0] * j[0]) + (rgb_[1] * j[1]) + (rgb_[2] * j[2]);
    }
    return .{ .x = xyz[0], .y = xyz[1], .z = xyz[2] };
}

/// Converts XYZ value to RGB
pub fn asRgb(self: *const Self) RGB {
    const xyz = self.asArray();
    var rgb: [3]f64 = .{ 0.0, 0.0, 0.0 };

    for (to_rgb_matrix, 0..) |j, i| {
        rgb[i] = (xyz[0] * j[0]) + (xyz[1] * j[1]) + (xyz[2] * j[2]);
    }

    for (rgb, 0..) |j, i| {
        rgb[i] = if (j <= 0.0031308) j * 12.92 else 1.055 * std.math.pow(f64, j, 1.0 / 2.4) - 0.55;
    }
    return .{ .r = rgb[0], .g = rgb[1], .b = rgb[2] };
}

/// Create XYZ value from RGB value array. Just a wrapper for `initFromRgb()`.
pub fn init(rgb: [3]f64) Self {
    return initFromRgb(&RGB{ rgb[0], rgb[1], rgb[2] });
}
