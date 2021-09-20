function gmcl_get_argument(command, pos){ with o_console {

static sep = " ,=():"

var marker = 1
var bmarker = 1
var in_string = false
var in_brackets = 0
var segment = ""
var instscope = ""

for(var i = 1; i <= string_length(command); i++)
{
	var char = string_char_at(command, i)
	
	if not in_string and in_brackets and char == "]"
	{
		in_brackets --
	}
	else if not in_string and char == "["
	{
		in_brackets ++
		bmarker = i+1
	}
	
	if char == "\""
	{
		in_string = not in_string
	}
	else if not in_string and not in_brackets and string_pos(char, sep)
	{
		if pos <= i break
		marker = i+1
	}
}

segment = string_copy(command, marker, i-marker)



var iden = identifiers[$ (string_char_at(segment, 2) == "/") ? string_char_at(segment, 1) : undefined]

return {scope: instscope, arg: segment, inst: inst, variable: variable, iden: iden}
}}