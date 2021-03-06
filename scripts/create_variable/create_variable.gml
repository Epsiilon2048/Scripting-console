// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function create_variable(name, value){

var _name = string_add_scope(name)

if not is_undefined(_name)
{
	var _existed = variable_string_exists(_name, value)
	
	variable_string_set(_name, value)
	
	if _existed return "Set "+name+" to "+string(value)
	
	else return "Declared "+name+" as "+string(value)
}
else return "Missing variable scope"
}