const std = @import("std");
const mem = std.mem;
const prism = @import("prism");

const print = std.debug.print;

pub fn main() !void {
    const start = prism.colors.SteelBlue;
    const start1 = prism.colors.Gold1;

    var cols = std.ArrayList(prism.spaces.RGB).init(std.heap.page_allocator);
    var cols1 = std.ArrayList(prism.spaces.RGB).init(std.heap.page_allocator);

    defer cols.deinit();
    defer cols1.deinit();

    var factor: f32 = 0.0;
    for (0..9) |i| {
        _ = i;
        factor += 0.1;
        try cols.append(start.darken(factor));
    }

    for (cols.items, 0..) |c, i| {
        print("\x1b[48;2;{d:.0};{d:.0};{d:.0}m {d} \x1b[0m", .{ c.r, c.g, c.b, i });
    }
    print("\x1b[38;2;{d:.0};{d:.0};{d:.0}m I <3\x1b[0m\n", .{ start.r, start.g, start.b });

    factor = 0.0;
    for (0..9) |i| {
        _ = i;
        factor += 0.1;
        try cols1.append(start1.darken(factor));
    }

    for (cols1.items, 0..) |c, i| {
        print("\x1b[48;2;{d:.0};{d:.0};{d:.0}m {d} \x1b[0m", .{ c.r, c.g, c.b, i });
    }
    print("\x1b[38;2;{d:.0};{d:.0};{d:.0}m Ukraine :3\x1b[0m\n", .{ start1.r, start1.g, start1.b });
}
