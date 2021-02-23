// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function string_add_scope(str){ with o_console {

if not object_exists(asset_get_index(string_split(".", str)[0]))
{
	if object_exists(object) return string(object)+"."+str
	else return undefined
}
return str
}}