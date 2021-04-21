
function color_console_string47(command){ with o_console {

static space_sep = " ,()=:;/"

try
{
if shave(" ", command) == "" return {text: "", colors: []}

var color_list = []
var marker = 0
var in_string = false
var _iden = -1
var instscope = ""
var _col = "plain"

for(var i = 1; i <= string_length(command)+1; i++)
{
	var char = string_char_at(command, i)
	var string_sep = false
	var string_offset = 0
	var string_onset  = 0
	
	if char == "\\" and in_string and i != string_length(command)
	{
		i++
	}
	else
	{
		
		if char == "\""
		{
			in_string = not in_string
			string_sep = true
			string_offset = in_string
			string_onset  = not in_string
		}
		
		if string_sep or (not in_string and (string_pos(char, space_sep))) or i == string_length(command)+1
		{	
			if marker != i
			{
				var segment = string_copy(command, marker+1, i-marker-1+string_onset)
				//var segment = string_copy(command, marker+1-string_offset, i-marker-1+string_onset-string_offset)
				
				var _col = "plain"
				
				if char == "/" and not is_undefined(identifiers[$ segment])
				{
					_col = identifiers[$ segment]
					_iden = identifiers[$ segment]
				}
				else
				{
					var _macro = console_macros[$ segment]
				
					if not is_undefined(_macro)
					{
						segment = _macro.value
						if _macro.type != -1 _col = _macro.type
					}

					var asset_segment = segment
					if string_pos(".", segment) != 0 asset_segment = string_copy(segment, 1, string_pos(".", segment)-1)
				
					var asset_index = asset_get_index(asset_segment)
				
					if _col == "plain" and string_char_at(segment, 1) == "\"" and (i == string_length(command)+1 or string_pop(segment) == "\"") _col = dt_string
					else if _col == "plain" and asset_index != -1
					{
						var asset_type = asset_get_type(asset_segment)
					
						switch asset_type
						{
						case asset_object: _col = dt_instance; break
						case asset_script: _col = dt_method
						}
					
						if _col == "plain" and asset_get_index(segment) != -1 _col = dt_asset
					
						if _col == dt_instance and segment != asset_segment and not string_sep i -= string_length(segment) - string_pos(".", segment)+1
					}
					else if _col == "plain" and string_is_float(segment) _col = dt_real
				
					if _col == "plain" or segment == global
					{
						var varstring
					
						if instscope != "" varstring = instscope + "." + segment
						else			   varstring = string_add_scope(segment, true)
					
						if not is_undefined(varstring) and variable_string_exists(varstring)
						{
							if is_method(variable_string_get(varstring))
							{
								_col = dt_method
							}
							else
							{
								_col = dt_variable
							}
						}
					}
				}
				
				if marker != 0
				{
					array_push(color_list, {pos: marker+1 - (instscope != ""), col: "plain"})
				}
				
				instscope = ""
				
				if string_char_at(command, i) == "." and _col == dt_instance instscope = asset_segment
				
				array_push(color_list, {pos: i+(_iden != -1)+string_onset, col: _col})
			}		
			marker = i-string_offset
			
			_iden = -1
		}
	}
}
console_color_time = 0

return {text: command, colors: color_list}
}
catch(_exception)
{
	_=_exception //to clear the "syntax error!"
	return {text: command, colors: [{pos: string_length(command)+1, col: "plain"}]}
}
}}