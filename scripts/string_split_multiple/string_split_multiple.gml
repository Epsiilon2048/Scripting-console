
function string_split_multiple(substrs, str){
//DOES NOT SUPPORT MULTI CHARACTER SUBSTRS

var list = []

var len = 1

while str != ""
{
	if string_pos_multiple(substrs, str) != 0 {
		list[array_length(list)] = string_copy(str, 1, string_pos_multiple(substrs, str)-1)
		str = string_delete(str, 1, string_pos_multiple(substrs, str)+len-1)
	}
	else {
		list[array_length(list)] = str
		str = ""
	}
}
return list
}