
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

if instanceof(output) == "element_container"
{
	O1 = output
	dock.set(output.elements)
}
else
{
	dock.association = dock
	O1 = output
	
	if is_array(output)
	{
		var text = "["
		for(var i = 0; i <= min(array_length(output)-1, 10); i++)
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
		var names = variable_struct_get_names(output)
		for(var i = 0; i <= min(array_length(names)-1, 10); i++)
		{
			if is_array(names[i]) names[i] = [names[i]+":", "[array]"]
			else if is_struct(names[i]) names[i] = [names[i]+":","{"+instanceof(names[i])+"}"]
			else names[i] = [names[i]+":", new_cd_var(names[i])]
		}
		show_message(array_length(names))
		array_insert(names, 0, "{")
		array_push(names, "}")

		dock.association = output
		dock.set(names)
	}
	else
	{
		dock.set(string_format_float(output, 4))
	}
}
}}



function output_set_lines(output){
if is_array(output) output_set(output[0]) else output_set(output)
}




function output_set_old(output){ with o_console.OUTPUT {

var _output = output

var _text

if is_undefined(_output) or _output == "" or _output == [] or _output == {}
{
	_text = []
}
else
{	
	if variable_struct_exists_get(_output, "__embedded__", false)
	{
		has_embed = true
		_text = _output.o

		if not is_array(_text) _text = [_text]
	}
	else
	{
		has_embed = false
		_text = ""
		
		if is_struct(_output) and variable_struct_exists(_output, "__embedded__") _output = _output.o
			
		if is_struct(_output) 
		{
			var structnames = variable_struct_get_names(_output)
			
			_text += "{"
			
			for(var i = 0; i <= array_length(structnames)-1; i++)
			{
				_text += "\n"+structnames[i]+": "+string(variable_struct_get(_output, structnames[i]))
			}
			
			_text += "\n}"
		}		
		else if is_array(_output) _text = _text + "[\n"+array_to_string(_output, "\n")+"\n]"
		else _text = string(_output)

		_text = [_text]
	}
		
	alpha		= 1
	fade_time	= 0
}
text.set(_text)
with o_console
{
	prev_output = _output
	O1 = output
	O2 = ""
	O3 = ""
	O4 = ""
	O5 = ""
}
return _output
}}




function output_set_lines_old(output){ with o_console.OUTPUT {

var _output = output
	
var _text
	
if is_undefined(_output) or _output == "" or _output == [] or _output == {}
{
	_text = []
	has_embed = false
}
else
{	
	if not is_array(_output) _output = [_output]
	
	has_embed = false
		
	for(var i = 0; i <= array_length(_output)-1; i++)
	{
		if variable_struct_exists_get(_output[i], "__embedded__", false)
		{
			has_embed = true
			break
		}
	}
	
	if has_embed
	{
		_text = []
		
		for(var i = 0; i <= array_length(_output)-1; i++)
		{
			if variable_struct_exists_get(_output[i], "__embedded__", false)
			{
				array_copy(_text, array_length(_text), _output[i].o, 0, array_length(_output[i].o))
				if i != array_length(_output)-1 array_push(_text, "\n")
			}
			else
			{
				if is_struct(output[i]) and variable_struct_exists(output[i], "__embedded__") _output[i] = _output[i].o

				array_push(_text, string(_output[i])+"\n")
			}
		}
	}
	else
	{
		_text = ""
		
		if array_length(_output) == 1
		{
			_output = variable_struct_exists_get(_output[0], "o", _output[0])
			
			if is_struct(_output)
			{
				var structnames = variable_struct_get_names(_output)
				
				_text += "{"
				
				for(var i = 0; i <= array_length(structnames)-1; i++)
				{
					_text += "\n"+structnames[i]+": "+string(variable_struct_get(_output, structnames[i]))
				}
				
				_text += "\n}"
			}
			else if not is_array(_output) _text = string(_output)
		}
		else
		{
			for(var i = 0; i <= array_length(_output)-1; i++)
			{
				if is_struct(_output[i]) and variable_struct_exists(_output[i], "__embedded__") _output[i] = _output[i].o
			}
		}
		
		if is_array(_output) _text = _text + "[\n"+array_to_string(_output, "\n")+"\n]"
		
		_text = [_text]
	}
		
	alpha		= 1
	fade_time	= 0
}
text.set(_text)
with o_console 
{
	prev_output = output
	var arlen = array_length(prev_output)
	O1 = (arlen > 0) ? prev_output[0] : ""
	O2 = (arlen > 1) ? prev_output[1] : ""
	O3 = (arlen > 2) ? prev_output[2] : ""
	O4 = (arlen > 3) ? prev_output[3] : ""
	O5 = (arlen > 4) ? prev_output[4] : ""
}
return _output

}}