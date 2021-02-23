// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function ar(array_name, index, value){

var _array_name = array_name

if is_string(array_name) _array_name = string_add_scope(array_name)

if is_undefined(_array_name)
{
	return "Missing variable scope"
}
else if is_undefined(value)
{
	var array = array_name
	
	if is_string(array) var array = variable_string_get(_array_name)
	
	return array[index]
}
else
{
	if variable_string_exists(_array_name)
	{
		var array = variable_string_get(_array_name)
	
		if is_array(array)
		{
			array[index] = value
			variable_string_set(_array_name, array)
		
			return stitch("Set "+array_name+"[",index,"] to ",value)
		}
		else
		{
			return array_name+" is not an array"
		}
	}
	else return "Array "+array_name+" does not exist"
}
}