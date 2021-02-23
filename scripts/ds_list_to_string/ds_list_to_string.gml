
function ds_list_to_string(ds_list, separator){

var str = ""

for(var i = 0; i <= ds_list_size(ds_list)-1; i++)
{
	str += separator+string(ds_list_find_value(ds_list, i))
}
return str
}