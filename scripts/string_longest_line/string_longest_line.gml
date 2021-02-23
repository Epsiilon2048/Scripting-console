// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function string_longest_line(str){

var bestline = 0
var str_split = string_split("\n", str)

for(var i = 0; i <= array_length(str_split)-1; i++)
{
	var len = string_length(str_split[i])
	
	if len > bestline bestline = len
}
return bestline
}