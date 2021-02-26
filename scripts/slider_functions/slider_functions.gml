
function draw_slider(slider){ with slider {

var mx = device_mouse_x_to_gui(0)
var my = device_mouse_y_to_gui(0)

var x2 = x + width
var y2 = y - SLIDER.height

if gui_mouse_between(x, y, x2, y2) and mouse_check_button_pressed(mb_left)
{
	mouse_on = true
}

if mouse_on
{
	value = clamp( (mx - x)/width , 0, 1)
	
	if not mouse_check_button(mb_left) 
	{
		mouse_on = false
	}
}

draw_set_color(o_console.colors.body_real)
draw_rectangle(x, y, x2, y2, false)

if value > 0
{
	draw_set_color(o_console.colors.output)
	draw_rectangle(x, y, x + ceil( (x2-x)*value ), y2, false)
}

draw_set_color(c_white)
}}