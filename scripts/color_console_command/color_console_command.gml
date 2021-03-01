
function color_console_command(command){ with o_console {

static space_sep = " ,()=;"

if shave(" ", command) == "" return {text: "", colors: []}

var color_list = []
var marker = 0
var in_string = false

for(var i = 1; i <= string_length(command)+1; i++)
{
	var char = string_char_at(command, i)
	
	if char == "\\" and in_string
	{
		i++
	}
	else
	{
		if char == "\""
		{
			in_string = not in_string
		}
		else if (not in_string and string_pos(char, space_sep)) or i == string_length(command)+1
		{	
			if marker != i
			{
				var segment = string_copy(command, marker+1, i-marker-1)
				var _col = "plain"
				var asset_index = asset_get_index(segment)
				
				if string_char_at(segment, 1) == "\"" and (i == string_length(command)+1 or string_pop(segment) == "\"") _col = "string"
				else if asset_index != -1
				{
					var asset_type = asset_get_type(segment)
					
					switch asset_type
					{
					case asset_object: _col = "object"; break
					case asset_script: _col = "script"
					}
					
					if _col == "plain" _col = "asset"
				}
				else if string_is_float(segment) _col = "number"
				else
				{
					var varstring = string_add_scope(segment)
					
					if not is_undefined(varstring) and variable_string_exists(varstring)
					{
						if is_method(variable_string_get(varstring))
						{
							_col = "script"
						}
						else
						{
							_col = "variable"
						}
					}
				}
				
				//if array_length(color_list) > 0 and array_pop(color_list).col == _col color_list[array_length(color_list)-1].pos = i
				//else
				if string_pos(string_char_at(command, marker), space_sep) 
				{
					array_push(color_list, {pos: marker, col: "plain"})
				}
				
				array_push(color_list, {pos: i, col: _col})
			}
			marker = i
		}
	}
}
return {text: command, colors: color_list}
}}