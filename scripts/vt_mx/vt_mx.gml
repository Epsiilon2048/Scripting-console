
function vt_mx(variable){

if is_undefined(variable)
{
	if to_mouse_x == ""
	{
		return "You need to specify a variable!"
	}
	else
	{
		var text = object_get_name(to_mouse_x_object)+"."+to_mouse_x+" no longer following mouse_x"
		to_mouse_x = ""
		to_mouse_x_object = noone
		return text
	}
}
else if not instance_exists(object)
{
	return "No object set"
}
else if not variable_instance_exists(object, variable)
{
	return object_get_name(object)+"."+variable+" does not exist"
}
else
{
	to_mouse_x = variable
	to_mouse_x_object = object
	return object_get_name(object)+"."+variable+" now following mouse_x"
}
}