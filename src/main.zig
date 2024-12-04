const std = @import("std");
const raylib = @cImport({
    @cInclude("raylib.h");
});

pub fn main() !void {
    const screen_width = 800;
    const screen_height = 450;
    raylib.InitWindow(screen_width, screen_height, "Zigout");
    defer raylib.CloseWindow();

    raylib.SetTargetFPS(60);

    while (!raylib.WindowShouldClose()) {
        raylib.BeginDrawing();
        defer raylib.EndDrawing();

        raylib.ClearBackground(raylib.GRAY);
        raylib.DrawText("Zigout initiated", 190, 190, 20, raylib.DARKGRAY);
        raylib.DrawFPS(600, 50);
    }
}
