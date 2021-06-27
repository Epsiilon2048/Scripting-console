
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




function string_format_float(float, places){ //formats a float into a string, rounding to the 10^6 place (rather than 100s place)

if is_undefined(places) places = 6

var decimal = float - floor(float)
var whole = floor(float)

if decimal == 0 return string(float)
else return stitch(whole, shave("0", string_format(decimal, 0, places)))
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



	
function string_last(str){ //returns the last character of a string
return string_char_at(str, string_length(str))
}




function first_is_digit(str){

var char = string_char_at(str, 1)

if char == "-" char = string_char_at(str, 2)

return ( string_digits(char) == char )
}
	
	
	
	
function bm_to_string(blendmode){
	
switch blendmode
{
case bm_normal:			return "bm_normal"
case bm_add:			return "bm_add"
case bm_subtract:		return "bm_subtract"
case bm_max:			return "bm_max"
case bm_dest_alpha:		return "bm_dest_alpha"
case bm_dest_color:		return "bm_dest_color"
case bm_inv_dest_alpha:	return "bm_inv_dest_alpha"
case bm_inv_dest_color:	return "bm_inv_dest_color"
case bm_src_alpha:		return "bm_src_alpha"
case bm_src_alpha_sat:	return "bm_src_alpha_sat"
case bm_inv_src_alpha:	return "bm_inv_src_alpha"
case bm_inv_src_color:	return "bm_inv_src_color"
}

return "<unknown>"
}