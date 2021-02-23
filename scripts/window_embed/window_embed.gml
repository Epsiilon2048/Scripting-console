// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function window_embed(text){

with o_console
{
	scale = display_get_gui_width()/600

	Window.set(text)
	Window.enabled = true
	Window.show = true
	if log_to_window
	{
		draw_set_font(fnt_debug)
		Window.y -= string_height(" ")*2
	}
	else window_reset_pos()
}
return "Set window text"
}