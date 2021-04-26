// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function initialize_console_graphics(){ with o_console {

SCALE = {}
	
SCALE[$ 1] = {mult: 11/15, font: fnt_debug1x}
SCALE[$ 3] = {mult: 1,	   font: fnt_debug3x}

draw_scale = SCALE[$ 1]
font = draw_scale.font

draw_set_font(font)

CHECKBOX = {}; with CHECKBOX {
	
	width = 17
}

WINDOW = {}; with WINDOW {
	
	width = 400
	height = 300
}

COLOR_PICKER = {}; with COLOR_PICKER {
	
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

VALUE_BOX = {}; with VALUE_BOX {
	
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

CTX_MENU = {}; with CTX_MENU {
	
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

CTX_STRIP = {}; with CTX_STRIP {
	
	dist   = 7
	border = 5
	
	line_width = 1
	
	time = 20
	alpha_spd = .3
	
	font = o_console.font
}

SLIDER = {}; with SLIDER {
	
	height			 = SCALE_ 39
	height_condensed = SCALE_ 15
	text_offset		 = SCALE_ 10
	
	update_every_frame	  = true
	lock_value_to_step	  = true
	correct_not_real	  = true
	
	font = o_console.font
	marker_font = -1 //set later
	
	divider_width = 2
}
}}