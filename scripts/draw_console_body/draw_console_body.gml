
function draw_console_body(x1, y1, x2, y2){ with o_console {

var old_color = draw_get_color()
var old_alpha = draw_get_alpha()
var old_bm	  = gpu_get_blendmode()

var _x1 = min(x1, x2)
var _y1 = min(y1, y2)
var _x2 = max(x1, x2)
var _y2 = max(y1, y2)

if not force_body_solid and colors.body_real_alpha < 1
{
	gpu_set_blendmode(colors.body_bm)
	draw_set_alpha(colors.body_alpha)
	draw_set_color(colors.body)
	draw_rectangle(_x1, _y1, _x2, _y2, false)
}
if force_body_solid or colors.body_real_alpha > 0
{
	gpu_set_blendmode(bm_normal)
	draw_set_color(colors.body_real)
	draw_set_alpha(force_body_solid ? 1 : colors.body_real_alpha)
	draw_rectangle(_x1, _y1, _x2, _y2, false)
}
if colors.sprite != -1 
{
	gpu_set_blendmode(bm_normal)
	draw_set_alpha(colors.sprite_alpha)
	clip_rect_cutout(_x1, _y1, _x2+1, _y2+1)
	draw_sprite_tiled(colors.sprite, o_console.step, colors.sprite_anchor ? 0 : _x1, colors.sprite_anchor ? 0 : _y1)
	shader_reset()
}
if not is_undefined(colors.bevel)
{
	gpu_set_blendmode(bm_normal)
	draw_set_color(colors.bevel)
	draw_set_alpha(1)
	draw_line(_x1-1, _y2+1, _x2+1, _y2+1)
	draw_line(_x2+1, _y1-1, _x2+1, _y2)
}

draw_set_color(old_color)
draw_set_alpha(old_alpha)
gpu_set_blendmode(old_bm)
}}