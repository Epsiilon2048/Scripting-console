
function float_fill_places(value, places){

var _value = string_format_float(value)

var curplaces

if string_pos(".", _value) == 0 
{
	curplaces = -1
	_value += "."
}
else
{
	curplaces = string_length(_value)-string_pos(".", _value)
}

if places == curplaces return _value

return _value + string_mult("0", places-curplaces-1)
}