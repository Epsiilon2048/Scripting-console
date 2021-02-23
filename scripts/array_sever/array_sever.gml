// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function array_sever(array, pos, str){

if not is_array(str) str = [str]

var split = string_split_multiple(str, array[pos])
array_delete(array, pos, 1)
array_insert_array(array, pos, split)
return array
}