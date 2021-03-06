
function string_is_int(str){

if is_string(str)
{
var acceptable = "-0123456789"

var _str = shave("0", shave("-", str))

if shave("-", str) == "" return false
if str != "" and _str == "" _str = "0"

if (
	string_pos(string_char_at(str, 1), acceptable) != 0 and
	string_pos(".", _str) == 0 and
	( string( real( _str ) ) == string( _str ) )
) {
    return true
} else {
    return false
}}
else return false
}