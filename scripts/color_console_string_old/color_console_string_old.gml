// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function color_console_string_old(str){ with o_console {

var list = []
var segment
var out

while str != ""
{
	if string_pos(" ", str) != 0
	{
		if  string_pos("\"", str) == 1
		{
			//show_message(string_pos(string_char_at(str, string_pos_index("\"", str, 2)+1), separators)!=0)
			if string_count("\"", str) == 1
			{
				out = string_length(str)
			}
			else if string_count("\"", str) > 1 and not string_count(string_char_at(str, string_pos_index("\"", str, 2)+1), separators)
			{
				if string_pos_ext(" ", str, string_pos_index("\"", str, 2)) == 0 out = string_length(str)
				else out = string_pos_ext(" ", str, string_pos_index("\"", str, 2))-1
			}
			else 
			{
				out = string_pos_index("\"", str, 2)
			}
		}
		
		else out = string_pos(" ", str)-1
		
		segment = string_copy(str, 1, out)
		str = string_delete(str, 1, out+(string_char_at(str, out) != "\""))
	}
	else
	{
		segment = str
		str = ""
	}
	
	if string_char_at(segment, 1) == "\"" and (string_count("\"", segment) == 1 or string_char_at(segment, string_length(segment)) == "\"") //string
	{
		list[array_length(list)] = {
			text: segment,
			col: colors.string
		}
	}
	else if string_copy(segment, 1, 2) == "o/" or string_copy(segment, 1, string_length(old_obj_identifier)) == old_obj_identifier or string_copy(segment, 1, 6) == "global" //object
	{
		if string_pos(".", segment) != 0
		{
			var sep
			sep[0] = string_copy(segment, 1, string_pos(".", segment)-1)
			sep[1] = string_copy(segment, string_pos(".", segment), string_length(segment))
			
			if array_length(sep) == 1 sep[1] = ""
			
			list[array_length(list)] = {
				text: sep[0],
				col: colors.instance
			}
			
			if variable_instance_exists(asset_get_index(sep[0]), string_copy(sep[1], 2, string_length(sep[1])-1)) or (sep[0] == "global" and variable_global_exists(string_copy(sep[1], 2, string_length(sep[1])-1)))
			{
				list[array_length(list)] = {
					text: sep[1]+" ",
					col: colors.variable	
				}
			}
			else
			{
				list[array_length(list)] = {
					text: sep[1]+" ",
					col: colors.plain
				}
			}
		}
		else
		{
			list[array_length(list)] = {
				text: segment+" ",
				col: colors.instance
			}
		}
	}
	else if string_is_float(segment)
	{
		list[array_length(list)] = {
			text: segment+" ",
			col: colors.real 
		}
	}
	else if script_get_name(asset_get_index(segment)) == segment and array_length(list) == 0
	{
		list[array_length(list)] = {
			text: segment+" ",
			col: colors.method
		}
	}
	else if console_macros[$ segment] != undefined
	{
		list[array_length(list)] = {
			text: segment+" ",
			col: colors.macro
		}
	}
	else if variable_instance_exists(object, segment)
	{
		list[array_length(list)] = {
			text: segment+" ",
			col: colors.variable
		}
	}
	else
	{
		list[array_length(list)] = {
			text: segment+" ",
			col: colors.plain
		}
	}
}
return list
}}