
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