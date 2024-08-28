const std = @import("std");
const prism = @import("prism");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    const start = prism.color.aqua;
    const end = prism.manip.shade(start, 7.0 * 0.1);

    inline for (0..8) |i| {
        try prism.util.colorizeW(stdout, prism.manip.shade(start, @as(f64, @floatFromInt(i)) * 0.1), "gradient\n");
    }
    inline for (0..8) |i| {
        try prism.util.colorizeW(stdout, prism.manip.tint(end, @as(f64, @floatFromInt(i)) * 0.05), "gradient\n");
    }
}
