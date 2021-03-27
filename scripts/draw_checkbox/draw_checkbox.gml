
function draw_checkbox(x, y, enabled, invert){ with o_console.CHECKBOX {

var _invert = is_undefined(invert) ? false : invert

if enabled
{
	var col1 = _invert ? o_console.colors.body_accent	 : o_console.colors.output
	var col2 = _invert ? o_console.colors.output : o_console.colors.body_real
	
	draw_sprite_stretched_ext(
		s_checkbox_full, 0, 
		x, y, width, width, 
		col1, 1
	)
	
	draw_sprite_stretched_ext(
		s_checkbox_check, 0, 
		x, y, width, width, 
		col2, 1
	)
}
else //if disabled
{
	var col1 = o_console.colors.plain
	
	draw_sprite_stretched_ext(
		s_checkbox_empty, 0, 
		x, y, width, width, 
		col1, 1
	)
}
}}