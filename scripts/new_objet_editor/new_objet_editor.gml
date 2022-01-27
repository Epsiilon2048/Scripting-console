
function new_objet_editor(object){

var id_box = new_display_box("id", "id", false)
id_box.allow_printing = false
id_box.att.select_all_on_click = true

var index_box = new_display_box("Object", "object_index", false)
index_box.allow_printing = false
index_box.att = id_box.att

var x_scrubber = new_scrubber("x", "x", 1)
var y_scrubber = new_scrubber("y", "y", 1)
x_scrubber.att.scrubber_pixels_per_step = 1
y_scrubber.att.scrubber_pixels_per_step = 1

var var_name_text_box = new_text_box("Name", "__variable_add_name__")
var var_add_button = new_cd_button("+", noscript)
var var_explanation = new_cd_text("Enter a variable name to add!", undefined)

var var_name_text_box = new_text_box("Name", "__variable_add_name__")
with var_name_text_box
{
	association = var_name_text_box
	button = var_add_button
	draw_name = false
	initial_ghost_text = "Enter variable"
	allow_printing = false
	att.exit_with_enter = false
	att.length_min = string_length(initial_ghost_text)+5
	att.scoped_color = dt_variable
	
	__variable_add_name__ = ""

	color_method = function(text){
		var exists = variable_instance_exists(dock.association, text)
		button.can_click = exists
		return {text: text, colors: [{pos: string_length(text)+1, col: (exists ? dt_variable : "plain")}]}
	}
	
	on_enter = function(){
		button.released_script()
	}
}

with var_add_button
{
	text_box = var_name_text_box
	explanation_text = var_explanation
	can_click = false
	released_script = function(){
		
		explanation_text.enabled = false
		if variable_instance_exists(dock.association, text_box.text)
		{
			dock.insert_vertical(0, new_text_box(text_box.text, text_box.text))
			text_box.__variable_add_name__ = ""
		}
	}
}

var image_dock = new_console_dock("Image", [
	[new_scrubber("frame speed", "image_speed", .01)],
	[new_scrubber("frame", "image_index", 1)],
	new_separator(),
	[new_scrubber("x scale", "image_xscale", .1), new_scrubber("y scale", "image_yscale", .1)],
	[new_scrubber("angle", "image_angle", 1)],
	new_separator(),
	[new_color_box("color blend", "image_blend")],
	[new_scrubber("alpha", "image_alpha", .01)],
])
var movement_dock = new_console_dock("Movement", [
	[new_scrubber("speed", "speed", .1)], 
	[new_scrubber("direction", "direction", 1)], 
	[new_scrubber("friction", "friction", .1)], 
	[new_scrubber("hspeed", "hspeed", .1), new_scrubber("vspeed", "vspeed", .1)],
	new_separator(),
	[new_scrubber("gravity", "gravity", 1)],
	[new_scrubber("gravity direction", "gravity_direction", 1)],
])
var variable_dock = new_console_dock("Variables", [
	[var_add_button, var_name_text_box],
	new_separator(),
	[var_explanation],
])

image_dock.show = false
movement_dock.show = false
variable_dock.show = false

var editor = new_console_dock("Object editor", [
	[index_box, id_box],
	[x_scrubber, y_scrubber],
	[image_dock],
	[movement_dock],
	[variable_dock],
])

if is_undefined(object)
{
	with editor before_func = function(){association = o_console.object}
}
else editor.association = object
editor.hide_all()

return editor
}