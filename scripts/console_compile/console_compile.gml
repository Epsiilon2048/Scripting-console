
function console_compile(command){ with o_console {

/*
GENERAL PROCESS
1: Separate the command string by semi-colons (;) into an array while paying mind to strings
2: Iterate through each line and separate them into statements - remove any extra whitespace as well
3: Take the first statement and interpret it, this is what informs the executor what to do
4: Interpret all the other statements - decide their datatypes and substitute variables and assets

SUBJECT INTERPRETATION
1: Check for datatype identifiers
2: Substitute console macros
3: If the subject is in quotes, it is a string
4: If the subject is an asset name, it is either an object, script, room, or nonspecific asset
5: If the subject is a base10 integer, it is either an object index or instance ID
6: If the subject is a base16 integer, it is a number (wow!)
7: If the subject is a variable with either the console's scope or a specified one, it is a variable
8: If none of these, it is marked as a syntax error

ARGUMENT INTERPRETATION
1: Check for datatype identifiers
2: Substitute console macros
3: If the arg is in quotes, it is a string
4: If the arg is an asset name, it substituted with an asset index
5: If the arg is a float, it is converted to real
6: If the arg is a variable with either the console's scope or a specified one, it is a variable
7: If none of these, it is marked as a syntax error
*/

static space_sep = " ,()=:"

if shave(" ", command) == "" return ""

var _command = string_replace_all(command, "\\n", "\n")


#region Separate commands
var command_split = []

var marker = 1
var in_string = false

for(var i = 1; i <= string_length(_command); i++)
{
	var char = string_char_at(_command, i)
	
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
			array_push(command_split, string_copy(_command, marker, i-marker) )
			marker = i+1
		}
	}
}

if in_string and string_pop(_command) != "\"" _command += "\""
array_push(command_split, string_copy(_command, marker, string_length(_command)-marker+1) )
#endregion


#region Separate statements
var lines		= array_create(array_length(command_split))
var comp_lines	= array_create(array_length(command_split))

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
		line = string_delete(line, i, 1)
		//i++
	}
	else
	{
		if char == "\""
		{
			if marker != i array_push(arg_split, string_copy(line, marker, i-marker+in_string))
			marker = i+in_string
			
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


for(var l = 0; l <= array_length(lines)-1; l++)
{
if array_length(lines[l]) > 0
{
	
#region Interpret subject
var line = lines[l]

var comp_line = array_create(array_length(line)-1)

var _arg = line[0]
var arg
var type = -1
var b = false
var value = undefined
var error = undefined

var iden = false

if string_char_at(_arg, 2) == "/" and variable_struct_exists(identifiers, string_char_at(_arg, 1))
{
	type = identifiers[$ string_char_at(_arg, 1)]
	_arg = string_copy(_arg, 3, string_length(_arg))
	iden = true
}

if _arg == "" 
{
	type = undefined
	arg = line[0]
}
else
{

	var _macro = console_macros[$ _arg]
	
	if type == -1 and not is_undefined(_macro)
	{
		b = variable_struct_exists_get(_macro, "b", false)
		
		if _macro.type == DT.NUMBER arg = string_format_float(_macro.value)
		else						arg = string(_macro.value)
		
		type = _macro.type
	}
	else arg = _arg

	if type == DT.STRING or (type == -1 and string_char_at(arg, 1) == "\"" and string_pop(arg) == "\"")
	{
		if type != DT.STRING value = string_copy(arg, 2, string_length(arg)-2)
		else value = arg
		
		type = DT.STRING
	}

	if (type == -1) and asset_get_index(arg) != -1
	{
		var asset_type = asset_get_type(arg)
		
		switch asset_type
		{
		case asset_script:	type = DT.SCRIPT
							value = asset_get_index(arg)
		break
		case asset_room:	type = DT.ROOM
		break
		case asset_object:
			if instance_exists(asset_get_index(arg))
			{
				type = DT.OBJECT
				value = asset_get_index(arg).id
			}
		}
		
		if type == -1 type = DT.ASSET
	}
	else if type == DT.SCRIPT value = real(arg)
	
	if (type == -1 or type == DT.OBJECT) and string_is_int(arg)
	{
		if string_pos("0x", arg) 
		{
			type = DT.NUMBER
		}
		else if instance_exists(real(arg)) or real(arg) == noone
		{
			type = DT.OBJECT
			if object_exists(real(arg)) value = real(arg).id
			else value = real(arg)
		}
		else 
		{
			type = undefined
		}
	}
	
	if type == DT.NUMBER
	{
		if string_is_float(arg) value = string_format_float(arg)
		else type = undefined
	}
	
	if type == -1 or type == DT.VARIABLE 
	{
		var varstring = string_add_scope(arg, not iden)

		if not is_undefined(varstring) and variable_string_exists(varstring)
		{
			var varstringvalue = variable_string_get(varstring)
			
			if type != DT.VARIABLE and is_method(varstringvalue)
			{
				type = DT.SCRIPT
				value = varstringvalue
			}
			else
			{
				type = DT.VARIABLE
				value = varstring
			}
		}
		else
		{
			type = undefined
		}
	}
	
}

if is_undefined(type) error = "[SYNTAX ERROR] from \""+arg+"\""

var subject = {
	value: value,
	type: type,
	plain: line[0],
	builtin: b,
}
#endregion


#region Interpret arguments
if is_undefined(error) for(var i = 1; i <= array_length(line)-1; i++)
{
	var _arg = line[i]
	var arg
	var type = -1
	var value
	var iden = false

	if string_char_at(_arg, 2) == "/" and variable_struct_exists(identifiers, string_char_at(_arg, 1))
	{
		type = identifiers[$ string_char_at(_arg, 1)]
		_arg = string_copy(_arg, 3, string_length(_arg))
		iden = true
	}
	
	if _arg == "" 
	{
		type = undefined
		arg = line[i]
	}
	else
	{
	
		var _macro = console_macros[$ _arg]
	
		if type == -1 and not is_undefined(_macro)
		{
			if is_real(_macro) arg = string_format_float(_macro.value)
			else			   arg = string(_macro.value)
		}
		else arg = _arg
	
		//reeeeeally weird logic here, i swear its necessary
		if (type == -1 or type == DT.STRING) and string_char_at(arg, 1) == "\"" and string_pop(arg) == "\""
		{
			if type != DT.STRING arg = string_copy(arg, 2, string_length(arg)-2)
			type = DT.STRING
		}
		if (type == -1) and asset_get_index(arg) != -1
		{
			type = DT.ASSET
		}
		if (type == -1) and string_is_float(arg) 
		{
			type = DT.NUMBER
		}
		if type == -1 or type == DT.VARIABLE
		{
			var varstring = string_add_scope(arg, not iden)

			if not is_undefined(varstring) and variable_string_exists(varstring)
			{
				type = DT.VARIABLE
			}
			else
			{
				type = undefined
			}
		}
		
	}
	
	switch type
	{
	case DT.NUMBER:		value = real(arg)
	break
	case DT.STRING:		value = arg
	break
	case DT.ASSET:		value = asset_get_index(arg)
	break
	case DT.VARIABLE:	value = variable_string_get( string_add_scope(arg) )
	break
	case undefined:		value = "[SYNTAX ERROR] from \""+line[i]+"\""
						error = value
	}

	comp_line[i-1] = {
		value: value, 
		type: type,
		plain: line[i],
	}
	
	if not is_undefined(error) break
}
comp_lines[l] = {subject: subject, args: comp_line, error: error}
}
}
#endregion


return comp_lines
}}