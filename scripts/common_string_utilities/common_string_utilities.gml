
function shave(substr, str){ //removes substr from the ends of str

var output = str

while string_char_at(output, 1) == substr
{
	output = string_delete(output, 1, 1)
}

while string_char_at(output, string_length(output)) == substr
{
	output = string_delete(output, string_length(output), 1)
}
return output
}




function stitch(){ //combines args into a string
	
var str = ""

for( var i = 0; i <= argument_count-1; i++ )
{
	str += string(argument[i])
}

return str
}
	
	

	
function string_split(substr, str){ //splits a string into an array by a separator

static split = ds_list_create()

var pos = string_pos(substr, str)
if not pos return [str]

var marker = 1
var substrlen = string_length(substr)

ds_list_clear(split)

if substrlen while pos
{	
	var item = string_copy(str, marker, pos - marker)
	
    ds_list_add(split, item)
	
    marker = pos + substrlen
    pos = string_pos_ext(substr, str, marker)
}
ds_list_add(split, string_delete(str, 1, marker - 1))

return ds_list_to_array(split)
}




function string_split_keep(substr, str){ //splits a string into an array by a separator, but keeping it

var list = array_create(string_count(substr, str), "")
var len = string_length(substr)

var i = 0; while str != ""
{
	if string_pos(substr, str) != 0 
	{
		list[i] = string_copy(str, 1, string_pos(substr, str)+len-1)
		str = string_delete(str, 1, string_pos(substr, str)+len-1)
	}
	else
	{
		list[i] = str
		str = ""
	}
	
	i++
}
return list
}
	
	
	
	
function string_is_int(str){ //returns true if a string is a base10 or base16 integer

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




function string_is_float(str){ //returns true if a string is a base10 or base16 float

if string_pos(".-", str) == 1 return false

var _str = str
if string_pos(".", str) != 0 
{
	if string_pos(".0x", _str) or string_pos("0.x", _str) return false
	
	_str = string_delete( _str, string_pos(".", _str), 1 )
}

return string_is_int(_str)
}




function string_format_float(float){ //formats a float into a string, rounding to the 10^6 place (rather than 100s place)

var decimal = float - floor(float)
var whole = floor(float)

if decimal == 0 return string(float)
else return stitch(whole, shave("0", string_format(decimal, 0, 6)))
}




function string_pos_index(substr, str, index){ //returns the nth instance of the substr in the str

var pos = string_pos(substr, str)
if not (pos or index) return 0

repeat index-1
{
	pos = string_pos_ext(substr, str, pos)
	if not pos return 0
}

return pos
}



	
function string_pop(str){ //returns the last character of a string
return string_char_at(str, string_length(str))
}