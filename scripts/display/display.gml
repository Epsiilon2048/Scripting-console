
function display(variable, step){ with o_console {

if is_undefined(variable)
{	
	if variable_struct_names_count(DISPLAY) == 0 
	{
		initialize_variable_display()
		return "Initialized display"
	}
	else
	{
		var o
		
		DISPLAY.enabled = not DISPLAY.enabled
		
		if not DISPLAY.enabled	o = "Hid display dock"
		else					o = "Enabled display dock"
		
		return new element_container(new_embedded_text([o+" (",{s: "undo", func: display, outp: true},")"]))
	}
}
else
{
	var t = new_text_box(variable, variable)
	t.instant_update = true
	t.att.allow_input = false

	add_console_element(t)
}
}}



function add_textbox(name, variable){

if is_undefined(variable) variable = name

var t = new_text_box(name, variable)
t.instant_update = true
add_console_element(t)
}



function add_scrubber(name, variable, step, px_per_step){

// WOW this is bad lolll
if is_undefined(variable)
{
	variable = name
}
else if is_numeric(variable) 
{
	variable = name
	step = variable
	px_per_step = step
}

var t = new_scrubber(variable, variable, step)
t.instant_update = true
if not is_undefined(px_per_step) t.att.scrubber_pixels_per_step = px_per_step
add_console_element(t)
}



function add_colorbox(name, variable){

if is_undefined(variable) variable = name

var t = new_color_box(name, variable)
add_console_element(t)
}
