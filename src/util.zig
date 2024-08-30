const std = @import("std");

pub fn isNormalized(color: []const f64) bool {
    return for (color) |v| {
        if (v >= 1.0 or v <= 0.0) false;
    } else true;
}

pub fn toU32(color: [3]f64) [3]u32 {
    return .{
        @as(u32, @intFromFloat(color[0])),
        @as(u32, @intFromFloat(color[1])),
        @as(u32, @intFromFloat(color[2])),
    };
}

pub fn denormalize(color: [3]f64) [3]f64 {
    return .{ color[0] * 255.0, color[1] * 255.0, color[2] * 255.0 };
}

pub fn ansiEscape(writer: anytype, color: [3]f64) !void {
    try writer.writeAll("\x1b[38;2;");
    try writer.print("{d:.0};{d:.0};{d:.0}m", .{ color[0] * 255.0, color[1] * 255.0, color[2] * 255.0 });
}

pub fn ansiEscapeBuf(buffer: []const u8, color: [3]f64) ![]const u8 {
    var fbs = std.io.fixedBufferStream(buffer);
    try ansiEscape(fbs.writer(), color);
    return fbs.getWritten();
}

pub fn ansiEscapeAlloc(gpa: std.mem.Allocator, color: [3]f64) ![]const u8 {
    var buffer = std.ArrayList(u8).init(gpa);
    try ansiEscape(buffer.writer(), color);
    return buffer.toOwnedSlice();
}

pub fn colorizeW(writer: anytype, color: [3]f64, s: []const u8) !void {
    try ansiEscape(writer, color);
    try writer.writeAll(s);
    try writer.writeAll("\x1b[0m");
}

pub fn colorize(buffer: []const u8, color: [3]f64, s: []const u8) ![]const u8 {
    var fbs = std.io.fixedBufferStream(buffer);
    try colorizeW(fbs.writer(), color, s);
    return fbs.getWritten();
}

pub fn colorizeAlloc(gpa: std.mem.Allocator, color: [3]f64, s: []const u8) ![]const u8 {
    var buffer = try std.ArrayList(u8).initCapacity(gpa, s.len);
    try colorizeW(buffer.writer(), color, s);
    return buffer.toOwnedSlice();
}

pub const yiq_to_rgb_matrix = [3][2]f64{
    .{ 0.9468822170900693, 0.6235565819861433 },
    .{ 0.27478764629897834, 0.6356910791873801 },
    .{ 1.1085450346420322, 1.7090069284064666 },
};

pub const rgb_to_xyz_matrix = [3][3]f64{
    .{ 0.4124564, 0.3575761, 0.1804375 },
    .{ 0.2126729, 0.7151522, 0.0721750 },
    .{ 0.0193339, 0.1191920, 0.9503041 },
};

pub const xyz_to_rgb_matrix = [3][3]f64{
    .{ 3.2404542, -1.5371385, -0.4985314 },
    .{ -0.9692660, 1.8760108, 0.0415560 },
    .{ 0.0556434, -0.2040259, 1.0572252 },
};

pub const xyz_epsilon: f64 = 0.008856;
pub const xyz_kappa: f64 = 903.3;
pub const xyz_whiteref = [3]f64{ 95.047, 100.0, 108.883 };
