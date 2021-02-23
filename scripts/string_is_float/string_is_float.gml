
function string_is_float(str){
//must manually check the first char; for some reason real() throws an error
//if just the first character isnt a number
if is_string(str)
{
var acceptable = "-0123456789"

var _str = shave("-", shave("0", string_delete(str, string_pos(".", str), 1)))

if (
	string_pos(string_char_at(_str, 1), acceptable) != 0 and
	string_pos(".", _str) == 0 and
	( string( real( _str ) ) == _str)
) {
    return true
} else {
    return false
}}
else return false
}