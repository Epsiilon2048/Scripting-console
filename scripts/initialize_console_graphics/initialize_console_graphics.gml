
function initialize_console_graphics(scale){ with o_console {

if is_undefined(scale)
{
	var display_w = display_get_width()
	
	scale = 2 + (display_w >= 1920) + (display_w >= 2560) + (display_w >= 3840)
	show_debug_message("Console IDE automatically scaled to "+string(scale)+" based on display size")
	// Below 1080p	2x
	// 1080p		3x
	// 2k			4x
	// 4k and above	5x
}

self.scale(scale)

draw_set_font(font)
draw_enable_swf_aa(true)

if run_in_embed return undefined

with DOCK {
	
	char_height = 23
	
	name_outline_width = 1.7
	name_wdist = 15
	name_hdist = 5
	
	element_wdist = 21
	element_hdist = 21
	
	element_wsep = 14
	element_hsep = 17
	
	dropdown_hypotenuse = 10
	dropdown_base = 17
	dropdown_wdist = 8
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
	
	outline_width = 1.7
	
	rleft = 0
	rright = 0
	rbackspace = 0
	rdel = 0
	
	update_id = 0

	word_sep = " .,\"()[]/"
}

with BAR {
	
	format_for_dock(undefined)
	
	enabled = false
	
	char_height = 23
	
	outline_width = 1.7
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
		show_name = false
		att.draw_box = false
		att.color_method = gmcl_string_color
		att.exit_with_enter = false
		att.set_variable_on_input = true
		att.allow_scoped_exinput = true
	}
	
	get_input = console_bar_inputs
	draw = draw_console_bar
}

with WINDOW {
	
	char_height = 17
	
	width = 600
	height = 500
	
	sidebar_min = 2
	sidebar_max = 3
	sidebar_lerp = .35

	mouse_border = 14
	
	border_w = 20
	border_h = 10
}

with OUTPUT {
	
	format_for_dock(undefined)
	
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
}

with AUTOFILL {
	
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
	
	mouse_border = 6
	mouse_dragging_top = false
	mouse_dragging_right = false
}

with CHECKBOX {
	
	width = 17
}

with COLOR_PICKER {
	
	size = 100
	
	x = 0
	y = 0
	
	mouse_on = false
	
	variable = ""
	
	sv_square = generate_satval_square()
	h_strip	  = generate_hue_strip()
	
	border_width = 1
	border_alpha = 0.2
	
	sv_square_dropper_radius = 11
	
	h_strip_width	   = 50
	h_strip_dist	   = 20
	h_strip_bar_height = 18
	
	color_bar_dist	 = 20
	color_bar_height = 53
	
	hue = 0
	sat = 255
	val = 255
	
	r = 255
	g = 255
	b = 255
	
	hsv_255 = false
	
	hex_text_box = new_text_box("Hex", "o_console.COLOR_PICKER.hex")
	
	hue_text_box = new_scrubber("Hue", "o_console.COLOR_PICKER.hue", 1)
	sat_text_box = new_scrubber("Sat", "o_console.COLOR_PICKER.sat", 1)
	val_text_box = new_scrubber("Val", "o_console.COLOR_PICKER.val", 1)
	
	r_text_box = new_scrubber("Red", "o_console.COLOR_PICKER.r", 1)
	g_text_box = new_scrubber("Green", "o_console.COLOR_PICKER.g", 1)
	b_text_box = new_scrubber("Blue", "o_console.COLOR_PICKER.b", 1)

	color = make_color_hsv(hue, sat, val)
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
}

with CD_BUTTON {
	
	char_height = 20
	
	wdist = 15
	hdist = 4
}
	
with SEPARATOR {
	
	char_height = 23
	width = 1.7
	double_sep = 3
}
}}