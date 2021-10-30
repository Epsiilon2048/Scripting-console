
function move_to_front(element){ with o_console {

if instanceof(element) == "Console_dock" is_front = true

for(var i = 0; i <= ds_list_size(elements)-1; i++)
{
	if elements[| i] == element
	{
		break
	}
}

ds_list_delete(elements, i)
ds_list_insert(elements, 0, element)
}}