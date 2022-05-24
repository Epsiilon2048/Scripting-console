
function element_dock_update(){ with o_console {

var element_list = variable_struct_get_names(e)

var elements = []

for(var i = 0; i <= array_length(element_list)-1; i++)
{
	var name = element_list[i]
	var el = e[$ name]

	if el == BAR or el == element_dock
	{
		continue
	}
	
	var instname = instanceof(el)
	if string_pos("Console_", instname) == 1
	{
		instname = slice(instname, 9)
		instname = string_capitalize(instname)
	}
	instname = string_replace_all(instname, "_", " ")
	
	array_push(elements, [
		new_cd_checkbox("", "o_console.e."+name+".enabled"),
		new_cd_text(instname, "body_accent"),
		string_replace_all(name, "_", " "),
	])
}

element_dock.set(elements)
}}