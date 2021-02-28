// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function string_add_scope(str){ with o_console {

var split = string_split(".", str)[0]

if (string_is_int(split) and not instance_exists(real(split))) and
   (not instance_exists(asset_get_index(split)))
{
	if instance_exists(object) return string(object)+"."+str
	else return undefined
}
return str
}}