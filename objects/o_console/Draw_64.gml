
//if window_get_cursor() == cr_handpoint window_set_cursor(cr_default)

#region Deal with mouse inputs
if mouse_check_button_pressed(mb_left) and not Output.mouse_over_embed
{
	mouse_starting_x = mouse_x
	mouse_starting_y = mouse_y
}
else if mouse_check_button_released(mb_left) and 
		not is_undefined(mouse_starting_x) and not is_undefined(mouse_starting_y) and
		abs(mouse_starting_x - mouse_x) < mouse_click_range and 
		abs(mouse_starting_y - mouse_y) < mouse_click_range
{
	if Display.enabled and Display.mouse_over_sidebar	Display.show = not Display.show
	else if Window.enabled and Window.mouse_over_sidebar	Window.show = not Window.show
	else if Output.mouse_over and not Output.mouse_over_embed and output_set_window and not output_as_window
	{
		window_embed(Output.text)
		output_set()
	}
}

else if not mouse_check_button(mb_left)
{
	mouse_starting_x = undefined
	mouse_starting_y = undefined
}
#endregion

if inst_select and inst_selecting != noone {
	draw_instance_cursor(x_to_gui(inst_selecting.x), y_to_gui(inst_selecting.y), inst_selecting_name)
}	
else if instance_cursor and instance_exists(object) {
	draw_instance_cursor(x_to_gui(object.x), y_to_gui(object.y), object_get_name(object.object_index))
	//make it so that you can see the cursor even if its out of frame
}

if not output_as_window and ((Output.alpha > 0 or console_toggle) or force_output) and Output.plaintext != ""
{
	
	draw_set_font(font)
	draw_set_halign(fa_left)
	draw_set_valign(fa_top) //manually drawn from bottom however

	if console_toggle
	{
		Output.x		 = Output.console_x
		Output.y		 = Output.console_y
		Output.fade_time = 0
		Output.alpha	 = 1
	}
	else
	{
		Output.x		 = Output.noconsole_x
		Output.y		 = Output.noconsole_y
		Output.fade_time ++
		Output.alpha	 = max(force_output, Output.alpha - Output.alpha_dec*(Output.fade_time >= Output.time))
	}

	var x2 = Output.x+string_width (Output.plaintext)+Output.border_w
	var y2 = Output.y-string_height(Output.plaintext)-Output.border_h

	draw_set_color(colors.ex_output)
	
	Output.mouse_over = gui_mouse_between(Output.x-Output.border_w, Output.y+Output.border_h, x2, y2)
	if Output.mouse_over or force_output_body or (Output.text_embedding and force_output_embed_body)
	{
		gpu_set_blendmode(colors.body_bm)
		draw_set_color(colors.body)
		draw_rectangle(Output.x-Output.border_w, Output.y+Output.border_h, x2, y2, false)
		gpu_set_blendmode(bm_normal)
		
		if not console_toggle and Output.mouse_over
		{
			Output.alpha = 1
			Output.fade_time  = 0
		}
		draw_set_color(colors.output)
	}

	draw_set_alpha(Output.alpha)
	
	if embed_text
	{
		Output.mouse_over_embed = draw_embedded_text(Output.x, Output.y-string_height(Output.plaintext)+1, Output.text, Output.plaintext)
	}
	else
	{
		draw_text(Output.x, Output.y-string_height(Output.plaintext)+1, Output.plaintext)
		Output.mouse_over_embed = false
	}
	
	draw_set_alpha(1)
	draw_set_color(c_white)
}
else Output.mouse_over = false

if console_toggle
{
	//Draw console
	draw_set_color(colors.body)
	gpu_set_blendmode(colors.body_bm)
	draw_rectangle(console_left, console_bottom, console_right, console_top, false)
	gpu_set_blendmode(bm_normal)
	draw_set_color(colors.plain)

	draw_set_alpha(1)
	draw_line_width(console_left, console_bottom, console_left, console_top, 2)

	draw_set_font(font)
	draw_set_halign(fa_left)
	draw_set_valign(fa_center)
	if console_colors draw_console_text(console_text_x, console_text_y, color_string)
	else draw_text(console_text_x, console_text_y, console_string)
	
	draw_set_color(colors.plain)
	draw_rectangle(
		console_text_x + char_width*(char_pos1-(char_pos1-char_pos2)), console_text_y + char_height/2,
		console_text_x + char_width*(char_pos1-1), console_text_y - char_height/2,
		false
	)
	if string_length(console_string) > char_pos1-1
	{
		draw_set_color(colors.selection)
		draw_set_halign(fa_left)
		draw_set_valign(fa_bottom)
		draw_text(
			console_text_x + char_width*(char_pos1-1), console_text_y + char_height/2, 
			string_copy(console_string, char_pos1, char_pos2-char_pos1+1)
		)
	}

	draw_set_color(colors.output)
	draw_set_halign(fa_right)
	draw_set_valign(fa_center)
	var object_text
	
	if instance_exists(object) 
	{
		object_text = object_get_name(object.object_index)
		mouse_over_object = gui_mouse_between(console_object_x+3, console_text_y-string_height(object_text)/2-3, console_object_x-string_width(object_text)-3, console_text_y+string_height(object_text)/2+3)
		if mouse_over_object
		{
			draw_instance_cursor(x_to_gui(object.x), y_to_gui(object.y), object_get_name(object.object_index))
			draw_set_color(colors.output)
			draw_set_halign(fa_right)
			draw_set_valign(fa_center)
		}
	}
	else object_text = "Noone"
	
	draw_text(console_object_x, console_text_y, object_text)
		
	draw_set_color(c_white)
	
	if not Output.mouse_over Output.alpha = 0
}

#region Draw display
if Display.enabled and ds_list_size(display_list) > 0
{
	if Display.show
	{
		draw_set_font(font)
		ds_list_clear(display_string)
		var temp_plaintext = undefined
	
		for(var i = 0; i <= ds_list_size(display_list)-1; i++)
		{
			var obj = string_split(".", display_list[| i].variable)[0]
			var variable = string_copy(display_list[| i].variable, string_pos(".", display_list[| i].variable)+1, string_length(display_list[| i].variable))
			var value = string_replace( string( variable_string_get(display_list[| i].variable) ), "\n", "\\n" )
		
			if window_embed_text and embed_text
			{
				if display_show_objects 
				{
					ds_list_add( display_string, {str: obj, func: function() {o_console.object = asset_get_index(obj)} } )
					variable = "."+variable
				}
				ds_list_add( display_string, {str: variable, scr: input_set, args: [variable, true]}, " "+value+"\n" )
			}
			else
			{
				if display_show_objects
				{
					ds_list_add(display_string, obj)
					variable = "."+variable
				}
				ds_list_add(display_string, variable+" "+value+"\n")
			}
		}
	
		var embed_string = ds_list_to_array(display_string)
		if not window_embed_text and not embed_text temp_plaintext = embed_string
	
		Display.set(embed_string, temp_plaintext)
	}
	draw_console_window(Display)
}
#endregion

#region Draw window
if Window.enabled and Window.plaintext != ""
{
	draw_console_window(Window)
}

if output_as_window and Output.plaintext != ""
{
	Output.alpha = 1
	Output.fade_time  = 0
	draw_console_window(Output_window)
}
#endregion