
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
		embed		= color_add_hue(embed, 1)
		embed_hover	= color_add_hue(embed_hover, 1)
	}

	colors[$ dt_real]		= color_add_hue(colors[$ dt_real], 1)
	colors[$ dt_string]		= color_add_hue(colors[$ dt_string], 1)	
	colors[$ dt_asset]		= color_add_hue(colors[$ dt_asset], 1)	
	colors[$ dt_variable]	= color_add_hue(colors[$ dt_variable], 1)	
	colors[$ dt_method]		= color_add_hue(colors[$ dt_method], 1)
	colors[$ dt_instance]	= color_add_hue(colors[$ dt_instance], 1)
	colors[$ dt_room]		= color_add_hue(colors[$ dt_room], 1)
	colors[$ dt_builtinvar] = color_add_hue(colors[$ dt_builtinvar], 1)
	colors[$ dt_tag]		= color_add_hue(colors[$ dt_tag], 1)
	colors[$ dt_unknown]	= color_add_hue(colors[$ dt_unknown], 1)
	colors[$ dt_deprecated] = color_add_hue(colors[$ dt_deprecated], 1)
}

if bird_mode and colors.sprite != bird_mode_
{
	colors.sprite = bird_mode_
	colors.outline_layers += 8
}
else if not bird_mode and colors.sprite == bird_mode_
{
	colors.sprite = -1
	colors.outline_layers -= 8
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
Output.console_y = console_top - SCALE_ 15

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
			color_string = gmcl_string_color(console_string, char_pos1)
		}
		else
		{
			output_set(undefined)
		}
	}
}
#endregion

if keyboard_check_pressed(console_key) and keyboard_scope != BAR
{
	console_toggle = not console_toggle
	
	if console_toggle
	{
		keyboard_string = console_string
		keyboard_scope = BAR
	}
}

if mouse_check_button_pressed(mb_left) and not AUTOFILL.mouse_on and not OUTPUT.mouse_on
{
	keyboard_scope = BAR.mouse_on ? BAR : noone
	
	do_autofill = false
	gmcl_autofill(undefined, undefined)
}

if keyboard_check_pressed(vk_escape) 
{
	console_toggle = false
	keyboard_scope = noone
}

