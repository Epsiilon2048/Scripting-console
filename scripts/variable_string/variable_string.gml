
global.id = global
global.object_index = global
global.__chatterbox_exists = gmcl_work_with_chatterbox and asset_get_index("ChatterboxVariableGet") != -1

global.chatterboxVariablesMap = ds_map_create()
global.chatterboxVariablesList = ds_list_create()

function ChatterboxVariableGet(variable){
	return global.chatterboxVariablesMap[? variable]
}
function ChatterboxVariableSet(variable, value){
	global.chatterboxVariablesMap[? variable] = value
}

///@description Sets a string variable to a value
///@param {string} name
///@peram {*} value
function variable_string_set(name, value){

if console_exists and o_console.run_in_console and (instance_exists(o_console.object) or is_struct(o_console.object)) with o_console.object __variable_string__(name, variable_string_set, value)
else __variable_string__(name, variable_string_set, value)
}

///@description Returns the value of a string variable
///@param {string} name
function variable_string_get(name){

if console_exists and o_console.run_in_console and (instance_exists(o_console.object) or is_struct(o_console.object)) with o_console.object return __variable_string__(name, variable_string_get, undefined)
else return __variable_string__(name, variable_string_get, undefined)
}

///@description Returns if a string variable exists
///@param {string} name
function variable_string_exists(name){

if console_exists and o_console.run_in_console and (instance_exists(o_console.object) or is_struct(o_console.object)) with o_console.object return __variable_string__(name, variable_string_exists, undefined)
else return __variable_string__(name, variable_string_exists, undefined)
}

///@description Returns a struct with information on a string veriable
///@param {string} name
function variable_string_info(name){

if console_exists and o_console.run_in_console and (instance_exists(o_console.object) or is_struct(o_console.object)) with o_console.object return __variable_string__(name, variable_string_info, undefined)
else return __variable_string__(name, variable_string_info, undefined)
}

