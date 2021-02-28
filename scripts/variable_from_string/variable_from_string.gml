
function variable_string_exists(str){

var list = string_split(".", str)
var object

if string_is_int(list[0])
{
	var r = real(list[0])
	
	if object_exists(r) object = asset.id
	else if instance_exists(r) object = r
	else return false
}
else
{
	var asset = asset_get_index(list[0])
	if instance_exists(asset) object = asset.id
	else return false
}

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



function variable_string_get(str){

var list = string_split(".", str)
var object

if string_is_int(list[0])
{
	var r = real(list[0])
	
	if object_exists(r) object = asset.id
	else if instance_exists(r) object = r
}
else
{
	var asset = asset_get_index(list[0])
	if instance_exists(asset) object = asset.id
}

var value = variable_instance_get( object, list[1] )

for(var i = 2; i <= array_length(list)-1; i++)
{
	value = variable_struct_get(value, list[i])
}

return value
}



function variable_string_set(str, val){

var list = string_split(".", str)
var lenlist = array_length(list)
var object

if string_is_int(list[0])
{
	var r = real(list[0])
	
	if object_exists(r) object = asset.id
	else if instance_exists(r) object = r
}
else
{
	var asset = asset_get_index(list[0])
	if instance_exists(asset) object = asset.id
}

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