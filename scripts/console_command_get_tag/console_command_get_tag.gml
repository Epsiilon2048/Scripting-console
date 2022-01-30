function console_command_get_tag(command){ with o_console {

var char
var tag = ""
var com_start = 1

for(var i = 1; i <= max(string_pos("#", command), string_pos("\\", command)); i++)
{
	char = string_char_at(command, i)
	
	if char == "#"
	{
		i ++
		do
		{
			char = string_char_at(command, i)
			tag += char
			i ++
		}
		until i > string_length(command) or (string_lettersdigits(char) != char and char != "_")

		tag = string_delete(tag, string_length(tag), 1)
		
		if is_undefined(tags[$ tag])
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

return {command: slice(command, com_start, -1, 1), tag: tag, com_start: com_start}
}}