
function GBL_parse(command){

static term_sep = " ,()"

var args = []

var marker = 1
var index = 1
var char = ""
var segment = ""

var is_subject = true
var in_string = false
var in_brackets = 0
var in_parentheses = 0

var is_last = false
var is_sep = false

command = shave(" ", command)

while index <= string_length(command)
{
	char = string_char_at(command, index)
	is_last = index == string_length(command)
	
	index ++  // After this, index represents the character after current one
	
	if not is_last
	{
		if char == "\""
		{
			in_string = not in_string
			continue
		}
	
		if in_string
		{
			continue
		}
	
		if char == "["
		{
			in_brackets ++
			continue
		}
	
		if char == "]"
		{
			in_brackets = max(0, in_brackets-1)
			continue
		}
	
		if in_brackets
		{
			continue
		}
	}
	
	var is_sep = string_pos(char, term_sep) != 0
	
	if is_last or is_sep
	{
		segment = slice(command, marker, index-1 + (not is_sep))
		
		if not (segment == "" and char == " ")
		{
			if segment == "" segment = "undefined"
			
			if not in_string and in_brackets == 0 and (char == "(" or char == ")")
			{
				in_parentheses += signbool(char == "(")
				
				array_push(args, segment, char)
			}
			else array_push(args, segment)
		}
		
		marker = index
		
		is_subject = false
		continue
	}
}


if in_string command += "\""
command += string_repeat("]", in_brackets)
command += string_repeat(")", in_parentheses)

return args
}
