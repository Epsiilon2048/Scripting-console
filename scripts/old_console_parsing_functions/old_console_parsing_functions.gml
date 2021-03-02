// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function console_exec_old(command){ with o_console {

with o_console
{
var _console_string = string_split(";", command)

var _output_string = []
		
for(var i = 0; i <= array_length(_console_string)-1; i++)
{
	_console_string[i] = shave(",", shave(" ", _console_string[i]))
	var str = _console_string[i]
	var args = []
	var parse_error = ""
	var subject
	var out
	arg = 0
	_output_string[i] = ""
	temp_obj = object
			
	while str != ""
	{
		if string_pos(" ", str) != 0 
		{
			if string_pos("\"", str) != 0 and string_pos("\"", str) < string_pos(" ", str) out = string_pos_index("\"", str, 2) //if a " before a space
			else out = string_pos(" ", str)-1
			parse_error = parse_console_string(string_copy(str, 1, out), (str == _console_string[i]))
			if parse_error != false
			{
				_output_string[i] = parse_error
				break
			}
			else args[array_length(args)] = arg
					
			str = shave(",", shave(" ",string_delete(str, 1, out)))
		}
		else
		{
			parse_error = parse_console_string(str, (str == _console_string[i]))
			if parse_error != false
			{
				_output_string[i] = parse_error
				break
			}
			else args[array_length(args)] = arg
			str = ""
		}
	}
	if array_length(args) > 0 
	{
		subject = args[0]
		array_delete(args, 0, 1)
	}
	if _output_string[i] == ""
	{
		if script_exists(asset_get_index(subject)) //script
		{
			try _output_string[i] = script_execute_ext(asset_get_index(subject), args)
			catch(_exception) 
			{
				_output_string[i] = {__embedded__: true, o: [{str: "[SCRIPT ERROR]", scr: error_report, output: true}," "+_exception.message]}
				prev_longMessage = _exception.longMessage
			}
		}
		else if not is_string(subject) and instance_exists(subject) //object
		{
			object = subject
			_output_string[i] = "Seeking variables in "+object_get_name(object.object_index)
		}
		else if variable_instance_exists(temp_obj, subject) or (temp_obj == global and variable_global_exists(subject)) //variable
		{
			if array_length(args) == 0
			{
				_output_string[i] = variable_instance_get(temp_obj, subject)
				if is_real(_output_string[i]) _output_string[i] = string_format_float(_output_string[i])
			}
			else
			{
				var obj_name
				if temp_obj == global	obj_name = "global"
				else					obj_name = object_get_name(temp_obj.object_index)
						
				variable_instance_set(temp_obj, subject, args[0])
				var arg_string = args[0]
				if is_real(args[0]) arg_string = string_format_float(args[0])
				_output_string[i] = stitch("Set ",obj_name,".",subject," to ",arg_string)
			}
		}
		else if subject == global
		{
			_output_string[i] = "Cannot set object to global"
		}
	}
}
if array_length(_output_string) == 1 and not is_array(_output_string[0]) _output_string = [_output_string]

return _output_string
}
}}