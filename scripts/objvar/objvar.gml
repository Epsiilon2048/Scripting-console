// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function objvar(obj){

if is_undefined(obj) obj = object
var list = variable_instance_get_names(obj)
array_sort(list, true)

for(var i = 0; i <= array_length(list)-1; i++)
{
	list[i] = {str: list[i]+"\n", scr: display, arg: object_get_name(obj.object_index)+"."+list[i]}
}

list[array_length(list)] = "\nClick on a variable to add to the display"
o_console.Output.embedding = true
return list
}