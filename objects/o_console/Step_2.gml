
mouse_on_console = false
clicking_on_console = false

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

if keyboard_check_pressed(console_key) and keyboard_scope == noone
{
	BAR.enabled = not BAR.enabled
	
	if BAR.enabled
	{
		keyboard_string = ""
		BAR.text_box.scoped = true
		o_console.keyboard_scope = BAR.text_box
	}
}

if keyboard_check_pressed(vk_escape) 
{
	BAR.enabled = false
	BAR.text_box.scoped = false
	o_console.keyboard_scope = noone
}

if BAR.enabled and keyboard_scope == BAR.text_box
{
	enter		= keyboard_check_pressed(vk_enter)
	log_up		= keyboard_check_pressed(vk_up)
	log_down	= keyboard_check_pressed(vk_down)
	
	if log_up and ds_list_size(input_log)
	{
		if input_log_index == -1 and input_log_save = console_string
		input_log_index = min(input_log_index+1, ds_list_size(input_log)-1)
		console_string = input_log[| input_log_index]
	}
	else if log_down
	{
		if input_log_index == 0
		{
			input_log_index = -1
			console_string = input_log_save
			input_log_save = ""
		}
		else if input_log_index != -1
		{
			input_log_index --
			console_string = input_log[| input_log_index]
		}
	}
	
	if log_up or log_down
	{
		BAR.text_box.blink_step = 0
		BAR.text_box.char_pos1 = string_length(console_string)
		BAR.text_box.char_pos2 = BAR.text_box.char_pos1
		BAR.text_box.char_pos_selection = false
	}
	
	#region Parse command
	if enter
	{	
		var _compile = gmcl_compile(console_string)
		var _output  = gmcl_run(_compile)
		
		if is_struct(_compile)
		{
			prev_command = console_string
			prev_compile = _compile
			
			output_set_lines(_output)
			
			input_log_index = -1
			ds_list_insert(input_log, 0, console_string)
			if ds_list_size(input_log) > input_log_limit ds_list_delete(input_log, input_log_limit-1)
			
			console_log_input(console_string, _output, false)
		}
		else output_set_lines(_output)
		
		BAR.text_box.blink_step = 0
		keyboard_string = ""
		console_string = ""
	}
	#endregion
	
	with BAR
	{
		text_box.cbox_left = left
		text_box.cbox_top = top
		text_box.cbox_right = right
		text_box.cbox_bottom = bottom
		text_box.get_input()
	}
	
	if BAR.text_box.text_changed and input_log_index != -1
	{
		input_log_index = -1
		input_log_save = ""
	}
}
else BAR.blink_step = 0

for(var i = 0; i <= array_length(keybinds)-1; i++)
{
	if (keyboard_check_pressed(keybinds[i].key) and not BAR.enabled) or keyboard_check_multiple_pressed(keybinds[i].key, vk_alt)
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

event_commands_exec(event_commands.step_end)