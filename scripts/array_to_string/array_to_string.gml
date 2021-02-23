// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function array_to_string(array, separator){

if is_string(array) return array

var str = ""
var add = ""

for(var i = 0; i <= array_length(array)-1; i++)
{
	//if is_real(array[i]) array[i] = string_format_float(array[i])

	add = string(array[i])
	
	str += separator + add
}
return string_copy(str, string_length(separator)+1, string_length(str)-1)
}