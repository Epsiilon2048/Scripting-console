
function string_is_int(str){
//must manually check the first char; for some reason real() throws an error
//if just the first character isnt a number
if is_string(str)
{
var acceptable = "-0123456789"

if (
	string_pos(string_char_at(str, 1), acceptable) != 0 and
	string_pos(".", str) == 0 and
	( string( real( str ) ) == string( str ) )
) {
    return true
} else {
    return false
}}
else return false
}