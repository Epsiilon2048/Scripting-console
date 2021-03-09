
function array_sever(array, pos, str){

var _str = is_array(str) ? str : [str]

var split = string_split_multiple(_str, array[pos])
array_delete(array, pos, 1)
array_insert_array(array, pos, split)
return array
}