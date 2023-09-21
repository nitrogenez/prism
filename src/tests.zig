const std = @import("std");
const testing = std.testing;

const RGB = @import("spaces/RGB.zig");
const HSI = @import("spaces/HSI.zig");
const XYZ = @import("spaces/XYZ.zig");

fn feql(lhs: f64, rhs: f64) bool {
    return std.math.fabs(lhs - rhs) < std.math.floatEps(f64);
}

test "HSI.initFromRgb" {
    const act = try HSI.initFromRgb(&RGB{ .r = 1.0 });
    const exp = HSI{ .h = 0.0, .s = 1.0, .i = 0.3333333333333333 };

    try testing.expect(feql(act.h, exp.h) and
        feql(act.s, exp.s) and
        feql(act.i, exp.i));
}

test "HSI.asRgb" {
    const act = HSI.asRgb(&HSI{ .h = 0.0, .s = 1.0, .i = 0.3333333333333333 });
    const exp = RGB{ .r = 1.0 };

    try testing.expect(exp.r == act.r);
}

test "XYZ.initFromRgb" {
    const act = try XYZ.initFromRgb(&RGB{ .r = 1.0 });
    const exp = XYZ{ .x = 4.124564e-01, .y = 2.126729e-01, .z = 1.93339e-02 };

    try testing.expect(feql(act.x, exp.x) and
        feql(act.y, exp.y) and feql(act.z, exp.z));
}
