// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function input_set(str, add){

with o_console
{
	input_log_index = -1
	console_toggle = true
	
	if not add 
	{
		ds_list_insert(input_log, 0, console_string)
		console_string = str
	}
	else
	{
		console_string = string_insert(str, console_string, char_pos1)
		char_pos1 += string_length(str)
		char_pos2 = char_pos1
	}

	keyboard_string = console_string
	color_string = color_console_string(console_string)
	char_pos1 = string_length(console_string)+1
	char_pos2 = char_pos1
}
}