
function initialize_console_graphics(scale){ with o_console {

if is_undefined(scale)
{
	var display_width = display_get_width()/display_get_dpi_x()
	
	scale = 2 + (display_width >= 14) + (display_width >= 23) + (display_width >= 28) + (display_width >= 31)
	show_debug_message("Console IDE automatically scaled to "+string(scale)+" based on display size")
	
	// Scales based on display size:
	// 14in		2x
	// 23in		3x
	// 28in		4x
	// 31in		5x
	// Above	6x
}

self.scale(scale)

draw_set_font(font)
draw_enable_swf_aa(true)

if run_in_embed return undefined

with DOCK {
	
	docked = false
	char_height = 23
	
	name_outline_width = 1.4
	name_wdist = 9
	name_hdist = 4
	
	element_wdist = 17
	element_hdist = 18
	
	element_wsep = 12
	element_hsep = 15
	
	dropdown_hypotenuse = 9
	dropdown_base = 17
	dropdown_wdist = 8
	
	dragging_radius = 30

	colors = o_console.colors
}

with TEXT_BOX {
	
	char_height = 23
	text_wdist = 10
	text_hdist = 5
	
	blink_time = 45
	char_selection_alpha = .2
	
	dclick_time = 14
	
	repeat_time = 30
	repeat_step = 0
	
	outline_width = 1.4
	
	rleft = 0
	rright = 0
	rbackspace = 0
	rdel = 0
	
	update_id = 0

	word_sep = " .,\"()[]/"
	
	colors = o_console.colors
}

with SCROLLBAR {
	
	char_height = 23
	
	outline_width = 1.4
	bar_width = 50
	bar_width_condensed = 20
	
	mouse_offset = 0
	
	colors = o_console.colors
}

with BAR {
	
	enabled = false
	
	char_height = 23
	
	outline_width = 1.4
	docked_width = 1000
	
	x = undefined		// These are for placing the bar somewhere else
	y = undefined
	width = undefined	

	left = 0
	top	= 0
	right = 0
	bottom = 0
	
	bar_right = 0
	sidetext_left = 0
	sidetext_string = "noone"

	height = 17
	sep = 2.7
	win_dist = 50
	
	text_dist = 18
	sidebar_width = 3
	
	mouse_on = false
	
	text_box = new Console_text_box() with text_box
	{
		initialize()
		variable = "o_console.console_string"
		draw_name = false
		att.draw_box = false
		color_method = gmcl_string_color
		autofill_method = gmcl_autofill_old
		att.exit_with_enter = false
		att.set_variable_on_input = true
		att.allow_scoped_exinput = true
	}
	
	get_input = console_bar_inputs
	draw = draw_console_bar
	
	colors = o_console.colors
}

with OUTPUT {
	
	docked = false
	
	text = new Embedded_text()
	text.set()
	
	dock = new Console_dock()
	dock.initialize()
	dock.set(text)
	dock.name = "Console output"

	fade_time = 6 //seconds
	fade_step = 0
	alpha = 0
	alpha_dec = .04
	
	mouse_on = false
	has_embed = false
	body = false
	
	get_input = console_output_inputs
	draw = draw_console_output
	
	colors = o_console.colors
}

with AUTOFILL {
	
	x = 0
	y = 0
	
	show = false
	
	char_height = 17
	
	index = -1
	
	width = 465
	height = 220
	
	dropshadow = false
	
	sidetext_bar = 5
	sidetext_width = 130
	sidetext_border = 7
	
	sidetext_hue = -3
	sidetext_saturation = 144
	sidetext_value = 93
	
	width_min = sidetext_bar+sidetext_width+sidetext_border+76
	height_min = char_height*1.5
	
	border_w = 1
	border_h = 1
	
	text_sep = 1
	
	mouse_on = false
	
	colors = o_console.colors
	
	mouse_border = 10
	mouse_dragging_top	 = false
	mouse_dragging_right = false
	scrollbar = {width: 0}
}

with CHECKBOX {
	
	width = 17
	colors = o_console.colors
}


with SLIDER {
	
	height			 = 39
	height_condensed = 15
	text_offset		 = 10
	
	update_every_frame	  = true
	lock_value_to_step	  = true
	correct_not_real	  = true
	
	font = o_console.font
	marker_font = -1 //set later
	
	divider_width = 2
	
	colors = o_console.colors
}

with CD_BUTTON {
	
	char_height = 23
	
	wdist = 10
	hdist = 5
	
	colors = o_console.colors
}
	
with SEPARATOR {
	
	char_height = 23
	width = 1.4
	double_sep = 3
	
	wdist = other.DOCK.element_wdist/2
	
	colors = o_console.colors
}


with COLOR_PICKER {
	
	char_height = 23
	
	mouse_on = false
	
	variable = ""
	
	svsquare = generate_satval_square()
	hstrip = generate_hue_strip()
	
	outline = 1.7
	
	dist = 9
	sep = 9
	
	svsquare_length = 140
	dropper_length = 10
	hpicker_height = 15
	
	hstrip_width = 26
	
	colorbar_height = 29
	
	color_picker_dock_size = 1.24
	
	var_att = new_text_box("", "").att
	hsv_att = new_scrubber("", "", 1).att
	rgb_att = new_scrubber("", "", 1).att
	hex_att = new_text_box("", "").att
	gml_att = new_text_box("", "").att
	
	with var_att
	{
		length_min = 22
		set_variable_on_input = false
		allow_scoped_exinput = false
		scoped_color = dt_variable
	}
	
	with hex_att
	{
		draw_box = false
		
		set_variable_on_input = true
		update_when_is_front = true
		
		length_min = 6
		length_max = 6
		lock_text_length = true
	}
	
	with gml_att
	{
		draw_box = false
		allow_alpha = false
		set_variable_on_input = true
		update_when_is_front = true
		select_all_on_click = true
		
		allow_float = false
		
		length_min = 8
		length_max = 8
		lock_text_length = true
	}
	
	with hsv_att
	{
		draw_box = false
		update_when_is_front = true
		
		length_min = 3
		length_max = 5
		allow_float = false
		lock_text_length = true
		
		value_min = 0
		value_max = 255
	}
	
	with rgb_att
	{
		draw_box = false
		update_when_is_front = true
	
		length_min = 3
		length_max = 3
		lock_text_length = true
		
		allow_float = false
		
		value_min = 0
		value_max = 255
	}
	
	ignore_input = true

	global_color_picker = new Console_color_picker()
	global_color_picker.initialize()
	global_color_picker.enabled = false
	
	get_input = function(){
		
		global_color_picker.get_input()
		if global_color_picker.enabled and not ignore_input and not global_color_picker.mouse_on and mouse_check_button_pressed(mb_any)
		{
			global_color_picker.enabled = false
		}
		
		ignore_input = false
	}
	
	draw = function(){
		if not ignore_input global_color_picker.draw()
	}
	
	colors = o_console.colors
}

with MEASURER {
	
	enabled = false
	
	setting = 1
	
	x1 = 0
	y1 = 0
	x2 = undefined
	y2 = undefined
	
	length = 0
	width = 0
	height = 0
	
	colors = o_console.colors
}
}}