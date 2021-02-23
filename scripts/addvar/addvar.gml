// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function addvar(variable, value){

if is_undefined(value) value = 1

var _variable = string_add_scope(variable)

if is_undefined(_variable)
{
	return "Missing variable scope"
}
else if variable_string_exists(_variable)
{
	var _value = variable_string_get(_variable)
	
	variable_string_set(_variable, _value+value)
	return stitch("Added ",value," to "+variable+" (",_value+value,")")
}
else
{
	return "Variable "+variable+" does not exist"
}
}