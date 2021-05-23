
function gmcl_compile(command){ with o_console {

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

// The compiler isn't very efficient at all. At the moment however, it probably doesn't need to be.
// Many commands can still be compiled per step without a frame drop. Given how most commands are
// going to be quite short, and how it's rarely ever going to compile a command more than one time
// per step, it probably isn't a worthwhile investment.

static space_sep = " ,=():"
static iden_sep	 = " ;,=()"
static tag_sep   = " "

if shave(" ", command) == "" return ""

var _command = command

var char
var tag = ""
var com_start = 1

#region Compiler instructions
for(var i = 1; i <= max(string_pos("#", _command), string_pos("\\", _command)); i++)
{
	char = string_char_at(_command, i)
	
	if char == "#"
	{
		i ++
		do
		{
			char = string_char_at(_command, i)
			tag += char
			i ++
		}
		until i > string_length(_command) or (string_lettersdigits(char) != char and char != "_")

		tag = string_delete(tag, string_length(tag), 1)
		
		if is_undefined(event_commands[$ tag])
		{
			tag = ""
		}
		else com_start = i
	}
	else if not string_pos(char, tag_sep)
	{
		if char == "\\" com_start = i+1
		break
	}
}
#endregion

#region Separate commands
var command_split = []

var marker = com_start
var in_string = false

for(var i = com_start; i <= string_length(_command); i++)
{
	var char = string_char_at(_command, i)
	
	if in_string and char == "\\"
	{
		if string_char_at(_command, i+1) == "n" _command = string_replace(_command, "\\n", "\n")
		else i++
	}
	else if char == "\""
	{
		in_string = not in_string
	}
	else if not in_string and char == ";"
	{
		array_push(command_split, string_copy(_command, marker, i-marker) )
		marker = i+1
	}
}

if in_string and string_last(_command) != "\"" _command += "\""
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
var in_brackets = 0

for(var i = 1; i <= string_length(line); i++)
{
	var char = string_char_at(line, i)
	
	if not in_string and in_brackets and char == "]"
	{
		in_brackets --
	}
	else if not in_string and char == "["
	{
		in_brackets ++
	}
	else if in_string and char == "\\"
	{
		line = string_delete(line, i, 1) 
	}
	else if char == "\""
	{
		if not in_string and not in_brackets
		{
			if marker != i array_push(arg_split, string_copy(line, marker, i-marker+in_string))
			marker = i+in_string
		}
			
		in_string = not in_string
	}
	else if not in_string and not in_brackets and string_pos(char, space_sep)
	{
		if marker != i array_push(arg_split, string_copy(line, marker, i-marker))
		marker = i+1
	}	
}
if in_brackets line += string_repeat("]", in_brackets)
if marker != i array_push(arg_split, string_copy(line, marker, string_length(line)-marker+1))

lines[l] = arg_split
}
#endregion


for(var l = 0; l <= array_length(lines)-1; l++)
{
if array_length(lines[l]) > 0
{

var line = lines[l]

var comp_line = array_create(array_length(line)-1)

var subject = gmcl_interpret_subject(line[0], array_length(line))
var error = subject.error

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
			
			type = _macro.type
		}
		else arg = _arg
	
		//reeeeeally weird logic here, i swear its necessary
		if type == dt_string or (type == -1 and string_char_at(arg, 1) == "\"" and string_last(arg) == "\"")
		{
			if type != dt_string arg = string_copy(arg, 2, string_length(arg)-2)
			type = dt_string
		}
		if (type == -1 or type == dt_asset or type == dt_room or type == dt_method or type == dt_instance) and asset_get_index(arg) != -1
		{
			type = dt_asset
		}
		if (type == -1 or type == dt_real or type == dt_instance or type == dt_method or type == dt_room or type == dt_asset or type == dt_color) and string_is_float(arg) 
		{
			if type == dt_color and not (not is_undefined(_macro) and _macro.type == dt_color)
			{
				arg = hex_to_color(arg)
			}
			
			type = dt_real
		}
		else if type == dt_color and string_is_float("0x"+arg)
		{
			if not (not is_undefined(_macro) and _macro.type == dt_color) arg = hex_to_color(arg)
			type = dt_real
		}
		
		if type == -1 or type == dt_variable
		{
			var varstring = string_add_scope(arg, not iden)

			if not is_undefined(varstring) and variable_string_exists(varstring)
			{
				type = dt_variable
			}
			else
			{
				type = undefined
			}
		}
	}
	
	switch type
	{
	case dt_real:		value = real(arg)
	break
	case dt_string:		value = arg
	break
	case dt_asset:		value = asset_get_index(arg)
	break
	case dt_variable:	value = variable_string_get( string_add_scope(arg, true) )
	break
	case dt_instance:	value = asset_get_index(arg)
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


return {tag: tag, commands: comp_lines, raw: string_copy(command, com_start, string_length(command)-com_start+1)}
}}