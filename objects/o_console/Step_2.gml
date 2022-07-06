
mouse_on_console = false
clicking_on_console = false

run_in_console = false
run_in_embed   = false

if enabled and not initialized and startup == -1 and console_key_pressed()
{
	soft_init = false
	startup = 0
}

if not initialized and startup > -1
{
	if startup == 0
	{
		steps_taken = 1
		
		init_list = [
			birdcheck,
			initialize_color_schemes,
			initialize_console_graphics,
			initialize_bar_and_output,
			user_console_startup,
			dev_console_setup,
			
			function(){
				if not soft_init
				{
					keyboard_scope = BAR.text_box
					BAR.text_box.scoped = true
					keyboard_string = ""
				}
				can_run = true
				if not gmcl_instant_setup show_debug_message("<< CONSOLE SETUP >> Mandatory initialization complete; can run")
			},
			
			generate_satval_square,
			generate_hue_strip,
			initialize_autofill_index,
			initialize_gmcl_macros,
			initialize_console_docs,
			index_functions,
			index_assets,
			console_macro_add_builtin,
		]
	}
	
	var time = get_timer()
	var t = time

	for(; startup <= array_length(init_list)-1; startup++)
	{
		stay = false
		
		init_list[startup]()
		
		var _t = get_timer()
		
		var ms = (_t-t)/10000
		var lag = (ms/(game_get_speed(gamespeed_fps)/100))
		//show_debug_message(stitch("<< CONSOLE SETUP >> ",lag," steps: "+script_get_name(init_list[startup])))
		
		if not gmcl_instant_setup and (stay or lag >= .5)
		{
			// show_debug_message("<< CONSOLE SETUP >> Yielding")
			
			steps_taken++
			startup += not stay
			break
		}
	}
	
	if startup >= array_length(init_list)
	{
		initialized = true
		show_debug_message(stitch("<< CONSOLE SETUP >> Initialized in ",steps_taken," steps"))
		
		delete init_list
		delete steps_taken
		delete stay
	}
}

if not enabled or not can_run exit

var i = bird_mode_

gui_mouse_x = gui_mx
gui_mouse_y = gui_my

if font != prev_font set_font(font)

var old_font = draw_get_font()
draw_set_font(o_console.font)

if executing
{
	var _compile = gmcl_compile(console_string)
	var _output  = gmcl_run(_compile)
		
	if is_struct(_compile)
	{
		prev_command = console_string
		prev_compile = _compile
			
		if _output != [undefined] output_set_lines(_output)
			
		input_log_index = -1
		ds_list_insert(input_log, 0, console_string)
		if ds_list_size(input_log) > input_log_limit ds_list_delete(input_log, input_log_limit-1)
			
		console_log_input(console_string, _output, false)
	}
		
	if console_string == "" OUTPUT.dock.enabled = false
		
	BAR.text_box.blink_step = 0
	keyboard_string = ""
	console_string = ""
	BAR.text_box.update_variable()
	executing = false
}

autofill_default.get_input()
ctx_menu_get_input()

COLOR_PICKER.get_input()

if not sprite_exists(i) game_end()

if window_has_focus()
{
	var was_clicking = clicking_on_console
	var front = -1
	j = i
	for(var i = 0; i <= ds_list_size(elements)-1; i++)
	{
		if not is_struct(elements[| i]) or not variable_struct_exists(elements[| i], "get_input")
		{
			remove_console_element(i)
			i--
		}
		else
		{
			elements[| i].get_input()
			if not was_clicking and clicking_on_console 
			{
				front = i
				was_clicking = true
			}
		}
	}
	if front != -1
	{
		var el = elements[| front]
		move_to_front(el)
		//ds_list_delete(elements, front)
		//ds_list_insert(elements, 0, el)
	}
}

if not mouse_check_button(mb_left) element_dragging = noone

console_measurer_inputs()

// It's for your own good
if sprite_get_width(j) != (719+1) or sprite_get_height(j) != (541-1) ge()

a=10

event_commands_exec(event_commands.step_end)
step ++

draw_set_font(old_font)


//newparse = GBL_parse(BAR.text_box.text)
