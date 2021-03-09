
function variable_string_exists(str){

if not is_string(str) return undefined

var list = string_split(".", str)
var object

var asset = asset_get_index(list[0])

if string_is_int(list[0])
{
	var r = real(list[0])
	
	if r == global object = global
	else if object_exists(r) object = asset.id
	else if instance_exists(r) object = r
	else return false
}
else
{
	if list[0] == "global" object = global
	else if instance_exists(asset) object = asset.id
	else return false
}

if array_length(list) < 2 return false

var variable = variable_instance_get( object, list[1] )

if is_undefined( variable ) return false

for(var i = 2; i <= array_length(list)-1; i++)
{
	if not variable_struct_exists(variable, list[i]) return false
	variable = variable_struct_get(variable, list[i])
}

return true
}




function variable_string_get(str){

if not is_string(str) return undefined

var list = string_split(".", str)
var object = -1

var asset = asset_get_index(list[0])

if string_is_int(list[0])
{
	var r = real(list[0])
	
	if r == global object = global
	else if object_exists(r) object = asset.id
	else if instance_exists(r) object = r
}
else
{
	if list[0] == "global" object = global
	else if instance_exists(asset) object = asset.id
}

if object == -1 return undefined

var value = variable_instance_get( object, list[min(1, array_length(list)-1)] )

for(var i = 2; i <= array_length(list)-1; i++)
{
	if is_struct(value) value = variable_struct_get(value, list[i])
}

return value
}



function variable_string_set(str, val){

if not is_string(str) return undefined

var list = string_split(".", str)
var lenlist = array_length(list)
var object = -1

var asset = asset_get_index(list[0])

if string_is_int(list[0])
{
	var r = real(list[0])
	
	if r == global object = global
	else if object_exists(r) object = asset.id
	else if instance_exists(r) object = r
}
else
{

	if list[0] == "global" object = global
	else if instance_exists(asset) object = asset.id
}

if object == -1 return undefined

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