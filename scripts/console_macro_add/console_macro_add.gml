
function ds_list_file(id, value){

for(var i = 0; i <= ds_list_size(id)-1; i++)
{
	var item = id[| i]

	if value == item break
	
	var j = 1; while string_char_at(item, j) == string_char_at(value, j)
	{
		j++
	}
	
	if ord( string_char_at(value, j) ) < ord( string_char_at(item, j) )
	{
		break
	}
}

ds_list_insert(id, i, value)
}




function console_macro_add(name, type, value){ with o_console {

console_macros[$ name] = {type: type, value: value}

if ds_list_find_index(macro_list, name) == -1 ds_list_file(macro_list, name)
}}



function index_functions(){

var i = 100001
while script_exists(i)
{
	var name = script_get_name(i++)
	
	if not string_pos("___struct___", name) == 1
	ds_list_add(method_list, name)
}

ds_list_sort(method_list, true)
}



function console_macro_add_builtin(criteria){ with o_console {

if is_undefined(criteria) criteria = ""

var added = 0

for(var i = 0; i <= 10000; i++)
{
	var name = script_get_name(i)
	
	if script_exists(i)
	{	
		var excluded = false
		
		if criteria != "" 
		{
			if string_pos(criteria, name) != 1 excluded = true
		}
		else for(var j = 0; j <= array_length(builtin_exclude)-1; j++)
		{
			if string_pos(builtin_exclude[j], name) == 1 
			{
				excluded = true
				break
			}
		}
		
		if not excluded 
		{
			console_macro_add(name, dt_method, i)
			added ++
		}
	}
}

return "Added "+string(added)+" builtin function"+((added == 1) ? "" : "s")
}}