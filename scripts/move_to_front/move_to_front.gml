
function move_to_front(element, allow_recursion=true){ with o_console {

element.is_front = true

ds_list_delete(elements, ds_list_find_index(elements, element))
ds_list_insert(elements, 0, element)


if allow_recursion
{
	if element == OUTPUT move_to_front(OUTPUT.dock, false)
	else if element == OUTPUT.dock move_to_front(OUTPUT, false)
}
}}