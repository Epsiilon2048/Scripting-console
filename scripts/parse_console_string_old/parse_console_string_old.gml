// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function parse_console_string_old(segment, firstarg){

segment = shave(",", segment)

if string_pos("\"", segment) == 1 and string_pos_index("\"", segment, 2) == string_length(segment)//string
{
	if firstarg
	{
		return shave("\"", segment)
	}
	else
	{
		arg = shave("\"", segment)
	}
}
else if string_copy(segment, 1, string_length(o_console.old_obj_identifier)) == o_console.old_obj_identifier or string_copy(segment, 1, 2) == "o/" or string_copy(segment, 1, 6) == "global" //starts with object
{
	if string_pos(".", segment) != 0 //variable in other object
	{
		var segment_split = string_split(".", segment)
		if instance_exists(asset_get_index(segment_split[0])) or o_console.console_macros[? segment_split[0]].value == global
		{
			var obj_id
			
			if o_console.console_macros[$ segment_split[0]].value == global obj_id = global
			else obj_id = asset_get_index(segment_split[0])
			
			if variable_instance_exists(obj_id, segment_split[1]) or (obj_id == global and variable_global_exists(segment_split[1]))
			{
				if firstarg
				{
					temp_obj = obj_id
					arg = segment_split[1]
				}
				else
				{
					arg = variable_instance_get(obj_id, segment_split[1])
				}
			}
			else
			{
				return segment_split[0]+"."+segment_split[1]+" does not exist"
			}
		}
		else return "Object '"+segment_split[0]+"' does not exist"
	}
	else //object
	{
		var obj_id = asset_get_index(segment)
		
		if instance_exists(obj_id) arg = obj_id
		else if segment == "global" arg = global
		else return "Object '"+segment+"' does not exist"
	}
}
else if string_is_int(segment) //integer
{
	arg = int64(segment)
}
else if string_is_float(segment) //float
{
	arg = real(segment)
}
else if script_exists(asset_get_index(segment)) and firstarg
{
	arg = segment
}
else if variable_instance_exists(object, segment) //variable in object
{
	if firstarg
	{
		temp_obj = object
		arg = segment
	}
	else
	{
		arg = variable_instance_get(object, segment)
	}
}
else if variable_global_exists(segment)
{
	arg = variable_global_get(segment)
}
else if o_console.console_macros[$ segment] != undefined
{
	arg = o_console.console_macros[$ segment].value
	
	if firstarg
	{
		if arg == noone
		{
			object = noone
			return "Cleared object"
		}
	}
}
else if segment == "" or is_undefined(segment)
{
	return undefined
}
else
{
	return "'"+segment+"' does not exist"
}
return false
} 