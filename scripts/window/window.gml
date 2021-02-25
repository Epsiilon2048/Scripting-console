// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function window(text){

with o_console
{
	scale = display_get_gui_width()/600
	if is_undefined(text)
	{
		Window.enabled = not Window.enabled
		return "Window toggled"
	}

	if text != log_list log_to_window = false

	if is_array(text)
	{
		if array_length(text) == 1 text = text[0]
		if is_array(text) text = array_to_string(text, "\n", log_window_cutoff*scale)
	}
	
	Window.set(string(text))
	Window.enabled = true
	Window.show = true
	if log_to_window
	{
		draw_set_font(font)
		Window.y -= string_height(" ")*2
	}
	else window_reset_pos()
}
return "Set window text"
}