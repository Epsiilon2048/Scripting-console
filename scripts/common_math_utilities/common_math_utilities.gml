
function signbool(bool){ //formats a bool to be -1 if false
return -(sign(bool) == 0) + sign(bool)
}
	
	
	
	
function color_add_hue(col, add){ //returns a color with added hue

return make_color_hsv(
	color_get_hue(col)+add, 
	color_get_saturation(col),
	color_get_value(col)
)
}
	

	
function color_add_hsv(col, hue, saturation, value){ //returns a color with added hue

if is_undefined(hue) hue = 0
if is_undefined(saturation) saturation = 0
if is_undefined(value) value = 0

return make_color_hsv(
	color_get_hue(col)+hue, 
	color_get_saturation(col)+saturation,
	color_get_value(col)+value
)
}
	

function color_set_hsv(col, hue, saturation, value){ //returns a color with added hue

if is_undefined(hue) hue = color_get_hue(col)
if is_undefined(saturation) saturation = color_get_saturation(col)
if is_undefined(value) value = color_get_value(col)

return make_color_hsv(
	hue, 
	saturation,
	value
)
}
	
	
	
function dec_to_hex(dec, len){ //converts base10 to base16
/// GMLscripts.com/license

// Slightly modified for compatibility with GM 2.3 as well as formatting consistency
// https://www.gmlscripts.com/script/dec_to_hex

var _dec = dec
var _len = is_undefined(len) ? 1 : len

var hex = ""
 
if _dec < 0
{
    _len = max(_len, ceil( logn( 16, 2*abs(_dec) ) ) )
}
 
var dig = "0123456789ABCDEF"
while _len-- or _dec 
{
    hex = string_char_at(dig, (_dec & $F) + 1) + hex
    _dec = _dec >> 4;
}
 
return hex;
}




function hex_to_dec(hex){ //converts base16 to base10
/// GMLscripts.com/license

// Slightly modified for compatibility with GM 2.3 as well as formatting consistency
// https://www.gmlscripts.com/script/hex_to_dec


var _hex = string_upper(hex)
var dec = 0
h = "0123456789ABCDEF"
for (var p = 1; p <= string_length(_hex); p++)
{
    dec = dec << 4 | (string_pos( string_char_at(_hex, p), h ) - 1)
}
return dec
}




function rgb_to_hex(r, g, b){ //converts rgb to hex
/// GMLscripts.com/license

// Slightly modified for compatibility with GM 2.3 as well as formatting consistency
// https://www.gmlscripts.com/script/rgb_to_hex

var _r = r & 255
var _g = r & 255
var _b = r & 255
return dec_to_hex(_r << 16 | _g << 8 | _b, 1)
}
	
	
	

function hex_to_color(hex){

var _hex

if is_string(hex)
{
	_hex = string(hex)
	if slice(_hex, 1, 3, 1) == "0x" _hex = slice(_hex, 3, -1, 1)
}
else if is_real(hex) _hex = dec_to_hex(hex, 6)

return hex_to_dec( string_copy(_hex, 5, 2)+string_copy(_hex, 3, 2)+string_copy(_hex, 1, 2), 6 )
}
	
	
	
	
function color_to_hex(color){

var hex = dec_to_hex(color, 6)

return string_copy(hex, 5, 2)+string_copy(hex, 3, 2)+string_copy(hex, 1, 2)
}