
function Autofill_item(item_text, type_text, color) constructor {

name = item_text
type = type_text
self.color = color
}



function Console_autofill_list() constructor{

initialize = function(){

list = ds_list_create()
}



set = function(list){
	
}



set_multiple = function(lists){

for(var i = 0; i <= array_length(lists)-1; i++)
{
	if is_array(lists[i]) for(var j = 0; j <= array_length(lists[i])-1; j++)
	{
		ds_list_add(list, lists[@ i, j])
	}
	else if is_numeric(lists[i]) for(var j = 0; j <= ds_list_size(lists[i])-1; j++)
	{
		ds_list_add(list, lists[@ i][| j])
	}
	else ds_list_add(list, lists[i])
}
}



destroy = function(){
	
if ds_exists(ds_type_list, list) ds_list_destroy(list)
}
}