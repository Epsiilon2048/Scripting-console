
global.id = global
global.object_index = global

function variable_string_set(name, value){

if o_console.object == global return variable_string(string_add_scope(name), value, true)
else if instance_exists(o_console.object) with o_console.object variable_string(name, value, true)
else variable_string(name, value, true)
}

function variable_string_get(name){

if o_console.object == global return variable_string(string_add_scope(name), undefined, true)
else if instance_exists(o_console.object) with o_console.object return variable_string(name, undefined, true)
else return variable_string(name, undefined, true)
}

function variable_string_exists(name){

if o_console.object == global return variable_string(string_add_scope(name), undefined, false)
else if instance_exists(o_console.object) with o_console.object return variable_string(name, undefined, false)
else return variable_string(name, undefined, false)
}

function variable_string(name, value, return_undefined){

static accessors = "@|$?#"
static next_pos = function(str, startpos, has_accessor){
	
	var pos1 = string_pos_ext(".", str, startpos)
	var pos2 = has_accessor ? string_pos_ext("[", str, startpos) : 0
	
	if		not pos2 return pos1
	else if	not pos1 return pos2
	
	return min(pos1, pos2)
}

if is_undefined(return_undefined) return_undefined = true

var fail_return = return_undefined ? undefined : false
var set_var = not is_undefined(value)

if not is_string(name) or name == "" return fail_return

if string_char_at(name, 1) == "." name = string(id)+name

var has_accessor = string_pos("[", name) > 0
var pos = next_pos(name, 1, has_accessor)
var marker = 0

var name_len = string_length(name)
var segment

if pos == 0 segment = name
else segment = string_copy(name, 1, pos-1)

var returning = false
var scope = string_to_instance(segment, true)

if scope == -1
{
	if string_is_float(segment)
	{
		scope = real(segment)
	}
	else
	{
		pos = 0
		scope = id
	}
}

var pos

do
{
	if not (has_accessor and string_char_at(name, pos) == "[")
	{
		if marker != 0 and not is_struct(scope) and not (is_numeric(scope) and instance_exists(scope)) return fail_return
		marker = pos
		
		pos = next_pos(name, pos, has_accessor)
	
		if pos == 0 segment = string_delete(name, 1, marker)
		else segment = string_copy(name, marker+1, pos-marker-1)
	
		if not variable_instance_exists(scope, segment) and not (scope == global and variable_global_exists(segment)) return fail_return
		
		returning = not pos and set_var
		if returning
		{
			variable_instance_set(scope, segment, value)
			return undefined
		}
		
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
		returning = not pos and set_var
		
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
				return variable_string(index, undefined, true)
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
			
			if is_undefined(index.x) or is_undefined(index.y) return fail_return
		}
		else
		{
			index = interpret(segment)
			
			if is_undefined(index) return fail_return
		}
		
		switch access_type
		{
		case "@":
			if not is_array(scope) return fail_return
			
			if comma
			{
				if	not is_numeric(index.x) or 
					not is_numeric(index.y) or (not returning and array_length(scope) <= index.x) or 
					not is_array(scope[index.x]) or 
					(not returning and array_length(scope[index.x]) <= index.y)
				{
					return fail_return
				}
			
				if not pos and set_var
				{
					scope[@ index.x, index.y] = value
					return undefined
				}
			
				scope = scope[@ index.x, index.y]
			}
			else
			{
				if	not is_numeric(index) or 
					index < 0 or 
					(not returning and index >= array_length(scope))
				{
					return fail_return
				}
				
				if not pos and set_var
				{
					scope[@ index] = value
					return undefined
				}
				
				scope = scope[index]
			}
		break
		case "|":
			if	not is_numeric(scope) or 
				not ds_exists(scope, ds_type_list) or 
				not is_numeric(index) or index < 0 or 
				(not returning and index >= ds_list_size(scope))
			{
				return fail_return
			}
			
			if not pos and set_var
			{
				scope[| index] = value
				return undefined
			}
			
			scope = scope[| index]
		break
		case "$":
			index = string(index)
			
			if	not is_struct(scope) or 
				(not returning and not variable_struct_exists(scope, index))
			{
				return fail_return
			}
			
			if not pos and set_var
			{
				scope[$ index] = value
				return undefined
			}
			
			scope = scope[$ index]
		break
		case "?":
			index = string(index)
		
			if	not is_numeric(scope) 
				or not ds_exists(scope, ds_type_map) or 
				(not returning and not ds_map_exists(scope, index))
			{
				return fail_return
			}
			
			if not pos and set_var
			{
				scope[? index] = value
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
				(not returning and (ds_grid_width(scope) <= index.x or ds_grid_height(scope) <= index.y))
			{
				return fail_return
			}
			
			if not pos and set_var
			{
				scope[# index.x, index.y] = value
				return undefined
			}
			
			scope = scope[# index.x, index.y]
		}
	}
}
until pos == 0

if not return_undefined return true
return scope
}