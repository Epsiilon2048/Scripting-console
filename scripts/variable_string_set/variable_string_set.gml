
function variable_string_set(str, val){

var list = string_split(".", str)
var lenlist = array_length(list)
var object

if string_is_int(list[0])	object = real(list[0])
else						object = asset_get_index(list[0])

if lenlist > 2
{
	var variable = variable_instance_get(object, list[1])
	
	for(var i = 1; i <= lenlist-3; i++)
	{
		variable = variable_struct_get(variable, list[i+1])
	}

	variable_struct_set(variable, list[lenlist-1], val)
}
else
{
	variable_instance_set(object, list[1], val)
}
}