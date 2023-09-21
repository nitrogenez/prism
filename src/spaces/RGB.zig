const std = @import("std");
const Self = @This();

/// Red value (0..1)
r: f64 = 0.0,

/// Green value (0..1)
g: f64 = 0.0,

/// Blue value (0..1)
b: f64 = 0.0,

/// Returns `Self` as an array of values ranging from 0 to 255
pub fn as8bitArray(self: *const Self) [3]f64 {
    return .{ self.r * 255.0, self.g * 255.0, self.b * 255.0 };
}

/// Returns a copy of `Self` with values ranging from 0 to 255
pub fn as8bit(self: *const Self) Self {
    return .{ .r = self.r * 255.0, .g = self.g * 255.0, .b = self.b * 255.0 };
}

pub fn asArray(self: *const Self) [3]f64 {
    return .{ self.r, self.g, self.b };
}

/// Returns `true` if the values are in a range from 0 to 1
pub fn isNormalized(self: *const Self) bool {
    return (self.r >= 0.0 and self.r <= 1.0) and
        (self.g >= 0.0 and self.g <= 1.0) and
        (self.b >= 0.0 and self.b <= 1.0);
}
