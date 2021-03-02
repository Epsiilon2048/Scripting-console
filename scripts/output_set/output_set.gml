
function output_set(output){ with(o_console.Output) {

var _output = output
	
if is_undefined(_output) or _output == "" or _output == [] or _output == {}
{
	text = []
	plaintext = ""
	text_embedding = false
}
else
{	
	if array_length(_output) > 0
	{
		if tag != -1 tag_prev = tag
		tag = variable_struct_exists_get(_output, "__tag__", -1)
	}
	
	if variable_struct_exists_get(_output, "__embedded__", false)
	{
		text_embedding = true
		
		text = _output.o

		if not is_array(text) text = [text]

		array_push(text, "\n")
		
		plaintext = embedded_text_get_plain(text)
	}
	else
	{
		text_embedding = false
		text = ""
		
		_output = variable_struct_exists_get(_output, "o", _output)
		
		if is_array(_output) text = "Array with "+string(array_length(_output))+" items\n"
			
		else if is_struct(_output) 
		{
			text = "Struct with "+string(variable_struct_names_count(_output))+" variables"
				
			var structnames = variable_struct_get_names(_output)
				
			for(var i = 0; i <= array_length(structnames)-1; i++)
			{
				text += "\n"+structnames[i]+": "+string(variable_struct_get(_output, structnames[i]))
			}
		}
		else text = string(_output)
		
		if is_array(_output) text = text + array_to_string(_output, "\n")
		
		plaintext = text
		text = [shave("\n", text)]
	}
		
	alpha		= 1
	fade_time	= 0
		
	o_console.Output_window.set(text)
}
return _output
}}




function output_set_lines(output){ with(o_console.Output) {

var _output = output
	
if is_undefined(_output) or _output == "" or _output == [] or _output == {}
{
	text = []
	plaintext = ""
	text_embedding = false
}
else
{	
	if not is_array(_output) _output = [_output]
	
	if array_length(_output) > 0
	{
		if tag != -1 tag_prev = tag
		tag = variable_struct_exists_get(_output[0], "__tag__", -1)
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
		text = []
		
		for(var i = 0; i <= array_length(_output)-1; i++)
		{
			if variable_struct_exists_get(_output[i], "__embedded__", false)
			{
				array_copy(text, array_length(text), _output[i].o, 0, array_length(_output[i].o))
				array_push(text, "\n")
			}
			else
			{
				_output[i] = variable_struct_exists_get(_output[i], "o", _output[i])
				array_push(text, string(_output[i])+"\n")
			}
		}
		
		plaintext = embedded_text_get_plain(text)
	}
	else
	{
		text = ""
		
		if array_length(_output) == 1
		{
			_output = variable_struct_exists_get(_output[0], "o", _output[0])
			
			if is_array(_output) text = "Array with "+string(array_length(_output))+" items\n"
			
			else if is_struct(_output) 
			{
				text = "Struct with "+string(variable_struct_names_count(_output))+" variables"
				
				var structnames = variable_struct_get_names(_output)
				
				for(var i = 0; i <= array_length(structnames)-1; i++)
				{
					text += "\n"+structnames[i]+": "+string(variable_struct_get(_output, structnames[i]))
				}
			}
			else text = string(_output)
		}
		else
		{
			for(var i = 0; i <= array_length(_output)-1; i++)
			{
				_output[i] = variable_struct_exists_get(_output[i], "o", _output[i])
			}
		}
		
		if is_array(_output) text = text + array_to_string(_output, "\n")
		
		plaintext = text
		text = [shave("\n", text)]
	}
		
	alpha		= 1
	fade_time	= 0
		
	o_console.Output_window.set(text)
}
return _output

}}