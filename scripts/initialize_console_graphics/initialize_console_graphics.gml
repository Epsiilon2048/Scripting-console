
function initialize_console_graphics(scale){ with o_console {

if is_undefined(scale)
{
	var display_w = display_get_width()
	
	scale = (display_w < 1920) + (display_w < 2560) + (display_w < 3840)
	
	// Below 1080p	1x
	// 1080p		2x
	// 2k			3x
	// 4k and above	4x
}

SCALE[0] = undefined
	
SCALE[1] = {mult: 11/15, font: fnt_debug1x}
SCALE[2] = {mult: 13/15, font: fnt_debug2x}
SCALE[3] = {mult: 1,	 font: fnt_debug3x}
SCALE[4] = {mult: 18/15, font: fnt_debug4x}
SCALE[5] = {mult: 21/15, font: fnt_debug5x}

draw_scale = SCALE[scale]
font = draw_scale.font

draw_set_font(font)
draw_enable_swf_aa(true)

char_width	= string_width(" ")
char_height = string_height(" ")

with BAR {
	
	char_height = 23
	
	x = undefined		// These are for placing the bar somewhere else
	y = undefined
	width = undefined	

	left = 0
	top	= 0
	right = 0
	bottom = 0

	height = 17
	sep = 3
	win_dist = 50
	
	text_dist = 18
	sidebar_width = 2
	
	blink_time = 70
	blink_step = 0
	
	mouse_on = false
}

with OUTPUT {
	
	char_height = 17
	
	x = undefined	// Anchored from bottom left
	y = undefined
	
	width = undefined
	height = undefined
	
	left = 0
	top = 0
	right = 0
	bottom = 0
	
	bar_dist = 15
	border_w = 11
	border_h = 7
	
	outline = .6
	
	text = new Embedded_text()
	text.set()
	//scrollbar = new Console_scrollbar()
	//ctx = new Ctx_menu()
	//
	//scrollbar.initialize(left, top, right, bottom, width, height, 0, 0, fa_right, fa_bottom)
	//ctx.set([
	//	{str: "Copy"},
	//	ctx_separator,
	//	{str: "Set window"},
	//	{str: "Clear"},
	//])
	
	fade_time = 6*60
	fade_step = 0
	alpha = 0
	alpha_dec = .04
	
	mouse_on = false
	has_embed = false
	body = false
}
	
//Output = {}; with Output {
//	
//	border_w = 11
//	border_h = 7
//	
//	text			= new Embedded_text()
//	plaintext		= ""
//	text_embedding	= false
//	
//	time			 = 6*60
//	fade_time		 = 0
//	alpha			 = 0
//	alpha_dec		 = .04
//	mouse_on		 = false
//	mouse_over_embed = false
//	
//	tag = -1
//	tag_prev = -1
//	tag_prev_menu = -1
//
//	tag_set = function(_tag){
//		
//		if tag != -1 tag_prev_menu = tag
//		tag_prev = tag
//		tag = _tag
//	}
//}

with SCROLLBAR {
	
	char_height = 17
	
	width = 20
	min_height = 18
	
	scroll_step = char_height*4
	key_scroll_step = 6
	
	resize_border = 6
}

with AUTOFILL_LIST {
	
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
	
	scrollbar = new Console_scrollbar()
	scrollbar.initialize(0, 0, 0, 0, width, height, fa_right, fa_bottom)
	scrollbar.resize = true
}

with CHECKBOX {
	
	width = 17
}

with WINDOW {
	
	width = 400
	height = 300
}

with COLOR_PICKER {
	
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
	
	color = make_color_hsv(hue, sat, val)
	size = 100
}

with VALUE_BOX {
	
	radius = 23
	border_radius = 20
	border = 9
	border_w = 6
	ext_border = 3
	outline_dist = border-2
	outline_radius1 = radius*(outline_dist/border)
	outline_radius2 = radius*((outline_dist-1)/border)
	text_w = string_width(" ")
	text_h = string_height(" ")

	ease_max = 200
	ease_div = 1.5
	ease = ease_normal
}

with CTX_MENU {
	
	enabled = false
	
	x = 50
	y = 50
	
	border_l = 36
	border_r = 10
	
	mouse_item = -1
	
	clicking_on = false
	
	inputs = false
	
	left   = 0
	right  = 0
	top	   = 0
	bottom = 0
	
	roundrect_radius = 5
	
	spacing = 8
	sep_spacing = 10
	
	font = o_console.font
	
	ctx = undefined
}

with CTX_STRIP {
	
	dist   = 7
	border = 5
	
	line_width = 1
	
	time = 20
	alpha_spd = .3
	
	font = o_console.font
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
}}