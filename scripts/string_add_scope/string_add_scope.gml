
function string_add_scope(str){ with o_console {

var split = string_split(".", str)

if (array_length(split) < 2) or (
   not string_is_int(split[0]) and
   asset_get_index(split[0]) == -1)
{
	if instance_exists(object) return string(object)+"."+str
	else return undefined
}
return str
}}