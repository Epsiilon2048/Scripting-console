
var old_color  = draw_get_color()
var old_alpha  = draw_get_alpha()
var old_font   = draw_get_font()
var old_halign = draw_get_halign()
var old_valign = draw_get_valign()

draw_console_output()

if console_toggle
{
	if not is_undefined(object) and instance_exists(object) sidetext_string = object_get_name( object.object_index )
	else sidetext_string = "noone"
	
	draw_console_bar()
	
	if not Output.mouse_on Output.alpha = 0
}
#region Draw display
if Display.enabled and ds_list_size(display_list) > 0
{
	if Display.show and step mod display_update == 0
	{
		display_string = ""
	
		for(var i = 0; i <= ds_list_size(display_list)-1; i++)
		{
			var obj = string_copy(display_list[| i].variable, 1, string_pos(".", display_list[| i].variable)-1)
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
if Window.enabled and Window.plain != ""
{
	draw_console_window(Window)
}

if output_as_window and Output.plain != ""
{
	Output.alpha = 1
	Output.fade_time  = 0
	draw_console_window(Output_window)
}
#endregion

draw_autofill_list()
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