
function array_struct_get(array, name){

var _array = array_create(array_length(array), undefined)

for(var i = 0; i <= array_length(array)-1; i++)
{
	_array[i] = variable_struct_exists_get(array[i], name, undefined)
}

return _array
}