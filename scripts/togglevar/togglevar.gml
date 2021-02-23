// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function togglevar(variable){
	
var _variable = string_add_scope(variable)
var toggle

if is_undefined(_variable)
{
	return "Missing variable scope"
}
else if variable_string_exists(_variable)
{
	var toggle = not variable_string_get(_variable)
	
	variable_string_set(_variable, toggle)
	return stitch("Toggled "+variable+" (",toggle?"true":"false",")")
}
else
{
	return "Variable "+variable+" does not exist"
}
}