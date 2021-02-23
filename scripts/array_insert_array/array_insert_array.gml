// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function array_insert_array(array, index, values){

show_message(array)

for(var i = 0; i <= array_length(values)-1; i++)
{
	array_insert(array, index+i, values[i])
}

show_message(array)
}