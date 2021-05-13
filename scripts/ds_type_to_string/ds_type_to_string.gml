
function ds_type_to_string(ds_type){

switch ds_type
{
case ds_type_grid:		return "grid"
case ds_type_list:		return "list"
case ds_type_map:		return "map"
case ds_type_priority:	return "priority"
case ds_type_queue:		return "queue"
case ds_type_stack:		return "stack"
}
}