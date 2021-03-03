
COLOR_PICKER.size += (keyboard_check(vk_right) - keyboard_check(vk_left))

step ++

if rainbow
{
	with colors
	{
		output		= color_add_hue(output, 1)
		ex_output	= color_add_hue(ex_output, 1)
		plain		= color_add_hue(plain, 1)
		body		= color_add_hue(body, 1)
		selection	= color_add_hue(selection, 1)
	}
}

win_w = display_get_gui_width()
win_h = display_get_gui_height()

#region Redefine scaled variables
//lazy, please make better
console_right	= win_w - SCALE_ 50
console_top		= win_h - SCALE_ 90
console_bottom	= win_h - SCALE_ 50

console_text_x	= console_left + SCALE_ 18
console_text_y	= console_bottom + (console_top-console_bottom)/2

Output.noconsole_x = console_text_x
Output.noconsole_y = console_text_y

Output.console_x = console_text_x
Output.console_y = console_top - SCALE_ 12

console_object_x = console_right - SCALE_ 18
#endregion

#region Select instance if enabled
if inst_select
{
	inst_selecting = instance_position(mouse_x, mouse_y, all)
	if instance_exists(inst_selecting) inst_selecting_name = object_get_name(inst_selecting.object_index)
	else inst_selecting_name = "noone"
	
	if mouse_check_button_released(mb_left)
	{
		inst_select = false
		display(object_get_name(id.object_index)+".inst_selecting_name", false)
		
		if inst_selecting != noone
		{
			output_set(stitch("Seeking variables in ",object_get_name(inst_selecting.object_index)," ",inst_selecting))
			object = inst_selecting
			color_string = color_console_string(console_string)
		}
		else
		{
			output_set("")
		}
	}
}
#endregion

#region Var to var and var to mouse

if to_mouse_x != ""
{
	if to_mouse_gui variable_instance_set(to_mouse_x_object, to_mouse_x, device_mouse_x_to_gui(0))
	else variable_instance_set(to_mouse_x_object, to_mouse_x, mouse_x)
}
if to_mouse_y != ""
{
	if to_mouse_gui variable_instance_set(to_mouse_y_object, to_mouse_y, device_mouse_y_to_gui(0))
	else variable_instance_set(to_mouse_y_object, to_mouse_y, mouse_y)
}
if to_var != ""
{
	variable_instance_set(to_object, to_var, variable_instance_get(from_object, from_var))
}
#endregion

#region Enable console

if keyboard_check_multiple_pressed(console_key, vk_shift)
{
	output_set(help())
}
else if keyboard_check_pressed(console_key) or keyboard_check_pressed(vk_up)
{
	console_toggle = not console_toggle or (keyboard_check_pressed(vk_up)) /*and updown_enables_console)*/
	keyboard_string = console_string
}
if keyboard_check_pressed(vk_escape) console_toggle = false
#endregion

