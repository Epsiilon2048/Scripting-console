
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




function struct_clear(struct){

var names = variable_struct_get_names(struct)
var name_count = array_length(names)

for(var i = 0; i <= name_count-1; i++)
{
	struct[$ names[@ i]] = undefined
}
}




function struct_add(dest, src){
	
var names = variable_struct_get_names(src)
var name_count = array_length(names)

for(var i = 0; i <= name_count-1; i++)
{
	dest[$ names[@ i]] = src[$ names[@ i]]
}
}


function struct_replace(dest, src){
	
var names = variable_struct_get_names(src)
var name_count = array_length(names)

for(var i = 0; i <= name_count-1; i++)
{
	var value = dest[$ names[@ i]]
	
	if is_method(value) continue
	if is_struct(value) dest[$ names[@ i]] = struct_copy( src[$ names[@ i]] )
	else dest[$ names[@ i]] = src[$ names[@ i]]
}
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