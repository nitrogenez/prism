const std = @import("std");
const prism = @import("prism");

pub fn main() !void {
    var alloc = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer alloc.deinit();

    const args = try std.process.argsAlloc(alloc.allocator());
    defer std.process.argsFree(alloc.allocator(), args);

    var stdout = std.io.getStdOut().writer();
    var madness_text: []const u8 = "MADNESS!";

    if (args.len > 1) {
        for (args[1..]) |arg| {
            madness_text = arg;
        }
    }

    var rng = std.rand.DefaultPrng.init(@as(
        u64,
        @truncate(@as(u128, @bitCast(std.time.nanoTimestamp()))),
    ));

    while (true) {
        const rgb = prism.RGB{
            .r = rng.random().float(f64),
            .g = rng.random().float(f64),
            .b = rng.random().float(f64),
        };
        const c = rgb.as8bitArray();

        std.time.sleep(90 * std.time.ns_per_ms);
        try stdout.print(
            "\r\x1b[38;2;{d:.0};{d:.0};{d:.0}m{s}\x1b[0m",
            .{ c[0], c[1], c[2], madness_text },
        );
    }
    _ = try stdout.write("\x1b[0m\n");
}
