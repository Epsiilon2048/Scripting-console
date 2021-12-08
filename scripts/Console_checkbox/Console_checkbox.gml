
function draw_checkbox(x, y, state, mouse_on){ with o_console.CHECKBOX {

var old_font = draw_get_font()
var old_swf_aa = draw_get_swf_aa_level()

draw_set_font(o_console.font)
draw_set_swf_aa_level(1)

var ch = string_height("W")
var asp = ch/char_height
var _width = round(width*asp)
if is_undefined(mouse_on) mouse_on = false

if state == true
{
	var col1 = mouse_on ? color_add_hsv(o_console.colors.output, 0, mouse_on_saturation_add, mouse_on_value_add) : o_console.colors.output
	var col2 = mouse_on ? color_add_hsv(o_console.colors.body_real, 0, mouse_on_saturation_add, mouse_on_value_add) : o_console.colors.body_real
	
	draw_sprite_stretched_ext(
		s_checkbox_full, 0,
		x, y, _width, _width, 
		col1, 1
	)
	
	draw_sprite_stretched_ext(
		s_checkbox_check, 0, 
		x, y, _width, _width, 
		col2, 1
	)
}
else if state == false
{
	var col1 = o_console.colors.plain
	var col2 = o_console.colors.body_real
	
	if mouse_on draw_sprite_stretched_ext(
		s_checkbox_full, 0, 
		x, y, _width, _width, 
		color_add_hsv(col2, 0, mouse_on_saturation_add, mouse_on_value_add), 1
	)
	
	draw_sprite_stretched_ext(
		s_checkbox_empty, 0, 
		x, y, _width, _width, 
		col1, 1
	)
}
else
{
	
}

draw_set_font(old_font)
draw_set_swf_aa_level(old_swf_aa)
}}