function __variable_string__(name, scr, value){

//show_debug_message($"{name}, {scr}")

static accessors = "@|$?#"
static next_pos = function(str, startpos, has_accessor){
	
	startpos += 1
	var pos1 = string_pos_ext(".", str, startpos)
	var pos2 = has_accessor ? string_pos_ext("[", str, startpos) : 0
	
	if		not pos2 return pos1
	else if	not pos1 return pos2
	
	return min(pos1, pos2)
}
static get_fail_return = function(scr, exception, segment=undefined, simple=false, scope=undefined, prev_scope=undefined){
	if not is_undefined(segment) segment = string(segment)
	//show_debug_message($"Failure: {segment}; {exception}")
	
	switch scr
	{
		case variable_string_exists: return false
		case variable_string_get:	 return undefined
		case variable_string_set:	 return undefined
		case variable_string_info:	 return {value: undefined, scope: scope, prev_scope: prev_scope, exists: false, error: exception, plain: segment, simple: simple}
	}
	return undefined
}

var set_var		= not is_undefined(value)
var set_return	= (scr == variable_string_exists) ? true : undefined

if not is_string(name)
{
	if is_method(name) or (is_numeric(name) and better_script_exists(name)) switch scr
	{
		case variable_string_exists: return true
		case variable_string_get:	 return name()
		case variable_string_set:	 return name(value)
		case variable_string_info:	 return {value: name(), scope: undefined, exists: true, error: undefined, plain: name, simple: true}
	}
	else return get_fail_return(scr, exceptionExpectingString)
}
if name == "" return get_fail_return(scr, exceptionNoValue)

if string_char_at(name, 1) == "$"
{
	if not global.__chatterbox_exists return get_fail_return(scr, exceptionNoChatterbox)
	if not chatterbox_is_ready return get_fail_return(scr, exceptionChatterboxNotReady)
	
	name = slice(name, 2)
	if ds_map_exists(global.chatterboxVariablesMap, name)
	{
		switch scr
		{
			case variable_string_exists: return true
			case variable_string_get: return ChatterboxVariableGet(name)
			case variable_string_set: return ChatterboxVariableSet(name, value)
			case variable_string_info: return {value: ChatterboxVariableGet(name), scope: undefined, exists: true, error: undefined, plain: name, simple: true}
		}
	}
	else
	{
		return get_fail_return(scr, exceptionChatterboxVariableNotExists)
	}
}

if string_last(name) == "." name = string_delete(name, string_length(name), 1)
if string_char_at(name, 1) == "." name = is_struct(self) ? string_delete(name, 1, 1) : (string(id)+name)

var has_accessor = string_pos("[", name)
//var pos = next_pos(name, 1, has_accessor)
var pos = next_pos(name, 1, has_accessor)
var marker = 0

if has_accessor == 1 return get_fail_return(scr, exceptionNoValue, name)

var name_len = string_length(name)
var segment
var plain_segment
var scope_segment

if pos == 0 segment = name
else segment = string_copy(name, 1, pos-1)

var returning = false
var scope = string_to_instance(segment, true)

if scope == -1
{
	if string_is_float(segment)
	{
		scope = real(segment)
		scope_segment = segment
	}
	else
	{		
		pos = 0
		scope = self
		scope_segment = is_struct(self) ? (variable_struct_exists(self, "name") ? self.name : instanceof(self)) : better_object_get_name(id)
	}
}
else scope_segment = better_object_get_name(scope)

var ds_scope = (is_numeric(scope) and instance_exists(scope)) ? string(scope.id) : ""
var prev_scope = undefined

var simple = not has_accessor

plain_segment = segment
global._scrvar_.name = string(name)

do
{
	if marker != 0 simple = false
	
	prev_scope = scope
	
	if not (has_accessor and string_char_at(name, pos) == "[")
	{
		if marker != 0 and not is_struct(scope) and not (is_numeric(scope) and instance_exists(scope)) return get_fail_return(scr, exceptionBadScope, scope_segment, simple, scope, prev_scope)
		
		marker = pos
		
		pos = next_pos(name, pos, has_accessor)
	
		if pos == 0 segment = string_delete(name, 1, marker)
		else segment = string_copy(name, marker+1, pos-marker-1)
		plain_segment = segment
	
		//show_debug_message($"-----Segment: {segment}, name: {name}, pos {pos}, marker {marker}")
		if not variable_instance_exists(scope, segment) and not (scope == global and variable_global_exists(segment)) return get_fail_return(scr, exceptionVariableNotExists, segment, simple, scope, prev_scope)
		
		returning = not pos and set_var
		if returning
		{
			variable_instance_set(scope, segment, value)
			return set_return
		}
		
		scope = variable_instance_get(scope, segment)
		scope_segment = segment
		
		if has_accessor
		{
			if is_numeric(scope)
			{
				if ds_map_exists(o_console.ds_types, ds_scope+"."+segment)
				{
					ds_scope += "."+segment
				}
				else if instance_exists(scope)
				{
					ds_scope = string(scope.id)
				}
				else
				{
					ds_scope = ""
				}
			}
			else ds_scope += "."+segment
		}
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
		
		plain_segment = slice(name, marker, pos, 1)
		segment = string_replace_all(slice(plain_segment, 2, -2, 1), " ", "")
		
		if pos > name_len pos = 0
		returning = not pos and set_var
		
		var access_type = string_char_at(segment, 1)

		if not string_pos(access_type, accessors)
		{
			if is_array(scope) access_type = "@"
			else if is_struct(scope) access_type = "$"
			else if is_numeric(scope)
			{
				if ds_map_exists(o_console.ds_types, ds_scope)
				{
					switch o_console.ds_types[? ds_scope]
					{
						case ds_type_list: access_type = "|"
						break
						case ds_type_map: access_type = "?"
						break
						case ds_type_grid: access_type = "#"
					}
				}
				else return get_fail_return(scr, exceptionMissingAccessor, scope_segment+plain_segment, , scope, prev_scope)
			}
			else return get_fail_return(scr, exceptionFailedAccess, scope_segment, , scope, prev_scope)
		}
		else segment = string_delete(segment, 1, 1)
		
		var index
		
		static interpret = function(index){
				
			global._scrvar_.error = false
			
			if index == ""
			{
				global._scrvar_.error = true
				return {error: exceptionNoIndex, plain: global._scrvar_.name}
			}
			else if string_is_int(index) 
			{
				return real(index)
			}
			else if string_char_at(index, 1) == "\"" and string_last(index) == "\""
			{
				return slice(index, 2, -2, 1)
			}
			else
			{
				var arg = gmcl_interpret_argument(index)
				if not is_undefined(arg.error) 
				{
					global._scrvar_.error = true
					return is_struct(arg.error) ? arg.error : arg
				}
				else if arg.type == dt_variable
				{
					if is_numeric(arg.value) or is_method(arg.value) return arg.value()
					else return variable_string_get(arg.value)
				}
				else return arg.value
			}
		}
		
		var comma
		
		if access_type == "@" or access_type == "#" comma = string_pos(",", segment)
		else comma = 0
		
		if comma
		{	
			_pos = string_pos("[", segment)
			if _pos and comma > _pos
			{
				var _pos = 0
				var char
				var open = 0
				do
				{
					_pos++
					char = string_char_at(segment, _pos)
					open += (char == "[") - (char == "]")
				}
				until (not open and char == ",") or _pos > name_len
				
				if _pos > name_len comma = 0
				else comma = _pos
			}
			
			if comma
			{			
				index = {x: slice(segment, 1, comma, 1), y: slice(segment, comma+1, -1, 1)}
			
				index.x = interpret(index.x)
				if global._scrvar_.error return get_fail_return(scr, index.x.error, index.x.plain, simple, scope, prev_scope)
				
				index.y = interpret(index.y)
				if global._scrvar_.error return get_fail_return(scr, index.y.error, index.y.plain, simple, scope, prev_scope)
			}
		}
		if not comma
		{
			index = interpret(segment)
			if global._scrvar_.error return get_fail_return(scr, index.error, index.plain, , scope, prev_scope)
		}
		
		switch access_type
		{
		case "@":
			if not is_array(scope) return get_fail_return(scr, exceptionBadAccessor, scope_segment, , scope, prev_scope)
			
			if comma
			{
				if not is_numeric(index.x) or not is_numeric(index.y)			return get_fail_return(scr, exceptionBadIndex, scope_segment+plain_segment, , scope, prev_scope)
				if index.x < 0													return get_fail_return(scr, exceptionIndexBelowZero, index.x, , scope, prev_scope)
				if index.y < 0													return get_fail_return(scr, exceptionIndexBelowZero, index.y, , scope, prev_scope)
				if not returning and array_length(scope) <= index.x				return get_fail_return(scr, exceptionIndexExceedsBounds, index.x, , scope, prev_scope)
				if not is_array(scope[index.x])									return get_fail_return(scr, exceptionExpectingArray, scope_segment+plain_segment, , scope, prev_scope)
				if not returning and array_length(scope[index.x]) <= index.y	return get_fail_return(scr, exceptionIndexExceedsBounds, index.y, , scope, prev_scope)
			
				if not pos and set_var
				{
					scope[@ index.x, index.y] = value
					return set_return
				}
			
				scope = scope[@ index.x, index.y]
				scope_segment += segment
			}
			else
			{
				if not is_numeric(index)							return get_fail_return(scr, exceptionBadIndex, scope_segment, , scope, prev_scope)
				if index < 0										return get_fail_return(scr, exceptionIndexBelowZero, index, , scope, prev_scope)
				if not returning and index >= array_length(scope)	return get_fail_return(scr, exceptionIndexExceedsBounds, index, , scope, prev_scope)
				
				if not pos and set_var
				{
					scope[@ index] = value
					return set_return
				}
				
				scope = scope[index]
				scope_segment += segment
			}
		break
		case "|":
			if not is_numeric(scope)							return get_fail_return(scr, exceptionBadAccessor, scope_segment, , scope, prev_scope)
			if not ds_exists(scope, ds_type_list)				return get_fail_return(scr, exceptionDsNotExists, scope_segment, , scope, prev_scope)
			if not is_numeric(index)							return get_fail_return(scr, exceptionBadIndex, scope_segment+plain_segment, , scope, prev_scope)
			if index < 0										return get_fail_return(scr, exceptionIndexBelowZero, index, , scope, prev_scope)
			if not returning and index >= ds_list_size(scope)	return get_fail_return(scr, exceptionIndexExceedsBounds, index, , scope, prev_scope)
			
			if not pos and set_var
			{
				scope[| index] = value
				return set_return
			}
			
			scope = scope[| index]
			scope_segment += segment
		break
		case "$":
			index = string(index)
			
			if not is_struct(scope)											return get_fail_return(scr, exceptionBadAccessor, scope_segment, , scope, prev_scope)
			if not returning and not variable_struct_exists(scope, index)	return get_fail_return(scr, exceptionVariableNotExists, scope_segment+plain_segment, , scope, prev_scope)
			
			if not pos and set_var
			{
				scope[$ index] = value
				return set_return
			}
			
			scope = scope[$ index]
			scope_segment += segment
		break
		case "?":
			index = string(index)
		
			if not is_numeric(scope) 								return get_fail_return(scr, exceptionBadAccessor, scope_segment, , scope, prev_scope)
			if not ds_exists(scope, ds_type_map)					return get_fail_return(scr, exceptionDsNotExists, scope_segment, , scope, prev_scope)
			if not returning and not ds_map_exists(scope, index)	return get_fail_return(scr, exceptionVariableNotExists, scope_segment+plain_segment, , scope, prev_scope)
			
			if not pos and set_var
			{
				scope[? index] = value
				return set_return
			}
			
			scope = scope[? index]
			scope_segment += segment
		break
		case "#":
			if not is_numeric(scope)								return get_fail_return(scr, exceptionBadAccessor, scope_segment, , scope, prev_scope)
			if not comma											return get_fail_return(scr, exceptionGridExpectingComma, scope_segment, , scope, prev_scope)
			if not ds_exists(scope, ds_type_grid)					return get_fail_return(scr, exceptionDsNotExists, scope_segment, , scope, prev_scope)
			if not (is_numeric(index.x) or is_numeric(index.y))		return get_fail_return(scr, exceptionBadIndex, scope_segment+plain_segment, , scope, prev_scope)
			if index.x < 0											return get_fail_return(scr, exceptionIndexBelowZero, index.x, , scope, prev_scope)
			if index.y < 0											return get_fail_return(scr, exceptionIndexBelowZero, index.y, , scope, prev_scope)
			if not returning and ds_grid_width(scope) <= index.x	return get_fail_return(scr, exceptionIndexExceedsBounds, index.x, , scope, prev_scope)
			if not returning and ds_grid_height(scope) <= index.y	return get_fail_return(scr, exceptionIndexExceedsBounds, index.y, , scope, prev_scope)
			
			if not pos and set_var
			{
				scope[# index.x, index.y] = value
				return undefined
			}
			
			scope = scope[# index.x, index.y]
			scope_segment += segment
		}
	}
}
until pos == 0

if scr == variable_string_exists	return true
if scr == variable_string_info		return {value: scope, scope: prev_scope, exists: true, error: undefined, plain: segment, simple: simple}
return scope
}