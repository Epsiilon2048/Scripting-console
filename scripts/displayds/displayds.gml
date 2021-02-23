
function displayds(variable, toggle){

var error_message = parse_console_string(variable, true)

if is_undefined(error_message)
{
	return "No DS list specified"
}
else if error_message != false //error
{
	return error_message
}
else if instance_exists(temp_obj) or temp_obj == global
{
	var index = ds_list_compare(display_objects, display_variables, temp_obj, "|"+arg)
	
	var obj_name
	if temp_obj == global	obj_name = "global"
	else					obj_name = object_get_name(temp_obj.object_index)
	
	if not ds_exists(variable_instance_get(temp_obj, arg), ds_type_list)
	{
		return "No DS list stored at "+obj_name+"."+arg
	}
	else if toggle != false and index == -1
	{
		ds_list_add(display_objects, temp_obj)
		ds_list_add(display_variables, "|"+arg)
		display_toggle = true
		display_hide = false
		return "Displaying "+obj_name+"."+arg+" as DS list"
	}
	else if toggle == false and index != -1
	{
		ds_list_delete(display_objects, index)
		ds_list_delete(display_variables, index)
		display_toggle = true
		display_hide = false
		return "No longer displaying "+obj_name+"."+arg
	}
}
}