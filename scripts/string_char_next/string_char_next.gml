
function string_char_next(chars, str, pos, dir){

var i = pos+dir
var len = string_length(str)
while 1 <= i and i <= len and not string_pos(string_char_at(str, i), chars)
{
	i += dir
}

//if i > len return 0
return i
}