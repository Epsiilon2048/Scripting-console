
function string_is_int(str){

var _str = str
if string_pos("-", _str) == 1 _str = string_delete(_str, 1, 1)

if _str == "" return false	

if string_pos("0x", _str) == 1
{
	_str = string_delete(_str, 1, 2)
	
	if hex_to_dec(_str) >= 0 return true
	else					 return false
}

if string_digits(_str) == _str return true
else						   return false
}




function string_is_float(str){

if string_pos(".-", str) == 1 return false

var _str = str
if string_pos(".", str) != 0 
{
	if string_pos(".0x", _str) or string_pos("0.x", _str) return false
	
	_str = string_delete( _str, string_pos(".", _str), 1 )
}

return string_is_int(_str)
}




function string_format_float(float){

var decimal = float - floor(float)
var whole = floor(float)

if decimal == 0 return string(float)
else return stitch(whole, shave("0", string_format(decimal, 0, 6)))
}