if console_toggle
{
	#region Apply inputs to console string
	//figure out text stuff
	var console_string_length = string_length(console_string)

	fleft		= (keyboard_check(vk_left)+fleft)*keyboard_check(vk_left)
	fright		= (keyboard_check(vk_right)+fright)*keyboard_check(vk_right)
	fbackspace	= (keyboard_check(vk_backspace)+fbackspace)*keyboard_check(vk_backspace)
	fdel		= (keyboard_check(vk_delete)+fdel)*keyboard_check(vk_delete)
	
	var f = step mod 2 == 0
	left		= (f and key_repeat < fleft) or keyboard_check_pressed(vk_left)
	right		= (f and key_repeat < fright) or keyboard_check_pressed(vk_right)
	shift		= keyboard_check(vk_shift)
	backspace	= (f and key_repeat < fbackspace) or keyboard_check_pressed(vk_backspace)
	del			= (f and key_repeat < fdel) or keyboard_check_pressed(vk_delete)
	enter		= keyboard_check_pressed(vk_enter)
	log_up		= keyboard_check_pressed(vk_up)
	log_down	= keyboard_check_pressed(vk_down) and input_log_index != -1
	select_all	= keyboard_check_multiple_pressed(vk_control, ord("A"))
	copy		= keyboard_check_multiple_pressed(vk_control, ord("C"))
	paste		= keyboard_check_multiple_pressed(vk_control, ord("V"))
	//alt_left	= keyboard_check_multiple_pressed(vk_alt, vk_left)  //skip to the end of a word
	//alt_right	= keyboard_check_multiple_pressed(vk_alt, vk_right) //hahahahahaahahhahahhshahsahsdfkhgsljdfgjnberdfc

	if select_all
	{
		char_pos1 = 1
		char_pos2 = max(console_string_length, 1)
	}
	if copy and char_pos1 != char_pos2
	{
		clipboard_set_text((string_copy(console_string, max(char_pos1, (char_pos1 == 1)), char_pos2-char_pos1+1)))
	}
	if left
	{
		if shift and char_pos1 == char_pos2 char_pos_dir = -1
	
		if char_pos_dir == -1 or not shift {
			char_pos1 = max(1, char_pos1-1)
		} else {
			char_pos2 --
		}
	
		if not shift char_pos2 = char_pos1
		else char_pos2 = min( max(1, console_string_length), char_pos2 )
	}
	if right
	{
		if shift and char_pos1 == char_pos2 char_pos_dir = 1
	
		if (char_pos_dir == 1 and char_pos1 != console_string_length+1) or not shift {
			char_pos2 = min(console_string_length+(not shift), char_pos2+1)
		} else if char_pos1 != console_string_length+1 {
			char_pos1 ++
		}
	
		if not shift char_pos1 = char_pos2
	}
	if (log_up or log_down) and ds_list_size(input_log) > 0
	{
		input_log_index = min(input_log_index + log_up-log_down, ds_list_size(input_log)-1)
		
		if input_log_index == -1 console_string = ""
		else console_string = ds_list_find_value(input_log, input_log_index)
		
		keyboard_string = console_string
		console_string_length = string_length(console_string)
		char_pos1 = console_string_length+1
		char_pos2 = char_pos1
		color_string = color_console_string(console_string)
	}

	if console_string_length < string_length(keyboard_string) or (paste and clipboard_has_text()) //a char was added
	{
		var char
		
		if paste char = clipboard_get_text()
		else char = keyboard_lastchar
		
		input_log_index = -1
		
		if char_pos1 != char_pos2
		{
			console_string = string_delete(console_string, char_pos1, char_pos2-char_pos1+1)
			char_pos2 = char_pos1
		}
	
		console_string = string_insert(char, console_string, char_pos1)
		char_pos1 += string_length(char)
		char_pos2 += string_length(char)
		console_string_length = string_length(console_string)
		keyboard_string = console_string
		color_string = color_console_string(console_string)
	}
	if backspace and (char_pos1 != 1 or (char_pos1 == 1 and char_pos1 != char_pos2)) {
		input_log_index = -1
		console_string = string_delete(console_string, max(char_pos1-(char_pos1 == char_pos2), (char_pos1 == 1)), char_pos2-char_pos1+1)
		char_pos1 = max(1, char_pos1-(char_pos1 == char_pos2))
		char_pos2 = char_pos1
		keyboard_string = console_string
		console_string_length = string_length(console_string)
		color_string = color_console_string(console_string)
	}
	if del and char_pos2 != console_string_length+1 {
		input_log_index = -1
		console_string = string_delete(console_string, char_pos2, 1)
		char_pos2 = clamp(char_pos2, 1, console_string_length)
		char_pos1 = char_pos2
		keyboard_string = console_string
		console_string_length = string_length(console_string)
		color_string = color_console_string(console_string)
	}
	#endregion
	
	#region Parse command
	if enter
	{	
		var _compile = console_compile(console_string)
		var _output  = console_run(_compile)
		
		if is_array(_compile) 
		{
			prev_command = console_string
			prev_compile = _compile
			prev_output  = _output
		}
		
		output_set_lines(_output)
		
		var _console_string = string_split(";", console_string)
		
		if array_length(_console_string) > 0
		{
			ds_list_insert(input_log, 0, console_string)
			if ds_list_size(input_log) > input_log_limit ds_list_delete(input_log, input_log_limit)
		}
		
		console_string = ""
		keyboard_string = ""
		color_string = []
		char_pos1 = 1
		char_pos2 = 1
	}
	#endregion
	
	if console_color_time == console_color_interval color_string = color_console_string(console_string)
	console_color_time ++
}

for(var i = 0; i <= array_length(keybinds)-1; i++)
{
	if (keyboard_check_pressed(keybinds[i].key) and not console_toggle) or keyboard_check_multiple_pressed(keybinds[i].key, vk_alt)
	{
		try keybinds[i].action()
		catch(_exception)
		{
			output_set({__embedded__: true, o: [{str: "[BIND SCRIPT ERROR]", scr: error_report, output: true}," "+_exception.message]})
			prev_longMessage = _exception.longMessage
		}
	}
}

run_in_console = false
run_in_embed   = false