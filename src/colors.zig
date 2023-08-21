pub const RGB = @import("rgb.zig").RGB;
pub const HSV = @import("hsv.zig").HSV;
pub const HSL = @import("hsl.zig").HSL;
pub const YIQ = @import("yiq.zig").YIQ;

pub const Red = RGB{ .r = 255 };
pub const Green = RGB{ .g = 255 };
pub const Blue = RGB{ .b = 255 };
pub const Black = RGB{};
pub const White = RGB{ .r = 255, .g = 255, .b = 255 };
