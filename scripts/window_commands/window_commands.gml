
function display_all(obj, toggle){ with o_console {

if is_undefined(obj) obj = object

var list

if is_string(obj)
{
	var inst = variable_string_get_scope(obj, true)
	
	if is_undefined(inst)
	{
		return "Variable does not exist"
	}
	else
	{
		var varstring = string_add_scope(obj)
		if is_undefined(varstring) return "Missing variable scope"
		
		obj = variable_string_get(varstring)
	}
	
}

var list = is_string(obj) ? variable_struct_get_names(obj) : variable_instance_get_names(obj)
array_sort(list, true)

for(var i = 0; i <= array_length(list)-1; i++)
{
	display(string(obj)+"."+list[i], toggle)
}
return "Displaying all variables in "+(is_numeric(obj) ? object_get_name(obj) : "struct")
}}




function display_clear(){ with o_console {
	
ds_list_clear(display_list)
display_reset_pos()
Display.toggle = false
return "Cleared display"
}}




function display_reset_pos(){ with o_console {

Display.reset_pos()
Display.enabled = true
Display.show = true

return "Display position reset"
}}




function window(text){ with o_console {
	
Window.set(text)
Window.enabled = true
Window.show = true

window_reset_pos()

return "Set window text"
}}



function window_set_output(){ with o_console {

window(OUTPUT.text)
output_set("Set window to output")
return "Set window to output"
}}



function window_reset_pos(){ with o_console {

Window.reset_pos()
Window.enabled = true
Window.show = true

return "Window position reset"
}}