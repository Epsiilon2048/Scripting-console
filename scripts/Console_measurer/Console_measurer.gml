

function console_measurer_inputs(){ with MEASURER if enabled {

var mouse_left_pressed = mouse_check_button_pressed(mb_left)
switch setting
{
default: 
	if mouse_left_pressed setting = 1
break
case 1:
	x1 = clamp(gui_mx, 0, gui_width)
	y1 = clamp(gui_my, 0, gui_height)
	if mouse_left_pressed setting = 2
break
case 2:
	x2 = clamp(gui_mx, 0, gui_width)
	y2 = clamp(gui_my, 0, gui_height)
	if mouse_left_pressed setting = 0
}
}}



function draw_console_measurer(){ with MEASURER if enabled {	
	
var w = 2
repeat 2
{
	draw_circle(x1, y1, w+1, false)
	if not is_undefined(x2) 
	{
		draw_circle(x2, y2, w+1, false)
		draw_set_color(o_console.colors.body_real)
		draw_line_width(x1, y1, x2, y2,w)
	}
	draw_set_color(o_console.colors.output)
	w = 1
}
}}