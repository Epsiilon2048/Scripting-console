
mouse_on_console = false
clicking_on_console = false

run_in_console = false
run_in_embed   = false

if enabled and not initialized and keyboard_check_pressed(console_key)
{
	var init = [
		initialize_autofill_index,
		initialize_gmcl_macros,
		initialize_color_schemes,
		initialize_console_docs,
		initialize_console_graphics,
		initialize_bar_and_output,
		user_console_startup,
	]
	
	var time = get_timer()
	var t = time

	for(var i = 0; i <= array_length(init)-1; i++)
	{
		init[i]()
		
		var _t = get_timer()
		
		var ms = (_t-t)/10000
		var lag = (ms/(room_speed/100))
		show_debug_message(stitch("<< ",script_get_name(init[i])," >> Initialized in ",ms," ms (",lag," steps)"))
		
		t = _t
	}
	
	initialized = true
	
	var ms = (t-time)/10000
	var lag = (ms/(room_speed/100))
	show_debug_message(stitch("<< CONSOLE SETUP >> Initialized in ",ms," ms / ",lag," steps / ",lag/room_speed," seconds"))
}

if not enabled or not initialized exit

gui_mouse_x = gui_mx
gui_mouse_y = gui_my

var old_font = draw_get_font()
draw_set_font(o_console.font)

ctx_menu_get_input()

COLOR_PICKER.get_input()

var was_clicking = clicking_on_console
var front = -1
for(var i = 0; i <= ds_list_size(elements)-1; i++)
{
	elements[| i].get_input()
	if not was_clicking and clicking_on_console 
	{
		front = i
		was_clicking = true
	}
}
if front != -1
{
	var el = elements[| front]
	ds_list_delete(elements, front)
	ds_list_insert(elements, 0, el)
}

if not mouse_check_button(mb_left) element_dragging = noone

console_measurer_inputs()

event_commands_exec(event_commands.step_end)
step ++

draw_set_font(old_font)