function Variable_container() constructor{
	
initialize = function(){
	
	variable = undefined	// Variable name
	scope = undefined		// Variable scope
	address = ""			// String address to get the variable scope
	
	value = undefined		// Value from the last time the variable was requested
	exists = false			// If the variable exists at the index
	can_exist = false		// If the formatting is such that the variable even *can* exist
	
	ds_type = undefined		// The type of DS the variable is (if it is one)
	ds_type_implied = false	// If there is no DS accessor
	index_address = ""
	index = undefined		// The index to access the array or DS from
	index2 = undefined		// For DS grids
}

set_with_string = function(variable){
	initialize()
	
}

set = function(scope, variable, index, ds_type){
	initialize()
	
	self.scope = scope
	self.variable = variable
	self.index = index
	self.ds_type = ds_type
}

get_exists = function(){
	
	if not can_exist return false
	
	get()
	return value
}

set_index = function(index_x, index_y){
	index = index_x
	index2 = index_y
}

get_index = function(){
	index = variable_string_get(index_address)
	return index
}

get = function(){
	
	exists = variable_struct_exists(scope, variable)
	value = exists ? variable_struct_get(scope, variable) : undefined
	
	if not exists or is_undefined(index) return value
	
	switch ds_type
	{
	default:
		if not is_array(value) or index >= array_length(value)
		{
			value = undefined
			exists = false
			return value
		}
		exists = true
		value = value[@ index]
		return value
		
	case ds_type_list:
		exists = ds_exists(value, ds_type_list) and index >= ds_list_size(value)
		value = value[| index]
		return value
	case ds_type_map:
		exists = ds_exists(value, ds_type_map) and ds_map_exists(value, index)
		value = value[? index]
		return value
	case ds_type_grid:
		exists = not is_undefined(index) and not is_undefined(index2) and ds_exists(value, ds_type_grid) and ds_grid_width(value) > index and ds_grid_height(value) > index2
		value = value[# index, index2]
		return value
	}
}

refresh_scope = function(){
	
	
}

get_from_address = function(){
	refresh_scope()
	return get()
}
}