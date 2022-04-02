
function initialize_console_graphics(scale){ with o_console {

if not font_exists(prev_font) self.scale(scale)

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
	element_hdist = 15
	
	element_wsep = 12
	element_hsep = 13
	
	dropdown_hypotenuse = 9
	dropdown_base = 17
	dropdown_wdist = 8
	
	dragging_radius = 30
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
	
	
}

with SCROLLBAR {
	
	char_height = 23
	
	outline_width = 1.4
	bar_width = 15
	bar_width_condensed = 10
	
	mouse_offset = 0
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
	
	
	
	mouse_border = 10
	mouse_dragging_top	 = false
	mouse_dragging_right = false
	scrollbar = {width: 0}
}

with CHECKBOX {
	
	char_height = 23
	width = 16
	
	mouse_on_saturation_add = -133
	mouse_on_value_add = 11
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
	
	char_height = 23
	
	wdist = 10
	hdist = 2
}
	
with SEPARATOR {
	
	char_height = 23
	width = 1.4
	double_sep = 3
	
	wdist = other.DOCK.element_wdist/2
}

with COLOR_PICKER {
	
	char_height = 23
	
	mouse_on = false
	
	variable = ""
	
	svsquare = nosprite
	hstrip = nosprite
	
	outline = 1.4
	
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
		
		length_min = 5
		length_max = 5
		allow_float = true
		float_places = 1
		lock_text_length = true
		
		value_min = 0
		value_max = 255
		
		scrubber_pixels_per_step = 2
	}
	
	with rgb_att
	{
		draw_box = false
		update_when_is_front = true
	
		length_min = 5
		length_max = 5
		lock_text_length = true
		
		allow_float = false
		
		value_min = 0
		value_max = 255
		
		scrubber_pixels_per_step = 2
	}
	
	ignore_input = true

	global_color_picker = new Console_color_picker()
	global_color_picker.initialize()
	global_color_picker.enabled = false
	
	get_input = function(){
		
		global_color_picker.get_input()
		if global_color_picker.enabled and not ignore_input and (keyboard_check_pressed(vk_enter) or keyboard_check_pressed(vk_escape) or (not global_color_picker.mouse_on and mouse_check_button_pressed(mb_any)))
		{
			global_color_picker.enabled = false
		}
		
		ignore_input = false
	}
	
	draw = function(){
		if not ignore_input global_color_picker.draw()
	}
}

with CTX_MENU
{
	char_height = 23
	
	enabled = false
	
	wdist = 10
	hdist = 0
	
	sep = 10
	
	x = 0
	y = 0
	
	left = 0
	top = 0
	right = 0
	bottom = 0
	
	prev_right = 0
	
	mouse_on = false
	clicking = false
	
	init = false
	
	element_mouse_on = -1
	element_clicking = -1
	
	moe_y1 = 0  // Mouse On Element
	moe_y2 = 0
	mce_y1 = 0  // Mouse Clicking Element
	mce_y2 = 0
	
	mouse_on_alpha = .05
	clicking_alpha = .1
	
	elements = []
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
}

with DOC_STRIP
{
	char_height = 23
	
	wdist = 10
	hdist = 2
	outline = 1.4
}
}}