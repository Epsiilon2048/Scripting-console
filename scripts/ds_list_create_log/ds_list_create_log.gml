
function ds_create(ds_type, name, description, w, h){

var ind = -1

switch ds_type
{
	case ds_type_grid:		ind = ds_grid_create(w, h)
	break
	case ds_type_list:		ind = ds_list_create()
	break
	case ds_type_map:		ind = ds_map_create()
	break
	case ds_type_priority:	ind = ds_priority_create()
	break
	case ds_type_queue:		ind = ds_queue_create()
	break
	case ds_type_stack:		ind = ds_stack_create()
}

if not is_undefined(name)
{	
	if not string_pos(".", name) name = string(id)+"."+name
	else name = string_scope_to_id(name, true)
	
	o_console.ds_types[? name] = ds_type
	o_console.ds_names[$ ds_type][@ ind] = {name: name, description: description}
}

return ind
}



function ds_destroy(ds_type, ind){

switch ds_type
{
	case ds_type_grid:		ds_grid_destroy(ind)
	break
	case ds_type_list:		ds_list_destroy(ind)
	break
	case ds_type_map:		ds_map_destroy(ind)
	break
	case ds_type_priority:	ds_priority_destroy(ind)
	break
	case ds_type_queue:		ds_queue_destroy(ind)
	break
	case ds_type_stack:		ds_stack_destroy(ind)
}

var name = o_console.ds_names[$ ds_type][@ ind].name
ds_map_delete(o_console.ds_types, name)
o_console.ds_names[$ ds_type][@ ind] = undefined
}



function ds_grid_create_log(name){

}
function ds_list_create_log(name){
	
}
function ds_map_create_log(name){
	
}
function ds_queue_create_log(name){
	
}
function ds_stack_create_log(name){
	
}
function ds_priority_create_log(name){
	
}