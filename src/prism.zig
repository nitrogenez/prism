const std = @import("std");

pub const RGB = @import("spaces/RGB.zig");
pub const HSI = @import("spaces/HSI.zig");
pub const HSV = @import("spaces/HSV.zig");
pub const XYZ = @import("spaces/XYZ.zig");

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
    pub const Red: spaces.RGB = .{ .r = 255 };
    pub const Green: spaces.RGB = .{ .g = 255 };
    pub const Blue: spaces.RGB = .{ .b = 255 };
    pub const Black: spaces.RGB = .{};
    pub const White: spaces.RGB = .{ .r = 255, .g = 255, .b = 255 };

    pub const CalmingCoral: spaces.RGB = .{ .r = 233, .g = 150, .b = 122 };
    pub const VelvetViolet: spaces.RGB = .{ .r = 128, .b = 128 };
    pub const PacificPink: spaces.RGB = .{ .r = 219, .g = 112, .b = 147 };
    pub const Pink: spaces.RGB = .{ .r = 255, .g = 192, .b = 203 };
    pub const MistyRose1: spaces.RGB = .{ .r = 255, .g = 228, .b = 225 };
    pub const Linen: spaces.RGB = .{ .r = 250, .g = 240, .b = 230 };
    pub const SteelBlue: spaces.RGB = .{ .r = 70, .g = 130, .b = 180 };
    pub const StrongAzure: spaces.RGB = .{ .g = 87, .b = 184 };
    pub const Gold1: spaces.RGB = .{ .r = 255, .g = 215 };
};
