
function input_set(str, add){ with o_console
{
	input_log_index = -1
	console_toggle = true
	
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




function output_set(output){ with o_console.Output {

var _output = output

var _text

if is_undefined(_output) or _output == "" or _output == [] or _output == {}
{
	_text = []
}
else
{	
	tag_set(variable_struct_exists_get(_output, "__tag__", -1))
	
	if variable_struct_exists_get(_output, "__embedded__", false)
	{
		text_embedding = true
		_text = _output.o

		if not is_array(_text) _text = [_text]
	}
	else
	{
		text_embedding = false
		_text = ""
		
		_output = variable_struct_exists_get(_output, "o", _output)
			
		if is_struct(_output) 
		{
			var structnames = variable_struct_get_names(_output)
				
			for(var i = 0; i <= array_length(structnames)-1; i++)
			{
				_text += "\n"+structnames[i]+": "+string(variable_struct_get(_output, structnames[i]))
			}
		}
		else _text = string(_output)
		
		if is_array(_output) _text = _text + array_to_string(_output, "\n")

		_text = [_text]
	}
		
	alpha		= 1
	fade_time	= 0
		
	o_console.Output_window.set(_text)
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




function output_set_lines(output){ with o_console.Output {

var _output = output
	
var _text
	
if is_undefined(_output) or _output == "" or _output == [] or _output == {}
{
	_text = []
	plaintext = ""
	text_embedding = false
}
else
{	
	if not is_array(_output) _output = [_output]
	
	if array_length(_output) > 0
	{
		tag_set(variable_struct_exists_get(_output[0], "__tag__", -1))
	}
	
	text_embedding = false
		
	for(var i = 0; i <= array_length(_output)-1; i++)
	{
		if variable_struct_exists_get(_output[i], "__embedded__", false)
		{
			text_embedding = true
			break
		}
	}
	
	if text_embedding
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
				_output[i] = variable_struct_exists_get(_output[i], "o", _output[i])
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
				
				for(var i = 0; i <= array_length(structnames)-1; i++)
				{
					_text += "\n"+structnames[i]+": "+string(variable_struct_get(_output, structnames[i]))
				}
			}
			else if not is_array(_output) _text = string(_output)
		}
		else
		{
			for(var i = 0; i <= array_length(_output)-1; i++)
			{
				_output[i] = variable_struct_exists_get(_output[i], "o", _output[i])
			}
		}
		
		if is_array(_output) _text = _text + array_to_string(_output, "\n")
		
		_text = [_text]
	}
		
	alpha		= 1
	fade_time	= 0
		
	o_console.Output_window.set(_text)
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