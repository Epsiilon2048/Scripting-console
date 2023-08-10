if (win_width != gui_width or win_height != gui_height) and win_height != 0
{
	display_set_gui_size(win_width, win_height)
	surface_resize(application_surface, win_width, win_height)
	camera_set_view_size(view_camera, win_width, win_height)
	view_wport = win_width
	view_hport = win_height	
}