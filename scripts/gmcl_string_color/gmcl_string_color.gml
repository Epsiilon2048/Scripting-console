
function gmcl_string_color(command, char_pos){ with o_console {

static max_length = 700
static space_sep = " ./;,=()[]:"
static iden_sep	 = " ;,=()"
static subj_sep	 = " ,=():"
static tag_sep   = " "
static accessors = "@|?#$"

				
static push_combine = function(list, pos, col, hl, ol){
	
	if pos <= 0 return undefined
	
	var list_len = array_length(list)
					
	if list_len > 0 and list[list_len-1].col == col and list[list_len-1].hl == hl and list[list_len-1].ol == ol
	{
		list[list_len-1].pos = pos
	}
	else if not (list_len > 0 and list[list_len-1].pos == pos)
	{
		array_push(list, {pos: pos, col: col, hl: hl, ol: ol})
	}
}

static get_possible_accessors = function(value){
	
	var possible_accessors = ""
	
	if is_struct(value) possible_accessors = "$"
	else if is_array(value) possible_accessors = "@"
	else if is_numeric(value) 
	{
		if ds_exists(value, ds_type_list)	possible_accessors += "|"
		if ds_exists(value, ds_type_map)	possible_accessors += "?"
		if ds_exists(value, ds_type_grid)	possible_accessors += "#"
	}

	return possible_accessors
}

try
{
var _command

if string_length(command) > max_length _command = string_copy(command, 1, max_length)
else if shave(" ", command) == "" return {text: "", colors: []}
else _command = command

if not command_colors return {text: _command, colors: [{pos: string_length(_command)+1, col: "plain"}]}

var color_list = []
var marker = 0
var _char_pos = is_undefined(char_pos) ? string_length(command) : char_pos
var subject_interpret = ""
var in_string = false
var _iden = -1
var _prev_iden = -1
var _iden_string = false
var _iden_name = ""
var instscope = ""
var _col = dt_unknown
var _ul = undefined
var _ol = 0
var in_brackets = 0
var accessor = ""
var can_have_accessor = false
var possible_accessors = ""

var tag = ""
var tag_pos = 0
var com_start = 1

for(var i = 1; i <= max(string_pos("#", _command), string_pos("\\", _command)); i++)
{
	var char = string_char_at(_command, i)
	
	if char == "#"
	{
		tag_pos = i
		
		i ++
		do
		{
			char = string_char_at(_command, i)
			tag += char
			i ++
		}
		until i > string_length(_command)+1 or (string_lettersdigits(char) != char and char != "_")

		if not (i > string_length(_command)+1) tag = string_delete(tag, string_length(tag), 1)
		
		if is_undefined(event_commands[$ tag])
		{
			tag = ""
		}
		else 
		{
			com_start = i
			push_combine(color_list, tag_pos, dt_unknown)
			push_combine(color_list, i, dt_tag)
		}
	}
	else if not string_pos(char, tag_sep)
	{
		if char == "\\"
		{
			push_combine(color_list, i, dt_unknown)
			push_combine(color_list, i+1, dt_tag)
			com_start = i+1
		}
		break
	}
}

var prev_char = ""
var subject = true

marker = com_start-1
for(var i = com_start; i <= string_length(_command)+1; i++)
{	
	var char = string_char_at(_command, i)
	var string_sep = false
	var string_offset = 0
	var string_onset  = 0 //lolidk
	
	if char == "\\" and in_string and i != string_length(_command)
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
		else if not in_string and (can_have_accessor or char != "[")
		{
			if can_have_accessor and string_pos(char, accessors)
			{
				marker = i
				push_combine(color_list, i, dt_unknown)
				push_combine(color_list, i+1, string_pos(char, possible_accessors) ? dt_instance : dt_deprecated)
				
				accessor = char
				possible_accessors = ""
				can_have_accessor = false
			}
			else if not (in_brackets and char == " ")
			{
				possible_accessors = ""
				can_have_accessor = false
			}
		}
		
		if string_sep or (not in_string and (string_pos(char, space_sep))) or i == string_length(_command)+1
		{	
			if marker == i continue
			
			var segment = string_copy(_command, marker+1, i-marker-1+string_onset)
			var plain_segment = segment
			var is_int = string_is_int(segment)
				
			if char == "." and _prev_iden != dt_variable and (is_int or segment == "") and (string_is_int( string_char_at(_command, i+1) ) or string_pos( string_char_at(_command, i+1), space_sep ) or string_char_at(_command, i+1) == "")
			{
				continue
			}
				
			var _col = dt_unknown
			var _hl = undefined
			var _ol = 0
				
			if char == "/" and not is_undefined(identifiers[$ segment])
			{
				_col  = identifiers[$ segment]
				_iden = identifiers[$ segment]
				_iden_name = segment+"/"
			}
			else 
			{	
				if _iden_string _col = dt_string
					
				if string_pos("\"", segment) == 1 and not (in_brackets and (accessor == "@" or accessor == "#" or accessor == "|"))
				{
					_col = dt_string
				}
				else if instscope == ""
				{	
					//yandere dev pls hire me
						
					var _macro_type = -1
					
					if _prev_iden == -1
					{
						var _macro = console_macros[$ segment]
				
						if not is_undefined(_macro)
						{
							plain_segment = segment
							segment = string(_macro.value)
							if _macro.type != -1 _col = _macro.type
							_macro_type = _col
								
							if _col == dt_variable _col = dt_builtinvar
								
							is_int = string_is_int(segment)
						}
					}
						
					var _asset 
					var _asset_type
						
					if is_int
					{
						_asset = real(segment)
						_asset_type = -1
					}
					else if segment == string(global)
					{
						_asset = global
						_asset_type = asset_object
					}
					else
					{	
						_asset = asset_get_index(segment)
						_asset_type = asset_get_type(segment) 
					}
						
					if _prev_iden == dt_color
					{
						if	string_is_float(segment) or 
							string_is_float("0x"+segment) or
							_macro_type == dt_color
						{
							_col = dt_color
						}
					}
					else if (_prev_iden == dt_instance or (_prev_iden == dt_variable and _asset_type == asset_object)) and _asset != -1 and instance_exists(_asset) and  (_macro_type == -1 or _macro_type == dt_instance)
					{
						_col = dt_instance
						instscope = segment
					}
					else if _prev_iden == dt_method and script_exists(_asset) and (is_int or _asset_type == asset_script) and (_macro_type == -1 or _macro_type == dt_method)
					{
						_col = dt_method
					}
					else if _prev_iden == dt_room and room_exists(_asset) and (is_int or _asset_type == asset_room) and (_macro_type == -1 or _macro_type == dt_room)
					{
						_col = dt_room
					}
					else if _prev_iden == dt_asset and _asset != -1 and (_macro_type == -1 or _macro_type == dt_asset) and (not is_int or object_exists(_asset))
					{
						_col = dt_asset
					}
					else if _prev_iden == -1 and _asset_type != -1
					{
						if _asset_type == asset_object and instance_exists(_asset)
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
					else if _prev_iden == dt_real or ((_prev_iden == -1 or _prev_iden == dt_variable) and string_is_float(segment) and (_macro_type == -1 or _macro_type == dt_real))
					{
						if string_is_float(segment)
						{
							if _prev_iden == dt_real _col = dt_real
							else if char == "." or _prev_iden == dt_variable
							{
								if instance_exists(real(segment)) _col = dt_instance
								else _col = _iden_string ? dt_string : dt_unknown
							}
							else 
							{
								possible_accessors = get_possible_accessors(real(segment))
								_col = dt_real
							}
								
							instscope = segment
						}
					}
					else if _macro_type == -1 or _macro_type == dt_variable or _macro_type == dt_method
					{
						var _varstring = string_add_scope(segment, _prev_iden == -1) 
							
						if variable_string_exists(_varstring) and _macro_type != dt_method and not (prev_char == "." and instscope == "")
						{
							var value = variable_string_get(_varstring)
							
							if _macro_type == dt_variable	_col = dt_builtinvar
							else if is_struct(value)		_col = dt_instance
							else if is_method(value)		_col = dt_method
							else							_col = dt_variable
						
							possible_accessors = get_possible_accessors(value)
								
							instscope = _varstring
						}
						else if _macro_type == -1 and ds_map_exists(deprecated_commands, segment)
						{
							_col = dt_deprecated
						}
					}
				}
				else
				{
					instscope += "."+segment
						
					var _varstring = string_add_scope(instscope, _prev_iden == -1)
						
					if variable_string_exists(_varstring)
					{
						var value = variable_string_get(_varstring)
						
						if is_struct(value)			_col = dt_instance
						else if is_method(value)	_col = dt_method
						else						_col = dt_variable

						possible_accessors = get_possible_accessors(value)
					}
				}
			}
				
			if marker != 0 and prev_char != " "	push_combine(color_list, marker+1, _iden_string ? dt_string : dt_unknown)
			if segment != ""					push_combine(color_list, i+string_onset+(_iden != -1), _col, _hl, _ol)
				
			if string_pos(char, iden_sep)
			{
				_iden_string = false
				_prev_iden = -1
			}
				
			if subject and segment != "" and (string_pos(char, subj_sep) or i == string_length(_command)+1)
			{
				if _char_pos <= i 
				{
					subject_interpret = gmcl_interpret_subject( _iden_name + (string_pos(".", instscope) ? instscope : plain_segment), undefined ).description
				}
					
				subject = false
			}
				
			if char == "["
			{
				in_brackets ++
				accessor = ""
				can_have_accessor = true
			}
			else if in_brackets and char == "]"
			{
				in_brackets --
				accessor = ""
				can_have_accessor = false
				possible_accessors = ""
			}
			else if char == ";" and subject_interpret == "" subject = true
				
			if _iden == dt_string _iden_string = true
			else _prev_iden = _iden
				
			if char != "." or not (_prev_iden == -1 or _prev_iden == dt_variable or _prev_iden == dt_string)
			{
				instscope = ""
			}
				
			prev_char = char
			
			marker = i-string_offset
			
			_iden = -1
		}
	}
}

if string_length(command) > max_length 
{
	push_combine(color_list, string_length(command), dt_unknown)
	
	_command = command
}

console_color_time = 0

return {text: _command, colors: color_list, subject_interpret: subject_interpret}
}
catch(_exception)
{
	console_color_time = -1
	
	push_combine(color_list, string_length(_command)+1, "plain")
	
	return {text: _command, colors: color_list}
}
}}