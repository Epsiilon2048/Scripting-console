function input_set_pos(input){ with o_console {

input = string(input)

if string_pos(string_char_at(console_string, char_pos2), refresh_sep) char_pos2--

var _min = char_pos2
var _max = char_pos2

var str_length = string_length(console_string)

while _max < (str_length+1) and not string_pos(string_char_at(console_string, _max), refresh_sep)
{
	_max++
}

while _min > 0 and not string_pos(string_char_at(console_string, _min), refresh_sep)
{
	_min--
}
_min++

console_string = string_delete(console_string, _min, _max-_min)
console_string = string_insert(input, console_string, _min)
keyboard_string = console_string
color_string = gmcl_string_color(console_string, char_pos1)
char_pos1 = min(_min+string_length(input), string_length(console_string)+1)
char_pos2 = char_pos1
}}