
function better_script_exists(ind){

return 0 <= ind and ind <= 0xfffffffb and script_get_name(ind) != "<unknown>" and script_get_name(ind) != "<undefined>"
}

function better_instance_exists(obj) {

return obj < 0xfffffffb and instance_exists(obj)
}

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

if ds_list_find_index(console_macro_order, name) == -1 ds_list_file(console_macro_order, name)
}}

function console_macro_add_builtin(criteria){ with o_console {

if is_undefined(criteria) criteria = ""

for(var i = 0; i <= 10000; i++)
{
	var name = script_get_name(i)
	
	if	script_exists(i) and 
		not string_pos("@", name) and
		not string_pos("$", name) and
		string_pos("YoYo", name) != 1
	{	
		var excluded = false
		
		if criteria != "" 
		{
			if string_pos(criteria, name) != 1 excluded = true
		}
		else for(var j = 0; j <= array_length(builtin_exclude)-1; j++)
		{
			if string_pos(builtin_exclude[j]+"_", name) == 1 
			{
				excluded = true
				break
			}
		}
		
		if not excluded console_macro_add(name, dt_method, i)
	}
}
}}