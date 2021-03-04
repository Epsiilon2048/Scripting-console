
function color_console_string(command){ with o_console {

static space_sep = " ,()=:;"

if shave(" ", command) == "" return {text: "", colors: []}

var color_list = []
var marker = 0
var in_string = false
var instscope = ""
var _col = "plain"

for(var i = 1; i <= string_length(command)+1; i++)
{
	var char = string_char_at(command, i)
	
	if char == "\\" and in_string and i != string_length(command)
	{
		i++
	}
	else
	{
		if char == "\""
		{
			in_string = not in_string
		}
		else if (not in_string and (string_pos(char, space_sep))) or i == string_length(command)+1
		{	
			if marker != i
			{
				var segment = string_copy(command, marker+1, i-marker-1)
				
				var _col = "plain"
				
				var _macro = console_macros[$ segment]
				
				if not is_undefined(_macro)
				{
					segment = _macro.value
					if _macro.type != -1 _col = dt_string[_macro.type]
				}

				var asset_segment = segment
				if string_pos(".", segment) != 0 asset_segment = string_copy(segment, 1, string_pos(".", segment)-1)
				
				var asset_index = asset_get_index(asset_segment)
				
				if _col == "plain" and string_char_at(segment, 1) == "\"" and (i == string_length(command)+1 or string_pop(segment) == "\"") _col = "string"
				else if _col == "plain" and asset_index != -1
				{
					var asset_type = asset_get_type(asset_segment)
					
					switch asset_type
					{
					case asset_object: _col = "object"; break
					case asset_script: _col = "script"
					}
					
					if _col == "plain" _col = "asset"
					
					if _col == "object" and segment != asset_segment i -= string_length(segment) - string_pos(".", segment)+1
				}
				else if _col == "plain" and string_is_float(segment) _col = "number"
				else if _col == "plain"
				{
					var varstring
					
					if instscope != "" varstring = instscope + "." + segment
					else			   varstring = string_add_scope(segment)
					
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
				if marker != 0
				{
					array_push(color_list, {pos: marker+1 - (instscope != ""), col: "plain"})
				}
				
				instscope = ""
				
				if string_char_at(command, i) == "." and _col == "object" instscope = asset_segment
				
				array_push(color_list, {pos: i, col: _col})
			}		
			marker = i
		}
	}
}
console_color_time = 0

return {text: command, colors: color_list}
}}