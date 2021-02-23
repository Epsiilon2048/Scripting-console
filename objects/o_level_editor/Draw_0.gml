
if editing
{
var xx = snap(mouse_x)
var yy = snap(mouse_y)

draw_sprite_ext(s_tile_cursor9, 0, xx, yy, 1, 1, 0, o_console.colors.output, 1)

gpu_set_blendmode(o_console.colors.body_bm)
draw_sprite_ext(s_tile_cursor9_outline1, 0, xx, yy, 1, 1, 0, o_console.colors.body, 1)
draw_sprite_ext(s_tile_cursor9_outline2, 0, xx, yy, 1, 1, 0, o_console.colors.body, 1)
gpu_set_blendmode(bm_normal)
}