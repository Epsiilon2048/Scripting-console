
function variable_string_exists(str){

var list = string_split(".", str)
var object

if string_is_int(list[0])	object = real(list[0])
else						object = asset_get_index(list[0])

if array_length(list) < 2 return false
if not variable_instance_exists( object, list[1] ) return false

var variable = variable_instance_get( asset_get_index(list[0]), list[1] )

for(var i = 2; i <= array_length(list)-1; i++)
{
	if not variable_struct_exists(variable, list[i]) return false
	variable = variable_struct_get(variable, list[i])
}

return true
}