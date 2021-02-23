
function display(variable, toggle){ with o_console {

if is_undefined(variable)
{
	if ds_list_size(display_objects) == 0
	{
		return "Nothing to display!"
	}
	else
	{
		Display.enabled = not Display.enabled
		return "Display toggled"	
	}
}

variable = string_add_scope(variable)

if is_undefined(variable)
{
	return "Missing variable scope"
}

var var_split = string_split(".", variable)
var obj = var_split[0]
var firstscope = var_split[1]
var currently_displayed = is_on_display(variable)

if obj == "o_console" and firstscope == "Display"
{
	return "Umm, not sure displaying the Display with the Display is a good idea..."
	//later: add a blacklist of variables instead of just removing the entire display
}

if currently_displayed and toggle
{
	return "I mean.. thats already on the Display, so.."
}

else if not currently_displayed and not toggle
{
	return "Yeah, uh, that wasn't on the display in the first place, but whatever"
}

if is_undefined(toggle) toggle = not currently_displayed

if toggle
{
	ds_list_add(display_list, {variable: variable})
	return "Added "+variable+" to the Display"
}
else
{
	ds_list_delete( display_list, ds_list_find_index(display_list, {variable: variable}) )
	return "Removed "+variable+" from the Display"
}
}}
/*
variable = parse_console_string(variable, true)
if variable != false //error
{
	return variable
}
else if instance_exists(temp_obj) or temp_obj == global
{
	var index = ds_list_compare(display_objects, display_variables, temp_obj, arg)

	var obj_name
	if temp_obj == global	obj_name = "global"
	else					obj_name = object_get_name(temp_obj.object_index)

	if toggle != false and index == -1
	{
		if temp_obj == o_console and arg == "Display"
		{
			return "Umm, not sure displaying the Display with the Display is a good idea..."
		}
		else
		{
			ds_list_add(display_objects, temp_obj)
			ds_list_add(display_variables, arg)
			Display.enabled = true
			Display.show = true
			return "Displaying "+obj_name+"."+arg
		}
	}
	else if toggle == false or index != -1
	{
		ds_list_delete(display_objects, index)
		ds_list_delete(display_variables, index)
		Display.enabled = true
		Display.show = true
		return "No longer displaying "+obj_name+"."+arg
	}
}
}