
var old_color  = draw_get_color()
var old_alpha  = draw_get_alpha()
var old_font   = draw_get_font()
var old_halign = draw_get_halign()
var old_valign = draw_get_valign()

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
		//Window.text = Output.text
		//output_set("")
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

if not output_as_window and ((Output.alpha > 0 or console_toggle) or force_output) and Output.text.plaintext != ""
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

	var x2 = Output.x+Output.text.width*char_width+Output.border_w
	var y2 = Output.y-Output.text.height*char_height-Output.border_h
	
	Output.mouse_over = gui_mouse_between(Output.x-Output.border_w, Output.y+Output.border_h, x2, y2)
	if Output.mouse_over or force_output_body or (Output.text_embedding and force_output_embed_body)
	{
		draw_console_body(Output.x-Output.border_w, y2, x2, Output.y+Output.border_h)
		
		if not console_toggle and Output.mouse_over
		{
			Output.alpha = 1
			Output.fade_time  = 0
		}
	}

	draw_set_alpha(Output.alpha)
	
	Output.mouse_over_embed = draw_embedded_text(Output.x, Output.y-Output.text.height*char_height, Output.text)
	
	draw_set_alpha(1)
}
else Output.mouse_over = false

if console_toggle
{
	//Draw console
	draw_console_body(console_left, console_top, console_right, console_bottom)

	draw_rectangle_color(
		console_left, console_bottom+1, console_left+prompt_bar_width, console_top-1, 
		colors.plain, colors.plain, colors.plain, colors.plain, false
	)

	draw_set_halign(fa_right)
	draw_set_valign(fa_center)
	var object_text
	
	if instance_exists(object) 
	{
		object_text = object_get_name(object.object_index)
		
		var object_text_width = string_width(object_text)
		
		mouse_over_object = gui_mouse_between(console_object_x+3, console_text_y-char_height/2-3, console_object_x-object_text_width-3, console_text_y+char_height/2+3)
		
		if mouse_over_object draw_instance_cursor(x_to_gui(object.x), y_to_gui(object.y), object_get_name(object.object_index))
	}
	else 
	{
		object_text = "Noone"
		var object_text_width = string_width(object_text)
	}
	
	draw_text_color(
		console_object_x, console_text_y, object_text,
		colors.output, colors.output, colors.output, colors.output, 1
	)

	clip_rect_cutout(console_left, console_top, console_right-object_text_width-console_object_border, console_bottom)
	
	draw_set_font(font)
	draw_set_align(fa_left, fa_center)
	if command_colors draw_console_text(console_text_x, console_text_y, color_string)
	else draw_text(console_text_x, console_text_y, console_string)
	
	draw_rectangle_color(
		console_text_x + char_width*(char_pos1-(char_pos1-char_pos2)), console_text_y + char_height/2,
		console_text_x + char_width*(char_pos1-1), console_text_y - char_height/2,
		colors.plain, colors.plain, colors.plain, colors.plain, false
	)
	if string_length(console_string) > char_pos1-1
	{
		draw_text_color(
			console_text_x + char_width*(char_pos1-1), 
			console_text_y, 
			string_copy(console_string, char_pos1, char_pos2-char_pos1+1),
			colors.selection, colors.selection, colors.selection, colors.selection, 1
		)
	}
	
	shader_reset()
	
	if not Output.mouse_over Output.alpha = 0
}

#region Draw display
if Display.enabled and ds_list_size(display_list) > 0
{
	if Display.show and step mod display_update == 0
	{
		display_string = ""
	
		for(var i = 0; i <= ds_list_size(display_list)-1; i++)
		{
			var obj = string_copy(display_list[| i].variable, 1, string_pos(".", display_list[| i].variable)-1)//string_split(".", display_list[| i].variable)[0]
			var variable = string_copy(display_list[| i].variable, string_pos(".", display_list[| i].variable)+1, string_length(display_list[| i].variable))
			
			var value = variable_string_get(display_list[| i].variable)
			
			if is_string(value) value = "\""+value+"\""
			
			value = string_replace_all( string(value), "\n", "\\n" )

			if display_show_objects
			{
				if instance_number(obj.object_index) > 1 display_string += string(obj)+" "
				
				display_string += object_get_name(obj.object_index)
				
				variable = "."+variable
			}
			display_string += variable+" "+value+"\n"
		}
		
		display_string = shave("\n", display_string)
		
		Display.set(display_string, display_string)
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

draw_value_boxes()
draw_color_picker()
draw_ctx_menu()

value_box_dragging = false

event_commands_exec(event_commands.gui)

draw_set_color(old_color)
draw_set_alpha(old_alpha)
draw_set_font(old_font)
draw_set_halign(old_halign)
draw_set_valign(old_valign)