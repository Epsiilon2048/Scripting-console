
function input_set(str, add){ with o_console.BAR {
	input_log_index = -1
	enabled = true
	
	if is_undefined(add) or not add 
	{
		//ds_list_insert(input_log, 0, console_string)
		console_string = str
	}
	else
	{
		console_string = string_insert(str, console_string, text_box.char_pos1)
		text_box.char_pos1 += string_length(str)
		text_box.char_pos2 = text_box.char_pos1
	}

	keyboard_string = console_string
	colors = text_box.color_method(console_string, text_box.char_pos1)
	text_box.char_pos1 = string_length(console_string)+1
	text_box.char_pos2 = text_box.char_pos1
	
	text_box.update_variable()
}}




function output_set(output){ with o_console.OUTPUT {

if is_struct(output) and variable_struct_exists(output, "__embedded__") output = output.o

dock.enabled = not is_undefined(output)


if is_string(output)
{
	dock.set(output)
	move_to_front(self)
	exit
}


if is_bool(output)
{
	dock.set(output ? "true" : "false")
	move_to_front(self)
	exit
}


if real(output)
{
	dock.set(string_format_float(output, 3))
	move_to_front(self)
	exit
}


if is_ptr(output)
{
	dock.set("pointer")
	move_to_front(self)
	exit
}


if not is_struct(output) and not is_array(output)
{
	dock.set(string(output))
	exit
}


var str = ""
var sep = ",\n"

if is_struct(output)
{
	var io = instanceof(output)
	
	if io == "Console_dock"
	{
		if not variable_struct_exists(output, "name")
		{
			add_console_element(output)
		}
		exit
	}
	
	if io == "element_container" or variable_struct_exists_get(output, "is_console_element", false)
	{
		dock.set(output)
		move_to_front(self)
		exit
	}
	
	if variable_struct_names_count(output) == 0
	{
		dock.set("Empty struct")
		move_to_front(self)
		exit
	}
	
	var list = variable_struct_get_names(output)
	var str = "{\n"
	var after = "}"
}


if is_array(output)
{
	if array_length(output) == 0
	{
		dock.set("Empty array")
		move_to_front(self)
		exit
	}
	
	var list = output
	var str = "[\n"
	var after = "]"
}


static max_items = 20

for(var i = 0; i <= min(max_items, array_length(list)-1); i++)
{	
	var item = list[i]
	var value
		
	if is_struct(output)
	{
		value = output[$ list[@ i]]
		str += item+": "
	}
	else value = list[i]
		
	if is_string(value)
	{
		if string_length(value) < 300 and not string_pos("\n", value)
		{
			str = "\""+value+"\""
		}
		else
		{
			str = "string"
		}
		str += sep
		continue
	}
		
	if is_bool(value)
	{
		str += (value ? "true" : "false")+sep
		continue
	}
		
	if is_numeric(value)
	{
		str += string_format_float(value, 3)+sep
		continue
	}
		
	if is_struct(value)
	{
		str += instanceof(value)+sep
		continue
	}
		
	if is_array(value)
	{
		var len = array_length(value)
		str += "array with "+string(len)+" item"+((len == 1) ? "" : "s")+sep
		continue
	}
		
	if is_ptr(value)
	{
		str += "pointer"+sep
		continue	
	}
		
	if is_method(value)
	{
		str += "method"+sep
		continue
	}
		
	str += string(value)+sep
}


if i >= max_items
{
	str += "(...)"
	dock.set(str)
	exit
}


str += after
dock.set(str)

/*
if is_struct(output) and variable_struct_exists(output, "__embedded__") output = output.o

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
		
	if io == "Console_dock"
	{
		add_console_element(output)
	}
	else if io == "element_container" or variable_struct_exists_get(output, "is_console_element", false)
	{
		dock.set(output)
	}
	else
	{
		var names = variable_struct_get_names(output)
		
		if array_length(names) == 0
		{
			names = "{}"
		}
		else for(var i = 0; i <= array_length(names)-1; i++)
		{
			if is_array(output[$ names[i]]) names[i] = [names[i]+":", "[array]"]
			else if is_struct(output[$ names[i]]) names[i] = [names[i]+":","{"+instanceof(output[$ names[i]])+"}"]
			else names[i] = [names[i]+":", new_display_box(undefined, names[i], false)]
		}
		
		if array_length(names) == 1
		{
			names = [["{",names[0],"}"]]
		}
		
		array_insert(names, 0, "{")
		array_push(names, "}")

		dock.association = output		
		dock.set(names)
	}
}
else 
{
	if is_string(output) and not string_pos("\n", output) dock.set(quotes_if_string(output))
	else if is_numeric(output) dock.set(string_format_float(output, float_count_places(output, 4)))
	else dock.set(string(output))
}

dock.enabled = not is_undefined(output)
if dock.enabled move_to_front(self)
*/
}}


function output_set_lines(output){
if is_array(output) output_set(output[0]) else output_set(output)
}