// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function string_pos_index(substr, str, index){

var count = 0
for(var i = 1; i <= string_length(str); i++)
{
	if string_char_at(str, i) == substr
	{
		count ++
		if count == index return i
	}
}
return false
}