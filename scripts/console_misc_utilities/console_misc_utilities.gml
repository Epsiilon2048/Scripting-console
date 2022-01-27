
function string_to_instance(str, add_macro){ with o_console {

if str == "" return -1

var _is_real = string_is_int(str)

if _is_real 
{
	var _real = real(str)
	if	instance_exists(_real) or _real == global
	{
		return _real
	}
	return -1
}
else
{
	if is_undefined(add_macro) add_macro = true
	
	var macro = add_macro ? console_macros[$ str] : undefined
	
	if not is_undefined(macro) and macro.type == dt_instance
	{
		if instance_exists(macro.value) or macro.value == global
		{
			return macro.value
		}
	}
	
	var _asset_index = asset_get_index(str)
	if	_asset_index > -1 and asset_get_type(str) == asset_object
	{
		return _asset_index
	}
	
	return -1
}
}}




function string_scope_to_id(str, add_macro){ with o_console {

if is_undefined(add_macro) add_macro = true

var inst = string_to_instance(string_copy(str, 1, string_pos(".", str)-1), add_macro)
if inst == -1 return undefined

var inst_id = (inst == global) ? global : inst.id

return string(inst_id) + string_delete(str, 1, string_pos(".", str)-1)
}}




function string_add_scope(str, add_macro){ with o_console {

if is_undefined(add_macro) add_macro = true

var dot_pos
var bracket_pos

if string_char_at(str, 1) == "."
{
	str = string_delete(str, 1, 1)
	dot_pos = 0
	bracket_pos = 0
}
else
{
	dot_pos = string_pos(".", str)
	bracket_pos = string_pos("[", str)
}

var segment

if not dot_pos and not bracket_pos
{
	
	if is_struct(object)			return str
	else if object_exists(object)	return object_get_name(object)+"."+str
	else if instance_exists(object)	return string(object)+"."+str
	else							return undefined
}
else if bracket_pos and (not dot_pos or bracket_pos < dot_pos)
{
	segment = slice(str, 1, bracket_pos, 1)
	
	if string_is_int(segment) or is_struct(object)	return str
	else if object_exists(object)					return object_get_name(object)+"."+str
	else if instance_exists(object)					return string(object)+"."+str
	else											return undefined
}
else
{
	segment = slice(str, 1, dot_pos, 1)
	
	if string_is_int(segment) return str
	
	var macro = add_macro ? console_macros[$ segment] : undefined
	
	if not is_undefined(macro) and (macro.type == dt_instance or macro.type == dt_variable)
	{
		var following = slice(str, dot_pos+1, -1, 1)
		
		if is_struct(macro.value)			return following
		else if is_string(macro.value)		return string_add_scope(macro.value, false)+"."+following
		else if object_exists(macro.value)	return object_get_name(macro.value)+"."+following
		else								return string(macro.value)+"."+following
	}
	
	var asset = asset_get_index(segment)
	var type = asset_get_type(segment)
	
	if not (asset == -1 or type != asset_object or not instance_exists(asset)) return str
	else if is_struct(object)		return str
	else if object_exists(object)	return object_get_name(object)+"."+str
	else if instance_exists(object)	return string(object)+"."+str
	else							return undefined
}
}}