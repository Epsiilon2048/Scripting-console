
function variable_string_get_scope(str, add_macro){
	
if not is_string(str) or not string_pos(str, ".") return undefined

var scope = string_copy(str, 1, string_last_pos(".", str)-1)

if string_pos(".", scope) return variable_string_get(scope)
else return string_to_instance(scope, add_macro)
}


function variable_string_get_last(str){

if not is_string(str) or not string_pos(str, ".") return undefined

return string_copy(str, string_pos(str, ".")+1, string_length(str))
}


function variable_struct_exists_get(struct, variable, not_exists){ //if a variable in a struct exists return the variable, otherwise return the not_exists value

if is_struct(struct) and variable_struct_exists(struct, variable) return variable_struct_get(struct, variable)
else return not_exists
}