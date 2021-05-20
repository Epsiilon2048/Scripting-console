
global.id = global

function vse(name, add_macro){
///@description variable_string_exists(name, [add_macro])

static accessors = "@|$?#"

if not is_string(name) or name == "" return undefined
if is_undefined(add_macro) add_macro = true

var pos = string_pos(".", name)
var marker = 0

var name_len = string_length(name)
var segment

if pos == 0 segment = name
else segment = string_copy(name, marker+1, pos-marker)

var scope = string_to_instance(segment, add_macro)
var scope_ds = -1

if scope == -1 scope = id

var pos

var has_accessor = string_pos("[", name) > 0
do
{
	if not (has_accessor and string_char_at(name, pos) == "[")
	{
		if marker != 0 and not is_struct(scope) return undefined
		marker = pos
		
		pos = string_pos_ext(".", name, pos)
	
		if pos == 0 segment = string_delete(name, 1, marker)
		else segment = string_copy(name, marker+1, pos-marker-1)
	
		if has_accessor and ((pos == 0 and string_last(name) == "]") or string_char_at(name, pos-1) == "]")
		{
			var _pos = string_pos("[", segment)-1
			if _pos == 0 return undefined
		
			pos = ((pos == 0) ? (name_len+1) : pos) - (string_length(segment)-_pos)
		
			segment = slice(segment, 1, _pos+1, undefined)
		}
	
		if not variable_instance_exists(scope, segment) return undefined
		scope = variable_instance_get(scope, segment)
	}
	else
	{
		marker = pos

		var char
		var open = 0
		
		do
		{
			char = string_char_at(name, pos++)
			open += (char == "[") - (char == "]")
		}
		until (open == 0 and char == "]") or pos > name_len
		
		segment = string_replace_all(slice(name, marker+1, pos-1, 1), " ", "")
		
		if pos > name_len pos = 0
		
		var access_type = string_char_at(segment, 1)
		
		if not string_pos(access_type, accessors)
		{
			if is_array(scope) access_type = "@"
			else if is_struct(scope) access_type = "$"
		}
		else segment = string_delete(segment, 1, 1)
		
		var index
		
		static interpret = function(index){
				
			if string_is_int(index) 
			{
				return real(index)
			}
			else if string_char_at(index, 1) == "\"" and string_last(index) == "\""
			{
				return slice(index, 2, -2, 1)
			}
			else
			{
				return vse(index, true)
			}
		}
		
		var comma
		
		if access_type == "@" or access_type == "#" comma = string_pos(",", segment)
		else comma = 0
		
		if comma
		{
			var _pos = string_pos("[", segment)
			
			if _pos and comma > _pos
			{
				var char
				var open = 0
				do
				{
					char = string_char_at(segment, _pos++)
					open += (char == "[") - (char == "]")
				}
				until (open == 0 and char == ",") or _pos > name_len
				
				comma = _pos
			}
			
			index = {x: slice(segment, 1, comma, 1), y: slice(segment, comma+1, -1, 1)}
			
			index.x = interpret(index.x)
			index.y = interpret(index.y)
			
			if is_undefined(index.x) or is_undefined(index.y) return undefined
		}
		else
		{
			index = interpret(segment)
			
			if is_undefined(index) return undefined
		}
		
		switch access_type
		{
		case "@":
			if not is_array(scope) return undefined
			
			if comma
			{
				if	not is_numeric(index.x) or 
					not is_numeric(index.y) or array_length(scope) <= index.x or 
					not is_array(scope[index.x]) or 
					array_length(scope[index.x]) <= index.y
				{
					return undefined
				}
			
				scope = scope[@ index.x, index.y]
			}
			else
			{
				if	not is_numeric(index) or 
					index < 0 or 
					index >= array_length(scope) 
				{
					return undefined
				}
			
				scope = scope[index]
			}
		break
		case "|":
			if	not is_numeric(scope) or 
				not ds_exists(scope, ds_type_list) or 
				not is_numeric(index) or index < 0 or 
				index >= ds_list_size(scope) 
			{
				return undefined
			}
			
			scope = scope[| index]
		break
		case "$":
			index = string(index)
			
			if	not is_struct(scope) or 
				not variable_struct_exists(scope, index) 
			{
				return undefined
			}
			
			scope = scope[$ index]
		break
		case "?":
			index = string(index)
		
			if	not is_numeric(scope) 
				or not ds_exists(scope, ds_type_map) or 
				not ds_map_exists(scope, index) 
			{
				return undefined
			}
			
			scope = scope[? index]
		break
		case "#":
			if	not comma or 
				not is_numeric(scope) or 
				not ds_exists(scope, ds_type_grid) or 
				not is_numeric(index.x) or 
				not is_numeric(index.y) or
				index.x < 0 or
				index.y < 0 or
				ds_grid_width(scope) <= index.x or 
				ds_grid_height(scope) <= index.y 
			{
				return undefined
			}
			
			scope = scope[# index.x, index.y]
		}
	}
}
until pos == 0
return scope
}