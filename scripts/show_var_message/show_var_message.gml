// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function show_var_message(){

var str = ""

for(var i = 0; i <= argument_count-1; i++)
{
	str += stitch(argument[i]+"  ",variable_instance_get(object_index, argument[i]),"\n")
}
show_message(str)
}