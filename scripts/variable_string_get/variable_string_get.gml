
function variable_string_get(str){

var list = string_split(".", str)
var object

if string_is_int(list[0])	object = real(list[0])
else						object = asset_get_index(list[0])

var value = variable_instance_get( object, list[1] )

for(var i = 2; i <= array_length(list)-1; i++)
{
	value = variable_struct_get(value, list[i])
}

return value
}