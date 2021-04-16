
function display(variable, toggle){ with o_console {

var _variable = variable

if is_undefined(_variable)
{
	if ds_list_size(display_list) == 0
	{
		return "Nothing to display!"
	}
	else
	{
		Display.enabled = not Display.enabled
		return "Display toggled"	
	}
}

_variable = string_add_scope(_variable)

if is_undefined(_variable)
{
	return "Missing variable scope"
}

var var_split = string_split(".", _variable)
var obj = var_split[0]
var firstscope = var_split[1]
var currently_displayed = is_on_display(_variable)

if obj == string(o_console.id) and firstscope == "Display"
{
	return "Not sure displaying the Display with the Display is a good idea..."
	//later: add a blacklist of variables instead of just removing the entire display
}

var displaying = toggle

if not is_undefined(toggle)
{
	if currently_displayed != -1 and toggle
	{
		return "That's already on the display!"
	}

	else if currently_displayed == -1 and not toggle
	{
		return "That wasn't on the display in the first place!"
	}
}

else displaying = (not run_in_console) or (currently_displayed == -1)

if displaying
{
	if is_undefined(toggle) and not variable_string_exists(_variable)
	{
		return "\""+variable+"\" does not exist"
	}
	else
	{
		ds_list_add(display_list, {variable: _variable})
		return "Added "+variable+" to the Display"
	}
}
else
{
	ds_list_delete( display_list, currently_displayed )
	return "Removed "+variable+" from the Display"
}
}}




function display_all(obj, toggle){ with o_console {

if is_undefined(obj) obj = object
var list = variable_instance_get_names(obj)
array_sort(list, true)

for(var i = 0; i <= array_length(list)-1; i++)
{
	display(string(obj)+"."+list[i], toggle)
}
return "Displaying all variables in "+object_get_name(obj)
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

if is_undefined(text)
{
	Window.enabled = not Window.enabled
	return "Window toggled"
}

var _text
if variable_struct_exists(text, "o")
{
	_text = text.o
}
else if is_array(text)
{
	if array_length(text) == 1 _text = text[0]
	if is_array(text) _text = array_to_string(text, "\n")
}
else _text = string(text)

Window.set(_text)
Window.enabled = true
Window.show = true

window_reset_pos()

return "Set window text"
}}




function window_reset_pos(){ with o_console {

Window.reset_pos()
Window.enabled = true
Window.show = true

return "Window position reset"
}}