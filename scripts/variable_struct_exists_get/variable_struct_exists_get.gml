// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function variable_struct_exists_get(struct, variable, not_exists){

if is_struct(struct) and variable_struct_exists(struct, variable)
{
	return variable_struct_get(struct, variable)
}
else
{
	return not_exists
}
}