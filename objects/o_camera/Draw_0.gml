
if show
{
	draw_set_color(o_console.colors.output)
	if spd == 0 draw_circle(x, y, 1.1, true)

	draw_set_color(o_console.colors.output)
	draw_roundline(
		x,
		y,
		x + lengthdir_x(spd, direction),
		y + lengthdir_y(spd, direction),
		1
	)
	draw_set_color(c_white)
}

draw_set_color(c_white)