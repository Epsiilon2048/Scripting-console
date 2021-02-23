
draw_set_color(c_white)

x = mouse_x
y = mouse_y

if show
{
	gpu_set_blendmode_ext(bm_inv_dest_color, bm_zero)
	draw_circle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), 3, false)
	gpu_set_blendmode(bm_normal)
}