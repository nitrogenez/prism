const std = @import("std");

pub const spaces = struct {
    pub const RGB = @import("colorspaces/rgb.zig").RGB;
    pub const HSL = @import("colorspaces/hsl.zig").HSL;
    pub const HSV = @import("colorspaces/hsv.zig").HSV;
    pub const YIQ = @import("colorspaces/yiq.zig").YIQ;
    pub const CMYK = @import("colorspaces/cmyk.zig").CMYK;
    pub const HSI = @import("colorspaces/hsi.zig").HSI;
    pub const LAB = @import("colorspaces/lab.zig").LAB;
    pub const XYZ = @import("colorspaces/xyz.zig").XYZ;
};

pub const colors = struct {
    const RGB = spaces.RGB;

    pub const Red: RGB = .{ .r = 255 };
    pub const Green: RGB = .{ .g = 255 };
    pub const Blue: RGB = .{ .b = 255 };
    pub const Black: RGB = .{};
    pub const White: RGB = .{ .r = 255, .g = 255, .b = 255 };

    pub const CalmingCoral: RGB = .{ .r = 233, .g = 150, .b = 122 };
    pub const VelvetViolet: RGB = .{ .r = 128, .b = 128 };
    pub const PacificPink: RGB = .{ .r = 219, .g = 112, .b = 147 };
    pub const Pink: RGB = .{ .r = 255, .g = 192, .b = 203 };
    pub const MistyRose1: RGB = .{ .r = 255, .g = 228, .b = 225 };
    pub const Linen: RGB = .{ .r = 250, .g = 240, .b = 230 };
    pub const SteelBlue: RGB = .{ .r = 70, .g = 130, .b = 180 };
    pub const StrongAzure: RGB = .{ .g = 87, .b = 184 };
    pub const Gold1: RGB = .{ .r = 255, .g = 215 };
};
