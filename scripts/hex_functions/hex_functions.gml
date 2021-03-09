
function dec_to_hex(dec, len){
/// GMLscripts.com/license

// Slightly modified for compatibility with GM 2.3 as well as formatting consistency
// https://www.gmlscripts.com/script/dec_to_hex

var _dec = dec
var _len = is_undefined(len) ? len : 1

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

function hex_to_dec(hex){
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

function rgb_to_hex(r,g,b){
/// GMLscripts.com/license

// Slightly modified for compatibility with GM 2.3 as well as formatting consistency
// https://www.gmlscripts.com/script/rgb_to_hex

var _r = r & 255
var _g = r & 255
var _b = r & 255
return dec_to_hex(_r << 16 | _g << 8 | _b)
}