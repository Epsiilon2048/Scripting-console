
function string_add_scope(str){ with o_console {

var _str
if is_undefined(str) _str = ""
else _str = string(str)

var split = string_split(".", _str)

if array_length(split) == 0 return undefined

var _macro = console_macros[$ split[0]]

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

if not is_undefined(_macro) and (_macro.type == DT.OBJECT or _macro.type == DT.VARIABLE)
{
	split[0] = _macro.value
	
	return array_to_string(split, ".")
}

return _str
}}