
function Console_value_box() constructor{
	
	initialize = function(x, y, variable, type){
		self.x = x
		self.y = y
		self.variable = variable
		
		self.type = type
		
		self.value = undefined
		self.width = 0
		self.text = ""
		
		self.pivot = 0
		self.pivot_value = 0
		self.scrolling = false
		
		self.rounding = false
		
		self.prev_mx = 0
		
		self.selected = false
		self.change = false
		
		self.right_mb = false
		
		self.ctx = new Ctx_menu()
		self.ctx.scope = self
		self.ctx.set([
			{str: vb_static,	variable: "type",	arg: vb_static},
			{str: vb_scrubber,	variable: "type",	arg: vb_scrubber},
			{str: vb_bool,		variable: "type",	arg: vb_bool},
			{str: vb_color,		variable: "type",	arg: vb_color},
		])
	}
	
	
	
	
	get_input = function(){
	
	static vb = o_console.VALUE_BOX
	
	var mouse_on = gui_mouse_between(x-vb.border-vb.border_w, y-vb.border, x+width+vb.border+vb.border_w, y+vb.border+vb.text_h)
	
	if mouse_on
	{
		if mouse_check_button_pressed(mb_right) right_mb = true
		else if right_mb and mouse_check_button_released(mb_right)
		{
			right_mb = false
			o_console.CTX_MENU.ctx = ctx
		}
	}
	
	if right_mb and not mouse_check_button(mb_right) right_mb = false
	
	switch type
	{
	case vb_static:
		value = variable_string_get(variable)
		text = string(value)
	break
	
	case vb_bool:
		value = variable_string_get(variable)
	
		if mouse_on and mouse_check_button_pressed(mb_left)
		{
			selected = true
		}
		
		if not selected
		{
			text = value ? "true" : "false"
		}
		
		if selected and not mouse_check_button(mb_left)
		{
			selected = false
			
			if mouse_on 
			{
				value = not value
				text = value ? "true" : "false"
				variable_string_set(variable, value)
			}
		}
	break
	
	case vb_scrubber:
		width = string_length(text)*vb.text_w
	
		if not is_real(value)
		{
			selected = false
		}
		else if mouse_check_button_pressed(mb_left)
		{
			if mouse_on
			{
				scrolling = true
				pivot = gui_mx
				prev_mx = pivot
				pivot_value = value
		
				keyboard_lastchar = ""
			}
			else
			{
				selected = false
			}
		}

		if not selected and change
		{
			change = false
			value = string_is_float(text) ? real(text) : 0
			variable_string_set(variable, value)
		}
		else if not selected value = variable_string_get(variable)
	
		if not is_real(value) scrolling = false
	
		if scrolling and not mouse_check_button(mb_left)
		{
			if mouse_on selected = true
		
			scrolling = false
		}
	
		if scrolling
		{
			if gui_mx != prev_mx
			{
				var newval = (gui_mx-prev_mx)/vb.ease_div
			
				newval = value + newval * max(vb.ease( abs(value) / vb.ease_max ), .01)
			
				variable_string_set(variable, newval)
				value = newval
			}
		
			prev_mx = gui_mx
		}
	
		if scrolling or not selected
		{
			if is_real(value) text = rounding ? string(round(value)) : value
			else text = NaN
		}
	
		if selected and not scrolling
		{
			if not string_is_float(text) text = ""
		
			var valstring = string(text)
			var _valstring = valstring
		
			if keyboard_check_pressed(vk_enter) selected = false
			else if	string_digits(keyboard_lastchar) == keyboard_lastchar or (keyboard_lastchar == "." and not string_pos(".", _valstring))
			{
				_valstring += keyboard_lastchar
				keyboard_lastchar = ""
			}
			else if keyboard_lastchar == "-"
			{
				_valstring = string_pos("-", _valstring) ? string_delete(_valstring, 1, 1) : "-"+_valstring
				keyboard_lastchar = ""
			}
			else if keyboard_check_pressed(vk_backspace)
			{
				_valstring = string_delete(_valstring, string_length(_valstring), 1)
			}
			else if keyboard_check_pressed(vk_left) or keyboard_check_pressed(vk_right)
			{
				if not string_pos(".", text)		value += keyboard_check(vk_right) - keyboard_check(vk_left)
				else if keyboard_check(vk_right)	value  = ceil (real(text))
				else /*if keyboard_check(vk_left)*/ value  = floor(real(text))
			
				_valstring = string(value)
			}
			if _valstring != valstring
			{
				text = _valstring
				change = true
			}
		}
	break
	case vb_color:
		text = "  "
		
		value = variable_string_get(variable)
		
		if not is_real(value) 
		{
			value = o_console.colors.body_real
			text = NaN
		}
		
		if selected and o_console.COLOR_PICKER.variable != variable
		{
			selected = false
		}
		
		if mouse_check_button_pressed(mb_left)
		{
			if mouse_on
			{
				selected = true
				o_console.COLOR_PICKER.x = gui_mx+20
				o_console.COLOR_PICKER.y = gui_my+20
				o_console.COLOR_PICKER.variable = variable
			}
			else if selected and not o_console.COLOR_PICKER.mouse_on
			{
				selected = false
				o_console.COLOR_PICKER.variable = ""
			}
		}
		
	break
	}
	}
	
	draw = function(){

	static vb = o_console.VALUE_BOX

	draw_set_font(o_console.font)

	draw_set_align(fa_left, fa_middle)

	width = string_length(text)*vb.text_w

	draw_set_color(o_console.colors.body_real)
	draw_roundrect_ext(
		x-vb.border-vb.border_w, 
		y-vb.border, 
		x+width+vb.border+vb.border_w, 
		y+vb.text_h+vb.border, 
		vb.radius, vb.radius, false
	)

	draw_set_color((selected or scrolling) ? o_console.colors.output : o_console.colors.body_accent)
	draw_roundrect_ext(
		x-vb.outline_dist-vb.border_w, 
		y-vb.outline_dist, 
		x+width+vb.outline_dist+vb.border_w, 
		y+vb.text_h+vb.outline_dist, 
		vb.outline_radius1, vb.outline_radius1, false
	)

	draw_set_color((type == vb_color) ? value : o_console.colors.body_real)
	draw_roundrect_ext(
		x-vb.outline_dist-vb.border_w+1, 
		y-vb.outline_dist+1, 
		x+width+vb.border_w+vb.outline_dist-1, 
		y+vb.text_h+vb.outline_dist-1, 
		vb.outline_radius2, vb.outline_radius2, false
	)
	
	draw_set_color(o_console.colors.plain)
	draw_text(
		x+1, 
		floor(y+vb.text_h/2)+2, 
		text
	)

	draw_set_color(c_white)
	}
}