function remove_console_element(element){ with o_console {

static bad = "You're trying to remove WHAT console element exactly??"

if is_numeric(element)
{
	if element < 0 or element >= ds_list_size(elements)
	{
		throw(bad)
	}
	
	element = elements[| element]
}
else if is_string(element)
{
	if not variable_struct_exists(e, element)
	{
		throw(bad)
	}
	
	element = e[$ element]
}
else if not is_struct(element)
{
	throw(bad)
}


if element == BAR or element == OUTPUT or (initialized and (element == BAR.dock or element == OUTPUT.dock))
{
	show_debug_message("Attempted to remove crucial console element! Don't do that maybe!!")
	exit
}

ds_list_delete(elements, ds_list_find_index(elements, element))

if variable_struct_exists(element, "id") variable_struct_remove(e, element.id)

element_dock_update()
}}