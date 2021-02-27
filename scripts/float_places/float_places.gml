
function float_places(value){
//bad
var _value = string_format_float(value)

if string_pos(".", _value) == 0 return 0

var places = string_length(_value)-string_pos(".", _value)

return places
}