
if mouse_check_button_pressed(mb_right)
{
	mouse_x_previous = mouse_x
	mouse_y_previous = mouse_y
}

if mouse_check_button(mb_right)
{
	x += mouse_x-mouse_x_previous
	y += mouse_y-mouse_y_previous
	mouse_x_previous = mouse_x
	mouse_y_previous = mouse_y
}