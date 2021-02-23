// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function con_exec2(command){ with o_console {

static space_sep = " ,()="

if command == "" return ""

#region Separate commands
var command_split = []

var marker = 1
var in_string = false

for(var i = 1; i <= string_length(command); i++)
{
	var char = string_char_at(command, i)
	
	if char == "\\" and in_string
	{
		i++
	}
	else
	{
		if char == "\""
		{
			in_string = not in_string
		}
		else if not in_string and char == ";"
		{
			array_push(command_split, string_copy(command, marker, i-marker) )
			marker = i+1
		}
	}
}

if in_string and string_pop(command) != "\"" command += "\""
array_push(command_split, string_copy(command, marker, string_length(command)-marker+1) )
#endregion

#region Separate arguments within commands
var lines = array_create(array_length(command_split))

for(var l = 0; l <= array_length(command_split)-1; l++)
{

var line = command_split[l]
var arg_split = []

var marker = 1
var in_string = false

for(var i = 1; i <= string_length(line); i++)
{
	var char = string_char_at(line, i)
	
	if char == "\\" and in_string
	{
		i++
	}
	else
	{
		if char == "\""
		{
			in_string = not in_string
		}
		else if not in_string and string_pos(char, space_sep)
		{
			if marker != i array_push(arg_split, string_copy(line, marker, i-marker))
			marker = i+1
		}
	}
}

if marker != i array_push(arg_split, string_copy(line, marker, string_length(line)-marker+1))

lines[l] = arg_split
}
#endregion

#region Decide argument datatypes
for(var l = 0; l <= array_length(lines)-1; l++)
{

var line = lines[l]

for(var i = 1; i <= array_length(line)-1; i++)
{
	var arg = line[i]
	var type = -1
	var value
	
	if string_char_at(arg, 2) == "/" and ds_map_exists(identifiers, string_char_at(arg, 1))
	{
		type = identifiers[? string_char_at(arg, 1)]
	}
	else if type == -1 and string_char_at(arg, 1) == "\"" and string_pop(arg) == "\""
	{
		type = DT.STRING
	}
	else if asset_get_index(arg) != -1
	{
		type = DT.ASSET
	}
	else if string_is_float(arg) 
	{
		type = DT.NUMBER
	}
	else
	{
		var varstring = string_add_scope(arg)

		if not is_undefined(varstring) and variable_string_exists(varstring)
		{
			type = DT.VARIABLE
		}
		else if not is_undefined( macro_get(arg) )
		{
			type = DT.MACRO
		}
		else
		{
			type = undefined
		}
	}

	aa = arg

	switch type
	{
	case DT.NUMBER:		value = real_float(arg)
	break
	case DT.STRING:		value = string_copy(arg, 2, string_length(arg)-1)
	break
	case DT.ASSET:		value = asset_get_index(arg)
	break
	case DT.VARIABLE:	value = variable_string_get( string_add_scope(arg) )
	break
	case DT.MACRO:		value = macro_get(arg)
	break
	case undefined:		return "Syntax from \""+arg+"\""
	}

	line[i] = value
}

}
#endregion

return line
}}