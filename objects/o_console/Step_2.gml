
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

#region Enable console

if keyboard_check_multiple_pressed(console_key, vk_shift)
{
	output_set(help())
}
else if keyboard_check_pressed(console_key)
{
	console_toggle = not console_toggle
	keyboard_string = console_string
}
if keyboard_check_pressed(vk_escape) console_toggle = false
#endregion

if console_toggle and keyboard_scope == o_console
{
	#region Apply inputs to console string
	//figure out text stuff
	var str_length = string_length(console_string)

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
	startln		= keyboard_check_pressed(vk_home)
	endln		= keyboard_check_pressed(vk_end)
	log_up		= keyboard_check_pressed(vk_up)
	log_down	= keyboard_check_pressed(vk_down) and (input_log_index != -1 or ds_list_size(input_log) == 0)
	select_all	= keyboard_check_multiple_pressed(vk_control, ord("A"))
	copy		= keyboard_check_multiple_pressed(vk_control, ord("C"))
	paste		= keyboard_check_multiple_pressed(vk_control, ord("V"))
	//alt_left	= keyboard_check_multiple_pressed(vk_alt, vk_left)  //skip to the end of a word
	//alt_right	= keyboard_check_multiple_pressed(vk_alt, vk_right) //hahahahahaahahhahahhshahsahsdfkhgsljdfgjnberdfc

	if select_all
	{
		char_pos1 = 1
		char_pos2 = max(str_length, 1)
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
		else char_pos2 = min( max(1, str_length), char_pos2 )
	}
	if right
	{
		if shift and char_pos1 == char_pos2 char_pos_dir = 1
	
		if (char_pos_dir == 1 and char_pos1 != str_length+1) or not shift {
			char_pos2 = min(str_length+(not shift), char_pos2+1)
		} else if char_pos1 != str_length+1 {
			char_pos1 ++
		}
	
		if not shift char_pos1 = char_pos2
	}
	if endln
	{
		char_pos2 = str_length
		if not shift char_pos1 = str_length
	}
	if startln
	{
		char_pos1 = 1
		if not shift char_pos2 = 1
	}
	if (log_up or log_down) and ds_list_size(input_log) > 0
	{
		input_log_index = min(input_log_index + log_up-log_down, ds_list_size(input_log)-1)
		
		if input_log_index == -1 console_string = ""
		else console_string = ds_list_find_value(input_log, input_log_index)
		
		keyboard_string = console_string
		str_length = string_length(console_string)
		char_pos1 = str_length+1
		char_pos2 = char_pos1
		color_string = color_console_string(console_string)
	}
	else if log_down
	{
		console_string = ""
		keyboard_string = ""
		str_length = 0
		char_pos1 = 1
		char_pos2 = 1
		color_string = []
	}

	if str_length < string_length(keyboard_string) or (paste and clipboard_has_text()) //a char was added
	{
		var char
		
		if paste char = string_replace_all( clipboard_get_text(), "\n", ";" )
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
		str_length = string_length(console_string)
		keyboard_string = console_string
		color_string = color_console_string(console_string)
	}
	if backspace and (char_pos1 != 1 or (char_pos1 == 1 and char_pos1 != char_pos2)) {
		input_log_index = -1
		console_string = string_delete(console_string, max(char_pos1-(char_pos1 == char_pos2), (char_pos1 == 1)), char_pos2-char_pos1+1)
		char_pos1 = max(1, char_pos1-(char_pos1 == char_pos2))
		char_pos2 = char_pos1
		keyboard_string = console_string
		str_length = string_length(console_string)
		color_string = color_console_string(console_string)
	}
	if del and char_pos2 != str_length+1 {
		input_log_index = -1
		console_string = string_delete(console_string, char_pos2, 1)
		char_pos2 = clamp(char_pos2, 1, str_length)
		char_pos1 = char_pos2
		keyboard_string = console_string
		str_length = string_length(console_string)
		color_string = color_console_string(console_string)
	}
	#endregion
	
	#region Parse command
	if enter
	{	
		var _compile = console_compile(console_string)
		var _output  = console_run(_compile)
		
		if is_struct(_compile)
		{
			prev_command = console_string
			prev_compile = _compile
			prev_output  = _output
			
			var arlen = array_length(prev_output)
			O1 = (arlen > 0) ? prev_output[0] : ""
			O2 = (arlen > 1) ? prev_output[1] : ""
			O3 = (arlen > 2) ? prev_output[2] : ""
			O4 = (arlen > 3) ? prev_output[3] : ""
			O5 = (arlen > 4) ? prev_output[4] : ""
			
			ds_list_insert(input_log, 0, console_string)
			if ds_list_size(input_log) > input_log_limit ds_list_delete(input_log, input_log_limit-1)
			
			console_log_input(console_string, _output)
		}
		
		output_set_lines(_output)
		
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
			prev_exception = _exception
		}
	}
}

run_in_console = false
run_in_embed   = false

gui_mouse_x = gui_mx
gui_mouse_y = gui_my

ctx_menu_inputs()
value_box_inputs()

if (console_toggle or Output.mouse_over) and not value_box_mouse_on and mouse_check_button_pressed(mb_right)
{
	right_mb = true
}

else if (console_toggle or Output.mouse_over) and not value_box_mouse_on and right_mb and is_undefined(CTX_MENU.ctx) and not mouse_check_button(mb_right)
{
	CTX_MENU.ctx = ctx
	CTX_MENU.x = gui_mx + 10
	CTX_MENU.y = gui_my + 10
}
else if right_mb and not mouse_check_button(mb_right)
{
	right_mb = false
}

value_box_mouse_on = false

event_commands_exec(event_commands.step_end)