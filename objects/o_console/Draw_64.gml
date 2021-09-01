
draw_console_output()

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

draw_autofill_list()
draw_color_picker()

for(var i = ds_list_size(elements)-1; i >= 0; i--)
{
	elements[| i].draw()
}

event_commands_exec(event_commands.gui)