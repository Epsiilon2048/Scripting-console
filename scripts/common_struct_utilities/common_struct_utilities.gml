
function struct_copy(struct){

var names = variable_struct_get_names(struct)
var name_count = array_length(names)

var new_struct = {}

for(var i = 0; i <= name_count-1; i++)
{
	new_struct[$ names[@ i]] = struct[$ names[@ i]]
}

return new_struct
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