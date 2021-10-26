
mouse_on_console = false
clicking_on_console = false

run_in_console = false
run_in_embed   = false

if enabled and not initialized and startup == -1 and keyboard_check_pressed(console_key) startup = 0

if not initialized and startup > -1
{
	if startup == 0
	{
		steps_taken = 1
		
		init_list = [
			initialize_color_schemes,
			initialize_console_graphics,
			initialize_bar_and_output,
			user_console_startup,
			
			function(){
				keyboard_scope = BAR.text_box
				BAR.text_box.scoped = true
				keyboard_string = ""
				can_run = true
				show_debug_message("<< CONSOLE SETUP >> Mandatory initialization complete; can run")
			},
			
			function(){ COLOR_PICKER.svsquare = generate_satval_square() },
			function(){ COLOR_PICKER.hstrip = generate_hue_strip() },
			
			initialize_autofill_index,
			initialize_gmcl_macros,
			initialize_console_docs,
			console_macro_add_builtin,
			index_functions,
			index_assets,
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
		var lag = (ms/(room_speed/100))
		show_debug_message(stitch("<< CONSOLE SETUP >> ",lag," steps: "+script_get_name(init_list[startup])))
		
		if stay or lag >= .5
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