if console_toggle and keyboard_scope == BAR
{
	#region Apply inputs to console string
	//figure out text stuff
	var str_length = string_length(console_string)
	var char = ""

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
	endln		= keyboard_check_pressed(vk_end) and str_length > 0 and char_pos2 != str_length+1
	log_up		= keyboard_check_pressed(vk_up) and not AUTOFILL.mouse_on
	log_down	= keyboard_check_pressed(vk_down) and not AUTOFILL.mouse_on and (input_log_index != -1 or ds_list_size(input_log) == 0)
	select_all	= keyboard_check_multiple_pressed(vk_control, ord("A"))
	copy		= keyboard_check_multiple_pressed(vk_control, ord("C"))
	paste		= keyboard_check_multiple_pressed(vk_control, ord("V"))
	startword	= keyboard_check_multiple_pressed(vk_control, vk_left)  //skip to the start of a word
	endword		= keyboard_check_multiple_pressed(vk_control, vk_right)

	if (BAR.mouse_on and mouse_check_button_pressed(mb_left))
	{
		gmcl_autofill(undefined, undefined)
		
		if shift mouse_char_pos = signbool(char_pos_dir) ? char_pos1 : char_pos2
		else
		{
			char_pos1 = char_pos2
			mouse_char_pos = mouse_get_char_pos(floor)
		}
		
		char_pos1 = mouse_char_pos
		char_pos2 = mouse_char_pos
	}
	else if not (mouse_char_pos and mouse_check_button(mb_left)) mouse_char_pos = false

	var text_refresh = left or right or backspace or del or enter or startln or endln or log_up or log_down or select_all or copy or paste or startword or endword

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
		char_pos2 = str_length + not shift
		if not shift char_pos1 = char_pos2
	}
	if startln
	{
		char_pos1 = 1
		if shift char_pos2 -= (char_pos2 > str_length)
		else char_pos2 = 1
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
		color_string = gmcl_string_color(console_string, char_pos1)
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
		mouse_char_pos = false

		if paste  // For some reason there's an invisible character behind newlines when pasting, so I cant use string_replace_all :/
		{
			char = string_replace_all( clipboard_get_text(), "	", "")
			while string_pos("\n", char)
			{
				char = string_delete(string_replace(char, "\n", "; "), string_pos("\n", char)-1, 1)
			}
		}
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
		color_string = gmcl_string_color(console_string, char_pos1)
		
		do_autofill = true
		text_refresh = true
	}
	
	if backspace and (char_pos1 != 1 or (char_pos1 == 1 and char_pos1 != char_pos2)) {
		input_log_index = -1
		console_string = string_delete(console_string, max(char_pos1-(char_pos1 == char_pos2), (char_pos1 == 1)), char_pos2-char_pos1+1)
		char_pos1 = max(1, char_pos1-(char_pos1 == char_pos2))
		char_pos2 = char_pos1
		keyboard_string = console_string
		str_length = string_length(console_string)
		color_string = gmcl_string_color(console_string, char_pos1)
	}
	
	if del and char_pos2 != str_length+1 {
		input_log_index = -1
		console_string = string_delete(console_string, char_pos2, 1)
		char_pos2 = clamp(char_pos2, 1, str_length)
		char_pos1 = char_pos2
		keyboard_string = console_string
		str_length = string_length(console_string)
		color_string = gmcl_string_color(console_string, char_pos1)
	}
	
	if mouse_char_pos
	{
		var pos_floor = mouse_get_char_pos(floor)
		
		BAR.blink_step = 0
		char_pos_dir = sign(pos_floor - mouse_char_pos)
		
		if char_pos_dir == -1 or pos_floor == mouse_char_pos
		{
			char_pos1 = mouse_get_char_pos(floor)
			char_pos2 = mouse_char_pos
		}
		else
		{
			char_pos2 = mouse_get_char_pos(ceil)
			char_pos1 = mouse_char_pos
		}
		
		char_pos1 = clamp(char_pos1, 1, str_length+(mouse_char_pos == str_length+1 and char_pos1 == char_pos2))
		char_pos2 = clamp(char_pos2, 1, str_length+(mouse_char_pos == str_length+1 and char_pos1 == char_pos2))
	}
	
	if text_refresh and not enter
	{
		color_string = gmcl_string_color(console_string, char_pos1)
		BAR.blink_step = 0
	
		do_autofill = (do_autofill or backspace or del) and char_pos1 == char_pos2 and not paste
	
		if not do_autofill or del or backspace or left or right or string_pos(char, refresh_sep) gmcl_autofill(undefined, undefined)
		if do_autofill gmcl_autofill(console_string, char_pos1)
	}
	
	#endregion
	
	#region Parse command
	if enter
	{	
		gmcl_autofill(undefined, undefined)
		do_autofill = false
		
		BAR.blink_step = 0
		
		var _compile = gmcl_compile(console_string)
		var _output  = gmcl_run(_compile)
		
		if is_struct(_compile)
		{
			prev_command = console_string
			prev_compile = _compile
			
			output_set_lines(_output)
			
			ds_list_insert(input_log, 0, console_string)
			if ds_list_size(input_log) > input_log_limit ds_list_delete(input_log, input_log_limit-1)
			
			console_log_input(console_string, _output, false)
		}
		else output_set_lines(_output)
		
		console_string = ""
		keyboard_string = ""
		color_string = []
		char_pos1 = 1
		char_pos2 = 1
	}
	#endregion
	
	if console_color_time == console_color_interval color_string = gmcl_string_color(console_string, char_pos1)
	else if console_color_time != -1 console_color_time ++
}
else BAR.blink_step = 0

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

value_box_inputs()
value_box_mouse_on = false

event_commands_exec(event_commands.step_end)