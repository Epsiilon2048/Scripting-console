
global.id = global

function vse(name, add_macro){
///@description variable_string_exists(name, [add_macro])

static accessors = "@|$?#"

if not is_string(name) return false
if is_undefined(add_macro) add_macro = true

var pos = string_pos(".", name)
var marker = 0

seg = ""

var name_len = string_length(name)
var segment

if pos == 0 segment = name
else segment = string_copy(name, marker+1, pos-marker)

var scope = string_to_instance(segment, add_macro)

if scope == -1 scope = id

index = 0

var pos

do
{
	seg = segment
	index ++
	
	if string_char_at(name, pos) == "["
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
		
		segment = string_replace_all(slice(name, marker+1, pos-1), " ", "")
		
		if pos > name_len pos = 0
		
		var access_type = string_char_at(segment, 1)
		
		if not string_pos(access_type, accessors) access_type = "@"
		else segment = string_delete(segment, 1, 1)
		
		var index
		var comma = string_pos(",", segment)
		
		switch access_type
		{
		case "@":
			if not is_array(scope) return "wasnt array"
			
			if comma
			{
				index = {x: slice(segment, 1, comma, 1), y: slice(segment, comma+1, -1, 1)}
			
				if not string_is_int(index.x) or not string_is_int(index.y) return "invalid array access ("+stitch(index.x,", ",index.y)+")"
			
				index.x = real(index.x)
				index.y = real(index.y)
			
				if array_length(scope) <= index.x or not is_array(scope[index.x]) or array_length(scope[index.x]) <= index.y return "array grid out of range"
			
				scope = scope[@ index.x, index.y]
			}
			else
			{
				if not string_is_int(segment) return "invalid array access "+segment
			
				index = real(segment)
			
				if index < 0 or index >= array_length(scope) return "index in array out of range"
			
				scope = scope[index]
			}
		break
		case "|":
			if comma return "invalid list access"
			if not is_real(scope) or not ds_exists(scope, ds_type_list) return "wasnt list"
			
			if not string_is_int(segment) return "invalid array access "+segment
			
			index = real(segment)
			
			if index < 0 or index >= ds_list_size(scope) return "index in array out of range"
			
			scope = scope[| index]
		break
		case "$":
			if comma return "invalid struct access"
			if not is_struct(scope) return "wasnt struct"
			
			if string_char_at(segment, 1) == "\"" and string_last(segment) == "\""
			{
				index = slice(segment, 2, -2, 1)
			}
			else if string_is_int(segment)
			{
				index = real(segment)
			}
			else return "invalid struct access "+segment
			
			if not variable_struct_exists(scope, index) return "var didnt exist in struct "+string(index)
			
			scope = scope[$ index]
		break
		case "?":
			if comma return "invalid map access"
			if not is_real(scope) or not ds_exists(scope, ds_type_map) return "wasnt map"
			
			if string_char_at(segment, 1) == "\"" and string_last(segment) == "\""
			{
				index = slice(segment, 2, -2, 1)
			}
			else if string_is_int(segment)
			{
				index = real(segment)
			}
			else return "invalid map access "+segment
			
			if not ds_map_exists(scope, index) return "var didnt exist in map "+string(index)
			
			scope = scope[? index]
		break
		case "#":
			if not comma return "invalid grid access"
			if not is_real(scope) or not ds_exists(scope, ds_type_grid) return "wasnt grid"
			
			index = {x: slice(segment, 1, comma, 1), y: slice(segment, comma+1, -1, 1)}
			
			if not string_is_int(index.x) or not string_is_int(index.y) return "invalid grid access ("+stitch(index.x,", ",index.y)+")"
			
			index.x = real(index.x)
			index.y = real(index.y)
			
			if ds_grid_width(scope) <= index.x or ds_grid_height(scope) <= index.y return "ds grid out of range"
			
			scope = scope[# index.x, index.y]
		}
	}
	else
	{
		if marker != 0 and not is_struct(scope) return "was not instace"
		marker = pos
		
		pos = string_pos_ext(".", name, pos)
	
		if pos == 0 segment = string_delete(name, 1, marker)
		else segment = string_copy(name, marker+1, pos-marker-1)
	
		if (pos == 0 and string_last(name) == "]") or string_char_at(name, pos-1) == "]"
		{
			var _pos = string_pos("[", segment)-1
			if _pos == 0 return "invalid accessor"
		
			pos = ((pos == 0) ? (name_len+1) : pos) - (string_length(segment)-_pos)
		
			segment = slice(segment, 1, _pos+1, undefined)
		}
	
		if not variable_instance_exists(scope, segment) return "name "+segment+" didnt exist in "+string(scope)
		scope = variable_instance_get(scope, segment)
	}
}
until pos == 0
return scope
}