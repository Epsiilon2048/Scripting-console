
function add_element(element){

if not variable_struct_exists(element, "id")
{
	if not variable_struct_exists(element, "name")
	{
		element.id = instanceof(element)
		if element.id == "struct" element.id = "Element"
	}
	else element.id = element.name
}

element.id = string_replace_all(element.id, " ", "_")

var _id = element.id
var i = 1
while variable_struct_exists(e, _id) _id = element.id+string(i++)
element.id = _id

e[$ element.id] = element
}



function add_console_element(element){ with o_console {

add_element(element)
ds_list_add(elements, element)
}}