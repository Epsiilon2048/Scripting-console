
function console_startup(){
// Put whatever in here, it's run at the end of the create event


var cd1 = new_console_dock("Docks", [
		new_cd_button("Hello world", show_debug_message),
		[new_scrubber("Outline", "con.DOCK.name_outline_width", .1)],
		["Border", new_scrubber("W", "con.DOCK.name_wdist", 1), new_scrubber("H", "con.DOCK.name_hdist", 1)],
		new_separator(),
		["Border", new_scrubber("W", "con.DOCK.element_wdist", 1),  new_scrubber("H", "con.DOCK.element_hdist", 1)],
		["Separation", new_scrubber("W", "con.DOCK.element_wsep", 1), new_scrubber("H", "con.DOCK.element_hsep", 1)],
		new_separator(),
		[new_scrubber("Base", "con.DOCK.dropdown_base", 1), new_scrubber("Hypotenuse", "con.DOCK.dropdown_hypotenuse", 1)],
		[new_scrubber("Border", "con.DOCK.dropdown_wdist", 1)],
])

add_console_element(cd1)

var cd1 = new_console_dock("Text box testing", [
		new_console_dock("Text boxes", [
			new_text_box("Text box", "o_console.tb"),
		]),
		new_console_dock("Scrubbers", [
			new_scrubber("Scrubber", "o_console.sc", 1),
			new_scrubber("Float scrubber", "o_console.sc", .1),
		]),
])

add_console_element(cd1)

var bar_dock = new Console_dock() with bar_dock
{
	initialize()
	name = "Command line"
	allow_element_dragging = false
	set([
		other.BAR
	])
}
bar_dock.enabled = false

var id_box = new_display_box("/ ID", "id", false)
var index_box = new_display_box("Object", "object_index", false)
id_box.att.select_all_on_click = true
index_box.att = id_box.att

var x_scrubber = new_scrubber("x", "x", 1)
var y_scrubber = new_scrubber("y", "y", 1)
x_scrubber.att.draw_box = false
y_scrubber.att = x_scrubber.att

var var_name_text_box = new_text_box("Name", "__variable_add_name__")
var var_add_button = new_cd_button("+", noscript)
var var_error_message = new_cd_text("Variable does not exist", dt_real)
var var_explanation = new_cd_text("Enter a variable name to add!")
var_name_text_box.association = var_name_text_box
var_name_text_box.__variable_add_name__ = ""
var_name_text_box.show_name = false
var_name_text_box.initial_ghost_text = "Enter variable"
var_name_text_box.att.length_min = string_length(var_name_text_box.initial_ghost_text)+2
var_name_text_box.att.scoped_color = dt_variable
var_name_text_box.button = var_add_button
with var_name_text_box att.color_method = function(text){
	var exists = variable_instance_exists(dock.association, text)
	button.can_click = exists
	return {text: text, colors: [{pos: string_length(text)+1, col: (exists ? dt_variable : "plain")}]}
}

with var_add_button
{
	text_box = var_name_text_box
	error_text = var_error_message
	explanation_text = var_explanation
	can_click = false
	released_script = function(){
		
		explanation_text.enabled = false
		if variable_instance_exists(dock.association, text_box.text)
		{
			dock.insert_vertical(0, new_text_box(text_box.text, text_box.text))
			error_text.enabled = false
			text_box.__variable_add_name__ = ""
		}
		else
		{
			error_text.enabled = true
			if text_box.text == "" error_text.set("Must enter variable name")
			else error_text.set("Variable does not exist")
		}
	}
}

var_error_message.enabled = false

var image_dock = new_console_dock("Image", [
	[new_scrubber("frame speed", "image_speed", .01)],
	[new_scrubber("frame", "image_index", 1)],
	new_separator(),
	[new_scrubber("x scale", "image_xscale", .1), new_scrubber("y scale", "image_yscale", .1)],
	[new_scrubber("angle", "image_angle", 1)],
	new_separator(),
	[new_scrubber("color blend", "image_blend", 1)],
	[new_scrubber("alpha", "image_alpha", .01)],
])
var movement_dock = new_console_dock("Movement", [
	[new_scrubber("speed", "speed", 1)], 
	[new_scrubber("direction", "direction", 1)],
	[new_scrubber("friction", "friction", .1)], 
	[new_scrubber("hspeed", "hspeed", 1), new_scrubber("vspeed", "vspeed", 1)],
	new_separator(),
	[new_scrubber("gravity", "gravity", 1)],
	[new_scrubber("gravity direction", "gravity_direction", 1)],
])
var variable_dock = new_console_dock("Variables", [
	[var_add_button, var_name_text_box],
	[var_error_message],
	new_separator(),
	[var_explanation],
])

image_dock.show = false
movement_dock.show = false
variable_dock.show = false

object_editor = new_console_dock("o_console", [
	[index_box, id_box],
	[x_scrubber, y_scrubber],
	[image_dock],
	[movement_dock],
	[variable_dock],
])
object_editor.__variable_add_name__ = ""
object_editor.association = o_console
add_console_element(object_editor)
add_console_element(bar_dock)
add_console_element(BAR)
add_console_element(OUTPUT)
add_console_element(COLOR_PICKER)
}