// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function display_all(obj, toggle){

if is_undefined(obj) obj = object
var list = variable_instance_get_names(obj)
array_sort(list, true)

for(var i = 0; i <= array_length(list)-1; i++)
{
	display(object_get_name(obj)+"."+list[i], toggle)
}
return "Displaying all variables in "+object_get_name(obj)
}