///@description Fullscreen

var full = not window_get_fullscreen()

if full
{
	previous_scale = global.win_sc
	window_resize(display_get_width()/CAM_W)
}	
else
{
	window_resize(previous_scale)
}

window_set_fullscreen(full)