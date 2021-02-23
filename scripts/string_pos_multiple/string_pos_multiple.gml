// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function string_pos_multiple(substrs, str){

var bestpos = string_length(str)+1

for(var i = 0; i <= array_length(substrs)-1; i++)
{
	var pos = string_pos(substrs[i], str)
	
	if pos != 0 and pos < bestpos
	{
		bestpos = pos
	}
}
if bestpos == string_length(str)+1 
{
	return 0
}
else return bestpos
}