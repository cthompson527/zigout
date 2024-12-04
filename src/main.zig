const std = @import("std");
const raylib = @cImport({
    @cInclude("raylib.h");
});

const Block = struct {
    x: c_int,
    y: c_int,
    w: c_int,
    h: c_int,
};

const Brick = struct {
    block: Block,
    is_alive: bool,
};

pub fn main() !void {
    const screen_width = 800;
    const screen_height = 450;
    const block_width = screen_width / 12;
    const block_height = screen_height / 100;
    const block_offset = block_width / 2;
    raylib.InitWindow(screen_width, screen_height, "Zigout");
    defer raylib.CloseWindow();

    raylib.SetTargetFPS(60);
    raylib.HideCursor();
    raylib.SetExitKey(raylib.KEY_Q);

    var player: Block = .{ .x = screen_width / 2 - block_offset, .y = screen_height * 0.8, .w = block_width, .h = block_height };

    var bricks: [12]Brick = [_]Brick{.{
        .block = Block{ .x = 0, .y = 0, .h = 0, .w = 0 },
        .is_alive = true,
    }} ** 12;
    for (0..bricks.len) |i| {
        const initial_offset = 40;
        const columns = 4;
        const idx: f64 = @floatFromInt(i);
        const row = @trunc(idx / columns);
        const row_height: i32 = @intFromFloat(row * 30);
        var ptr = &bricks[i].block;
        ptr.x = @intCast((screen_width / columns) * (i % columns) + initial_offset);
        ptr.y = @intCast(row_height + 50);
        ptr.w = @intCast(block_width * 2);
        ptr.h = @intCast(block_height);
    }

    while (!raylib.WindowShouldClose()) {
        raylib.BeginDrawing();
        defer raylib.EndDrawing();

        // update
        player.x = raylib.GetMouseX() - block_offset;

        // draw
        raylib.ClearBackground(raylib.BLACK);
        raylib.DrawRectangle(player.x, player.y, player.w, player.h, raylib.RED);

        for (&bricks) |brick| {
            raylib.DrawRectangle(brick.block.x, brick.block.y, brick.block.w, brick.block.h, raylib.RED);
        }
    }
}
