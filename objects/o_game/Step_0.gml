
if window_get_width() != 0
{
up = mouse_wheel_up()
down = mouse_wheel_down()
if w != window_get_width() or h != window_get_height() or up or down
{
	w = window_get_width()
	h = window_get_height()
	
	zoom += (up - down)*.1
	
	view_wport[0] = w/zoom
	view_hport[0] = h/zoom
	surface_resize(application_surface, w/zoom, h/zoom)
	camera_set_view_size(view_camera[0], w/zoom, h/zoom)
	display_set_gui_size(w, h)
}
}