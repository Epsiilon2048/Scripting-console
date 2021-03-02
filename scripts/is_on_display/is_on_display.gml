// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function is_on_display(variable){

for(var i = 0; i <= ds_list_size(display_list)-1; i++)
{
	if display_list[| i].variable == variable
	{
		return i
	}
}
return -1
}