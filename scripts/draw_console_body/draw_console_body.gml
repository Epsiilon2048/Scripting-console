// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function draw_console_body(x1, y1, x2, y2){ with o_console {

var _x1 = x1
var _y1 = y1
var _x2 = x2
var _y2 = y2

var color_old = draw_get_color()
var alpha_old = draw_get_alpha()
var bm_old = gpu_get_blendmode()

//if window_blur draw_surface_blur_ext(application_surface, _x1, _y1, _x2-_x1, _y2-_y1, o_game.zoom, o_game.zoom, d)

draw_set_color(colors.body)

if not force_body_solid 
{
	gpu_set_blendmode(colors.body_bm)
	draw_set_alpha(colors.body_alpha)
}

draw_rectangle(_x1, _y1, _x2, _y2, false)

draw_set_color(color_old)
draw_set_alpha(alpha_old)
gpu_set_blendmode(bm_old)

}}