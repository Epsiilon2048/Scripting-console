
function input_set(str, add){ with o_console
{
	input_log_index = -1
	BAR.enabled = true
	
	if is_undefined(add) or not add 
	{
		ds_list_insert(input_log, 0, console_string)
		console_string = str
	}
	else
	{
		console_string = string_insert(str, console_string, char_pos1)
		char_pos1 += string_length(str)
		char_pos2 = char_pos1
	}

	keyboard_string = console_string
	color_string = gmcl_string_color(console_string, char_pos1)
	char_pos1 = string_length(console_string)+1
	char_pos2 = char_pos1
}}



function output_set(output){ with o_console.OUTPUT {

if is_struct(output) and variable_struct_exists(output, "__embedded__") output = output.o

if instanceof(output) == "element_container"
{
	o_console.O1 = output
	dock.set(output.elements)
}
else
{
	dock.association = dock
	o_console.O1 = output
		
	if is_array(output)
	{
		var text = "["
		for(var i = 0; i <= array_length(output)-1; i++)
		{
			if is_array(output[i]) text += "\n[array]"
			else if is_struct(output[i]) text += "{"+instanceof(output[i])+"}"
			else text += string(output[i])
		}
		text += "]"

		dock.set(text)
	}
	if is_struct(output)
	{
		var io = instanceof(output)
		
		if io == "Console_dock" or io == "element_container"
		{
			dock.set(output.elements)
		}
		else
		{
			var names = variable_struct_get_names(output)
			for(var i = 0; i <= array_length(names)-1; i++)
			{
				if is_array(output[$ names[i]]) names[i] = [names[i]+":", "[array]"]
				else if is_struct(output[$ names[i]]) names[i] = [names[i]+":","{"+instanceof(output[$ names[i]])+"}"]
				else names[i] = [names[i]+":", new_display_box(undefined, names[i], false)]
			}
			array_insert(names, 0, "{")
			array_push(names, "}")

			dock.association = output		
			dock.set(names)
		}
	}
	else
	{
		dock.set(string_format_float(output, 4))
	}
}

dock.enabled = not (is_undefined(output) or output == "" or output == [] or output == [""])
}}



function output_set_lines(output){
if is_array(output) output_set(output[0]) else output_set(output)
}