

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

var inst = string_to_instance(string_copy(str, 1, string_pos(".", str)-1), true)

if inst == -1 return undefined

var inst_id = (inst == global) ? global : inst.id

return string(inst_id) + string_delete(str, 1, string_pos(".", str)-1)
}}


function string_add_scope(str, add_macro){ with o_console {

if is_undefined(add_macro) add_macro = true

var _str = is_undefined(str) ? "" : string(str)

if string_char_at(_str, 1) == "." _str = string_delete(_str, 1, 1)

var split = string_split(".", _str)

if array_length(split) == 0 return undefined

var _macro = add_macro ? console_macros[$ split[0]] : undefined

if array_length(split) < 2 or (
   split[0] != "global" and split[0] != "-5" and
   not string_is_int(split[0]) and
   asset_get_index(split[0]) == -1 and
   is_undefined(_macro)
   )
{
	if instance_exists(object) return string(object)+"."+_str
	else return undefined
}

if not is_undefined(_macro) and (_macro.type == dt_instance or _macro.type == dt_variable)
{
	split[0] = _macro.value
	
	return array_to_string(split, ".")
}

return _str
}}