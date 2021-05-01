
function array_struct_get(array, name){

var _array = array_create(array_length(array), undefined)

for(var i = 0; i <= array_length(array)-1; i++)
{
	_array[i] = variable_struct_exists_get(array[i], name, undefined)
}

return _array
}
	
	
	
	
function array_to_string(array, separator){

if is_string(array) return array

var str = ""
var add = ""

for(var i = 0; i <= array_length(array)-1; i++)
{
	//if is_real(array[i]) array[i] = string_format_float(array[i])

	add = string(array[i])
	
	str += separator + add
}
return string_copy(str, string_length(separator)+1, string_length(str)-1)
}
	
	
	
	
function ds_list_to_array(ds_list){

var array = array_create(ds_list_size(ds_list))

for(var i = 0; i <= ds_list_size(ds_list)-1; i++)
{
	array[@ i] = ds_list[| i]
}
return array
}




function ds_map_to_struct(ds_map){

var struct = {}
var keys = ds_map_keys_to_array(ds_map)

for(var i = 0; i <= ds_map_size(ds_map)-1; i++)
{
	struct[$ keys[@ i]] = ds_map[? keys[@ i]]
}
return struct
}