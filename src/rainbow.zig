const std = @import("std");
const prism = @import("prism");

const print = std.debug.print;

const RGB = prism.spaces.RGB;

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);

    var text: []const u8 = "Rainbow!";
    var once: bool = false;

    if (args.len > 1) {
        for (args[1..]) |arg| {
            if (arg[0] == '-') {
                if (arg[1] == '-') {
                    once = std.mem.eql(u8, arg[2..], "once");
                }
            } else {
                text = arg;
            }
        }
    }

    var cols = std.ArrayList(RGB).init(std.heap.page_allocator);

    try cols.append(.{ .r = 255 });
    try cols.append(.{ .r = 255, .g = 127 });
    try cols.append(.{ .r = 255, .g = 255 });
    try cols.append(.{ .g = 255 });
    try cols.append(.{ .b = 255 });
    try cols.append(.{ .r = 75, .b = 211 });
    try cols.append(.{ .r = 148, .b = 211 });

    if (once) {
        const seed = @as(u64, @truncate(@as(u128, @bitCast(std.time.nanoTimestamp()))));
        var prng = std.rand.DefaultPrng.init(seed);

        var i = prng.random().intRangeAtMost(usize, 0, cols.items.len - 1);
        var c = cols.items[i];

        print("\r\x1b[38;2;{d:.0};{d:.0};{d:.0}m{s}\x1b[0m\n", .{ c.r, c.g, c.b, text });
        return;
    }

    while (true) {
        for (cols.items) |c| {
            std.time.sleep(60 * std.time.ns_per_ms);
            print("\r\x1b[38;2;{d:.0};{d:.0};{d:.0}m{s}\x1b[0m", .{ c.r, c.g, c.b, text });
        }
    }
    print("\n");
}
