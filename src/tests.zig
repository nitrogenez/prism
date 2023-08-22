const std = @import("std");
const mem = std.mem;
const testing = std.testing;
const print = std.debug.print;

const prism = @import("prism.zig");
const spaces = prism.spaces;

test "RGB to HEX conversion" {
    const c = spaces.RGB{ .r = 40, .g = 40, .b = 40 };
    const hex = c.toHEX();

    var buf: [7]u8 = undefined;
    _ = try std.fmt.bufPrint(&buf, "#{x}", .{hex});

    try testing.expectEqualStrings("#282828", &buf);
}

test "RGB to HSL conversion" {
    const c = prism.colors.Red;

    const hsl = c.toHSL();
    const expected = spaces.HSL{ .h = 0.0, .s = 1.0, .l = 0.5 };

    try testing.expect((hsl.h == expected.h) and
        (hsl.s == expected.s) and
        (hsl.l == expected.l));
}

test "RGB->HSV" {
    const c = prism.colors.Red;
    const o = c.toHSV();
    const e = spaces.HSV{ .h = 0.0, .s = 1.0, .v = 1.0 };

    print("\n  Input: RGB ({d}, {d}, {d})\n", .{ c.r, c.g, c.b });
    print("  Output: HSV ({d:.2}, {d:.2}, {d:.2})\n", .{ o.h, o.s, o.v });

    try testing.expect((o.h == e.h) and (o.s == e.s) and (o.v == e.v));
}

test "RGB->YIQ" {
    prism.config.unstable_features = true;

    const c = prism.colors.Red;
    const o = c.toYIQ();
    const e = spaces.YIQ{ .y = 0.30, .i = 0.60, .q = 0.21 };
    _ = e;

    print("\n  Input: RGB ({d:.0}, {d:.0}, {d:.0})\n", .{ c.r, c.g, c.b });
    print("  Output: YIQ ({d:.2}, {d:.2}, {d:.2})\n", .{ o.y, o.i, o.q });

    return error.SkipZigTest;
    // try testing.expect((o.y == e.y) and (o.i == e.i) and (o.q == e.q));
}

test "RGB->CMYK" {
    const c = prism.colors.Red;
    const o = spaces.CMYK.fromRGB(&c);
    const e = spaces.CMYK{ .c = 0.0, .m = 1.0, .y = 1.0, .k = 0.0 };

    print("\n  Input : RGB ({d:.0}, {d:.0}, {d:.0})\n", .{ c.r, c.g, c.b });
    print("  Output: CMYK ({d:.2}, {d:.2}, {d:.2}, {d:.2})\n", .{ o.c, o.m, o.y, o.k });

    try testing.expect((o.c == e.c) and (o.m == e.m) and (o.y == e.y) and (o.k == e.k));
}

test "RGB->HSI" {
    const c = prism.colors.Red;
    const o = spaces.HSI.fromRGB(&c);
    const e = spaces.HSI{ .h = 0.0, .s = 1.0, .i = 0.3333 };

    print("\n  Input : RGB ({d:.0}, {d:.0}, {d:.0})\n", .{ c.r, c.g, c.b });
    print("  Output: HSI ({d:.2}, {d:.2}, {d:.2})\n", .{ o.h, o.s, o.i });

    try testing.expect((o.h == e.h) and (o.s == e.s) and
        (o.i >= e.i - 0.05 and o.i <= e.i + 0.05));
}

test "HSI->RGB" {
    const c = spaces.HSI.fromRGB(&prism.colors.Red);
    const o = c.toRGB();
    const e = prism.colors.Red;
    _ = e;

    print("\n  Input : HSI ({d:.0}, {d:.0}, {d:.0})\n", .{ c.h, c.s, c.i });
    print("  Output: RGB ({d:.0}, {d:.0}, {d:.0})\n", .{ o.r, o.g, o.b });

    return error.SkipZigTest;
}

test "RGB->LAB" {
    const c = prism.colors.Red;
    const o = spaces.LAB.fromRGB(&c);
    const e = spaces.LAB{ .l = 53.24, .a = 80.09, .b = 67.20 };

    print("\n  Input : RGB ({d:.0}, {d:.0}, {d:.0})\n", .{ c.r, c.g, c.b });
    print("  Output: LAB ({d:.2}, {d:.2}, {d:.2})\n", .{ o.l, o.a, o.b });

    try testing.expect((o.l <= e.l + 0.05 and o.l >= e.l - 0.05) and
        (o.a <= e.a + 0.05 and o.l >= e.l - 0.05) and
        (o.b <= e.b + 0.05 and o.b >= e.b - 0.05));
}

test "LAB->RGB" {
    const c = prism.colors.Red;
    const lab = spaces.LAB.fromRGB(&c);
    const o = lab.toRGB();

    print("\n  Input : LAB ({d:.2}, {d:.2}, {d:.2})\n", .{ lab.l, lab.a, lab.b });
    print("  Output: RGB ({d:.2}, {d:.2}, {d:.2})\n", .{ o.r, o.g, o.b });

    try testing.expect((o.r == c.r) and (o.g == c.g) and (o.b == c.b));
}

test "ASCII color printing" {
    const r = prism.colors.Red;
    const g = prism.colors.Green;
    const b = prism.colors.Blue;
    const vv = prism.colors.VelvetViolet;
    const pp = prism.colors.PacificPink;

    print("\n\x1b[38;2;{d:.0};{d:.0};{d:.0}m  Red\x1b[0m", .{ r.r, r.g, r.b });
    print("\x1b[38;2;{d:.0};{d:.0};{d:.0}m  Green\x1b[0m", .{ g.r, g.g, g.b });
    print("\x1b[38;2;{d:.0};{d:.0};{d:.0}m  Blue\x1b[0m", .{ b.r, b.g, b.b });
    print("\x1b[38;2;{d:.0};{d:.0};{d:.0}m  Velvet Violet\x1b[0m", .{ vv.r, vv.g, vv.b });
    print("\x1b[38;2;{d:.0};{d:.0};{d:.0}m  Pacific Pink\x1b[0m\n", .{ pp.r, pp.g, pp.b });
}
