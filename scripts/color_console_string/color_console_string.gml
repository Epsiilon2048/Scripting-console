
function color_console_string(command){ with o_console {

static space_sep = " ,.()=:;/"

try
{
if shave(" ", command) == "" return {text: "", colors: []}

var color_list = []
var _char = ""
var char  = ""
var marker = 0
var in_string = false
var _iden = -1
var _prev_iden = -1
var _iden_string = false
var instscope = ""
var _col = dt_unknown

for(var i = 1; i <= string_length(command)+1; i++)
{	
	_char = char
	char = string_char_at(command, i)
	
	if string_pos(char, space_sep) and string_pos(_char, space_sep) continue
	
	var string_sep = false
	var string_offset = 0
	var string_onset  = 0 //lolidk
	
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
				var is_int = string_is_int(segment)
				
				if char == "." and is_int and (string_is_int( string_char_at(command, i+1) ) or string_char_at(command, i+1) == "")
				{
					continue
				}
				
				var _col = dt_unknown
				
				if char == "/" and not is_undefined(identifiers[$ segment])
				{
					_col  = identifiers[$ segment]
					_iden = identifiers[$ segment]
					
					if _iden == dt_string
					{
						_iden_string = true
					}
					else
					{
						_prev_iden = _iden
					}
				}
				else
				{	
					if string_pos("\"", segment) == 1 and string_pop(segment) == "\""
					{
						_col = dt_string
					}
					else if instscope == ""
					{	
						//yandere dev pls hire me
						
						var _macro_type = -1
					
						if _iden_string _col = dt_string
					
						if _prev_iden == -1
						{
							var _macro = console_macros[$ segment]
				
							if not is_undefined(_macro)
							{
								segment = _macro.value
								if _macro.type != -1 _col = _macro.type
								_macro_type = _col
							}
						}
						
						var _asset 
						var _asset_type
						
						if is_int
						{
							_asset = real(segment)
							_asset_type = -1
						}
						else
						{
							_asset = asset_get_index(segment)
							_asset_type = asset_get_type(segment) 
						}
						
						if _prev_iden == dt_instance and _asset > -1 and instance_exists(_asset) and (_macro_type == -1 or _macro_type == dt_instance)
						{
							_col = dt_instance
							instscope = segment
						}
						else if _prev_iden == dt_instance and object_exists(_asset) and (is_int or _asset_type == asset_object) and (_macro_type == -1 or _macro_type == dt_instance)
						{
							_col = dt_asset
						}
						else if _prev_iden == dt_method and script_exists(_asset) and (is_int or _asset_type == asset_script) and (_macro_type == -1 or _macro_type == dt_method)
						{
							_col = dt_method
						}
						else if _prev_iden == dt_room and room_exists(_asset) and (is_int or _asset_type == asset_room) and (_macro_type == -1 or _macro_type == dt_room)
						{
							_col = dt_room
						}
						else if _prev_iden == dt_asset and _asset > -1 and (_macro_type == -1 or _macro_type == dt_asset)
						{
							_col = dt_asset
						}
						else if _prev_iden == -1 and _asset_type != -1
						{
							if _asset_type == asset_object	
							{
								_col = dt_instance
								instscope = segment
							}
							else if _asset_type == asset_script 
							{
								_col = dt_method
							}
							else 
							{
								_col = dt_asset
							}
						}
						else if _prev_iden == dt_real or (_prev_iden == -1 and string_is_float(segment) and (_macro_type == -1 or _macro_type == dt_real))
						{
							if string_is_float(segment)
							{
								_col = dt_real
								instscope = segment
							}
						}
						else if _macro_type == -1 or _macro_type == dt_variable
						{
							var _varstring = string_add_scope(segment, _prev_iden == -1) 
							
							if variable_string_exists(_varstring)
							{
								if is_method(variable_string_get(_varstring))
								{
									_col = dt_method
								}
								else
								{
									_col = dt_variable
								}
								instscope = _varstring
							}
						}
					}
					else
					{
						instscope += "."+segment
						show_debug_message(instscope)
						
						var _varstring = string_add_scope(instscope, _prev_iden == -1)
						
						if variable_string_exists(_varstring)
						{
							_col = dt_variable
						}
						else instscope = ""
					}
					
					if char != "." 
					{
						_iden_string = false
						_prev_iden = -1
					}
				}
				
				if marker != 0
				{
					array_push(color_list, {pos: marker+1, col: _iden_string ? dt_string : dt_unknown})
				}
				
				if char != "."
				{
					instscope = ""
				}
				
				array_push(color_list, {pos: i+(_iden != -1)+string_onset, col: _col})
			}
			
			if array_length(color_list) > 1 and color_list[array_length(color_list)-2].col == _col
			{
				array_delete(color_list, array_length(color_list)-2, 1)
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
	return {text: command, colors: [{pos: string_length(command)+1, col: "plain"}]}
}
}}