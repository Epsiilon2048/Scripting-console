// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function ds_list_compare(ds_list1, ds_list2, value1, value2){

var ds1 = ds_list_create()
var ds2 = ds_list_create()

ds_list_copy(ds1, ds_list1)
ds_list_copy(ds2, ds_list2)

var ds_pos = -1

while ds_list_find_index(ds1, value1) != -1
{
	var ds1_index = ds_list_find_index(ds1, value1)
	ds_pos += ds1_index + 1
	
	if ds_list_find_value(ds2, ds1_index) == value2
	{
		return ds_pos
	}
	else
	{
		ds_list_delete(ds1, ds1_index)
		ds_list_delete(ds2, ds1_index)
	}
}
return -1
}