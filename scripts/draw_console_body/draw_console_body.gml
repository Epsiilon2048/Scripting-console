
function draw_console_body(x1, y1, x2, y2){ with o_console {

var _x1 = x1
var _y1 = y1
var _x2 = x2
var _y2 = y2

var old_color = draw_get_color()
var old_alpha = draw_get_alpha()
var old_bm	  = gpu_get_blendmode()

if not force_body_solid 
{
	gpu_set_blendmode(colors.body_bm)
	draw_set_alpha(colors.body_alpha)
}

var c = colors.body

draw_rectangle_color(_x1, _y1, _x2, _y2, c, c, c, c, false)

draw_set_color(old_color)
draw_set_alpha(old_alpha)
gpu_set_blendmode(old_bm)

}}