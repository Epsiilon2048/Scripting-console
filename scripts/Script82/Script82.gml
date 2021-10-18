
function display(variable, step){

if is_undefined(variable)
{
	o_console.DISPLAY.enabled = not o_console.DISPLAY.enabled
}
else
{
	var t = new_text_box(variable, variable)
	t.instant_update = true
	t.att.allow_input = false

	add_console_element(t)
}
}

function add_textbox(name, variable){

if is_undefined(variable) variable = name

var t = new_text_box(name, variable)
t.instant_update = true
add_console_element(t)
}

function add_scrubber(variable, step, px_per_step){

var t = new_scrubber(variable, variable, step)
t.instant_update = true
if not is_undefined(px_per_step) t.att.scrubber_pixels_per_step = px_per_step
add_console_element(t)
}