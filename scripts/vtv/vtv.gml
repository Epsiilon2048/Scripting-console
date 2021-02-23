// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function vtv(var2, var1){

var obj1
var obj2

if is_undefined(var1)
{
	from_var = ""
	to_var = ""
	from_object = noone
	to_object = noone
	return "Var to var cleared"
}
else
{
	var parse_error = parse_console_string(var1, true)
	if parse_error != false
	{
		return parse_error
	}
	else
	{
		var1 = arg
		obj1 = temp_obj
	
		parse_error = parse_console_string(var2, true)
		if parse_error != false
		{
			return parse_error
		}
		else
		{
			var2 = arg
			obj2 = temp_obj
		
			from_var = var1
			to_var = var2
			from_object = obj1
			to_object = obj2
			return object_get_name(to_object)+"."+to_var+" being set to "+object_get_name(from_object)+"."+from_var
		}
	}
}
}