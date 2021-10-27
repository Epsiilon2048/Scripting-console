
function string_width_oneline(str){

if o_console.consistent_spacing
{
	return string_length(str)*string_width("W")
}
else
{
	return string_width(str)
}
}