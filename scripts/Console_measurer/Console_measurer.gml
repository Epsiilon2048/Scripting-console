

function console_measurer_inputs(){ with MEASURER if enabled {

var mouse_left_pressed = not mouse_on_console and not clicking_on_console and mouse_check_button_pressed(mb_left)
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
	
var w = 1//2
draw_set_color(o_console.colors.output)//o_console.colors.body_real)
repeat 1//2
{
	draw_circle(x1, y1, w+1, false)
	if not is_undefined(x2) 
	{
		draw_circle(x2, y2, w+1, false)
		draw_line(x1, y1, x2, y2)
	}
	draw_set_color(o_console.colors.output)
	w = .5
}

if not is_undefined(x2)
{
	var _x1 = min(x1, x2)
	var _x2 = max(x1, x2)
	var _y1 = min(y1, y2)
	var _y2 = max(y1, y2)
	
	if x2 >= x1
	{
		for(var xx = x2; xx >= x1; xx -= 20) draw_line(xx, y2, max(x1, xx-10), y2)
	}
	else
	{
		for(var xx = x2; xx <= x1; xx += 20) draw_line(xx, y2, min(x1, xx+10), y2)
	}
	
	if y2 >= y1
	{
		for(var yy = y2; yy >= y1; yy -= 20) draw_line(x1, yy, x1, max(y1, yy-10))
	}
	else
	{
		for(var yy = y2; yy <= y1; yy += 20) draw_line(x1, yy, x1, min(y1, yy+10))
	}
}
}}