
function Console_color_picker() constructor{

format_console_element()

initialize = function(variable){
	
	self.variable = variable
	association = undefined
	enabled = true
	docked = false
	
	x = 0
	y = 0
	
	left = 0
	top = 0
	right = 0
	bottom = 0
	
	width = 0
	height = 0
	
	in_left = 0
	in_top = 0
	in_right = 0
	in_bottom = 0
	
	svsquare_right = 0
	svsquare_bottom = 0
	hstrip_left = 0
	colorbar_top = 0
	
	mouse_on = false
	mouse_on_svsquare = false
	mouse_on_hstrip = false
	mouse_on_colorbar = false
	
	clicking = false
	sv_picking = false
	h_picking = false
	
	sv_scoped = false
	h_scoped = false
	
	hue_y = 0
	dropper_x = 0
	dropper_y = 0
	
	color_changed = false
	
	draw_box = true
	
	hue = 0
	sat = 255
	val = 255
	
	color = make_color_hsv(hue, sat, val)
	
	update_variable()
	
	size = 1
	set_variable_on_input = true
}



update_variable = function(){
	
	var old_color = color
	var _association = is_undefined(association) ? (docked ? dock.association : self) : association
	with _association other.color = variable_string_get(other.variable)
	
	if not is_numeric(color) color = old_color
	else
	{
		val = color_get_value(color)
			
		if color_get_hue(color) 
		{
			hue = color_get_hue(color)
		}
			
		if val 
		{
			sat = color_get_saturation(color)
		}
	}
	
	if color != old_color
	{
		draw_set_font(o_console.font)
		
		var co = o_console.COLOR_PICKER
		var ch = string_height(" ")
		var asp = ch/co.char_height
		var size_asp = asp*size
		var _outline = round(co.outline*asp)
		var _svsquare_length = round(co.svsquare_length*size_asp)
		
		dropper_x = _outline + clamp(sat/255, 0, 1)*_svsquare_length
		dropper_y = _outline + clamp(1-val/255, 0, 1)*_svsquare_length
		hue_y = _outline + clamp(hue/255, 0, 1)*_svsquare_length
	}
}



get_input = function(){

	if not enabled
	{
		left = x
		top = y
		right = x
		bottom = y
		
		color_changed = false
		
		mouse_on = false
		mouse_on_svsquare = false
		mouse_on_hstrip = false
		mouse_on_colorbar = false
		
		clicking = false
		sv_picking = false
		h_picking = false
		sv_scoped = false
		h_scoped = false
		
		return undefined
	}

	static mouse_was_on = false

	var old_font = draw_get_font()

	draw_set_font(o_console.font)

	var co = o_console.COLOR_PICKER
	var ch = string_height(" ")
	var asp = ch/co.char_height
	var size_asp = asp*size
	var _dist = draw_box ? round(co.dist*size_asp) : 0
	var _sep = round(co.sep*size_asp)
	var _outline = round(co.outline*asp)
	var _svsquare_length = round(co.svsquare_length*size_asp)
	var _hstrip_width = round(co.hstrip_width*size_asp)
	var _colorbar_height = round(co.colorbar_height*size_asp)


	width = _dist*2+_outline*4+_svsquare_length+_sep+_hstrip_width
	height = _dist*2+_outline*4+_svsquare_length+_sep+_colorbar_height
	
	left = x
	top = y
	right = left+width
	bottom = top+height

	in_left = left+_dist
	in_right = right-_dist
	in_top = top+_dist
	in_bottom = bottom-_dist

	svsquare_right = in_left+_outline*2+_svsquare_length
	svsquare_bottom = in_top+_outline*2+_svsquare_length
	hstrip_left = in_right-_outline*2-_hstrip_width
	colorbar_top = in_bottom-_outline*2-_colorbar_height

	if not mouse_on_console and not clicking_on_console
	{
		mouse_on = gui_mouse_between(left, top, right, bottom)
		mouse_on_svsquare = mouse_on and gui_mouse_between(in_left, in_top, svsquare_right, svsquare_bottom)
		mouse_on_hstrip = mouse_on and gui_mouse_between(hstrip_left, in_top, in_right, svsquare_bottom)
		mouse_on_colorbar = mouse_on and gui_mouse_between(in_left, colorbar_top, in_right, in_bottom)
		
		if mouse_on 
		{
			mouse_on_console = true
			if mouse_check_button_pressed(mb_left) 
			{
				clicking = true
				sv_picking = mouse_on_svsquare
				h_picking = mouse_on_hstrip
				sv_scoped = mouse_on_svsquare
				h_scoped = mouse_on_hstrip
				clicking_on_console = true
			}
		}
	}
	else
	{
		mouse_on = false
		mouse_on_svsquare = false
		mouse_on_hstrip = false
		mouse_on_colorbar = false
		
		if mouse_check_button(mb_left)
		{
			sv_scoped = false
			h_scoped = false
		}
	}
	
	
	if mouse_on_svsquare and not h_picking
	{
		mouse_was_on = true
		if docked window_set_cursor(clicking ? cr_none : cr_cross)
	}
	else if mouse_was_on
	{
		mouse_was_on = false
		if docked window_set_cursor(cr_default)
	}

	if clicking 
	{
		if not mouse_check_button(mb_left)
		{
			clicking = false
			sv_picking = false
			h_picking = false
		}
		else clicking_on_console = true
	}

	if sv_picking
	{
		dropper_x = clamp(gui_mx-in_left, _outline, _outline+_svsquare_length)
		dropper_y = clamp(gui_my-in_top, _outline, _outline+_svsquare_length)
		sat = (dropper_x-_outline)/(svsquare_right-in_left-_outline*2)*255
		val = 255-(dropper_y-_outline)/(svsquare_bottom-in_top-_outline*2)*255
	}
	else if h_picking
	{
		hue_y = clamp(gui_my-in_top, _outline, _outline+_svsquare_length)
		hue = (hue_y-_outline)/(svsquare_bottom-in_top-_outline*2)*255
	}
	
	color_changed = false
	
	if sv_picking or h_picking and set_variable_on_input
	{
		color = make_color_hsv(hue, sat, val)
		
		var _association = is_undefined(association) ? (docked ? dock.association : self) : association
		with _association variable_string_set(other.variable, other.color)
		color_changed = true
	}
	
	if not sv_picking and not h_picking update_variable()

	draw_set_font(old_font)
}



draw = function(){

	if right == x and bottom == y return undefined

	static u_position = shader_get_uniform(shd_hue, "u_Position")

	var old_color = draw_get_color()
	var old_font = draw_get_font()

	draw_set_font(o_console.font)

	var co = o_console.COLOR_PICKER
	var ch = string_height(" ")
	var asp = ch/co.char_height
	var _outline = round(co.outline*asp)
	var _dropper_length = round(co.dropper_length*asp)
	var _hpicker_height = round(co.hpicker_height*asp)

	if draw_box
	{
		if not docked draw_console_body(left, top, right, bottom)
		draw_set_color(o_console.colors.body_accent)
		draw_hollowrect(left, top, right, bottom, _outline)
	}

	var _in_left = in_left+_outline
	var _in_top = in_top+_outline
	var _in_right = in_right-_outline
	var _svsquare_right = svsquare_right-_outline
	var _svsquare_bottom = svsquare_bottom-_outline
	var _hstrip_left = hstrip_left+_outline

	shader_set(shd_hue)
	shader_set_uniform_f(u_position, hue/255)
	draw_surface_stretched(co.svsquare, _in_left, _in_top, _svsquare_right-_in_left+1, _svsquare_bottom-_in_top+1)
	shader_reset()
	
	draw_surface_stretched(co.hstrip, _hstrip_left, _in_top, _in_right-_hstrip_left+1, _svsquare_bottom-_in_top+1)

	draw_set_color(color)
	draw_rectangle(in_left, colorbar_top, in_right, in_bottom, false)

	draw_set_color(o_console.colors.body_accent)
	draw_hollowrect(in_left, in_top, svsquare_right, svsquare_bottom, _outline)
	draw_hollowrect(hstrip_left, in_top, in_right, svsquare_bottom, _outline)
	draw_hollowrect(in_left, colorbar_top, in_right, in_bottom, _outline)

	if sv_scoped
	{
		draw_set_color(o_console.colors.output)
		draw_hollowrect(in_left-_outline, in_top-_outline, svsquare_right+_outline, svsquare_bottom+_outline, _outline)
	}
	else if h_scoped
	{
		draw_set_color(o_console.colors.output)
		draw_hollowrect(hstrip_left-_outline, in_top-_outline, in_right+_outline, svsquare_bottom+_outline, _outline)
	}

	var hpicker_y1 = max(in_top+hue_y-_hpicker_height/2, _in_top)
	var hpicker_y2 = min(in_top+hue_y+_hpicker_height/2, _svsquare_bottom)
	
	var dropper_x1 = in_left+dropper_x-_dropper_length/2
	var dropper_y1 = in_top+dropper_y-_dropper_length/2
	var dropper_x2 = in_left+dropper_x+_dropper_length/2
	var dropper_y2 = in_top+dropper_y+_dropper_length/2
	
	var _o = _outline*2
	draw_set_color(c_white)
	draw_rectangle(dropper_x1-_o, dropper_y1-_o, dropper_x2+_o, dropper_y2+_o, false)
	draw_rectangle(hstrip_left-_outline, hpicker_y1-_o, in_right+_outline, hpicker_y2+_o, false)

	_o = _outline
	draw_set_color(c_black)
	draw_rectangle(dropper_x1-_o, dropper_y1-_o, dropper_x2+_o, dropper_y2+_o, false)
	draw_rectangle(hstrip_left, hpicker_y1-_o, in_right, hpicker_y2+_o, false)

	draw_set_color(color)
	draw_rectangle(dropper_x1, dropper_y1, dropper_x2, dropper_y2, false)

	draw_set_color(make_color_hsv(hue, 255, 255))
	draw_rectangle(_hstrip_left, hpicker_y1, _in_right, hpicker_y2, false)

	draw_set_font(old_color)
	draw_set_font(old_font)
}
}