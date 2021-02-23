
function ds_list_to_array(ds_list){

var array = []

for(var i = 0; i <= ds_list_size(ds_list)-1; i++)
{
	array[i] = ds_list_find_value(ds_list, i)
}
return array
}