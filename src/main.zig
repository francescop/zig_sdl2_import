const std = @import("std");
const c = @cImport({
    // See https://github.com/ziglang/zig/issues/515
    @cDefine("_NO_CRT_STDIO_INLINE", "1");
    @cInclude("stdio.h");
});

const sdl = @cImport(@cInclude("/usr/include/SDL2/SDL.h"));
// const sdl_video = @cImport(@cInclude("/usr/include/SDL2/SDL_video.h"));

const warn = std.debug.warn;

const SCREEN_WIDTH = 640;
const SCREEN_HEIGHT = 480;

pub fn main() u8 {
    if (sdl.SDL_Init(sdl.SDL_INIT_VIDEO) != 0) {
        warn("error initializing SDL: {}\n", .{sdl.SDL_GetError()});
        return 1;
    }

    var window = sdl.SDL_CreateWindow("hello_sdl2", 1, 1, SCREEN_WIDTH, SCREEN_HEIGHT, sdl.SDL_WINDOW_SHOWN);
    if (window == null) {
        _ = c.printf("error initializing SDL: %s\n", sdl.SDL_GetError());
        return 1;
    }

    var screenSurface = sdl.SDL_GetWindowSurface(window);
    _ = sdl.SDL_FillRect(screenSurface, null, sdl.SDL_MapRGB(screenSurface.*.format, 0xFF, 0xFF, 0xFF));
    _ = sdl.SDL_UpdateWindowSurface(window);
    _ = sdl.SDL_Delay(2000);
    _ = sdl.SDL_DestroyWindow(window);
    _ = sdl.SDL_Quit();

    return 0;
}
