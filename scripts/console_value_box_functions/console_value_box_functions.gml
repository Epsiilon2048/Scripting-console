
function Console_value_box() constructor{
	
	set = function(variable){
		self.variable = variable
		self.varname = string_copy( variable, string_pos(".", variable)+1, string_length(variable) )
	}
	
	
	initialize = function(index, x, y, variable, type){
		self.index = index
		
		self.x = x
		self.y = y
		
		self.set(variable)
		
		self.type = type
		self.prev_type = type
		self.init_type = type
		self.lock_type = false
		
		self.value = undefined
		self.width = 0
		self.value_width = 0
		self.text = ""
		
		self.pivot = 0
		self.pivot_value = 0
		self.scrolling = false
		
		self.rounding = false
		self.dragging = false
		
		self.color_picking = false
		
		self.prev_mx = 0
		self.prev_my = 0
		
		self.selected = false
		self.change = false
		
		self.right_mb = false

		self.destroy = false

		self.ctx = new Ctx_menu()
		self.ctx.scope = self
		self.ctx.set([
			{str: "Static",		variable: "type",	arg: vb_static},
			{str: "Scrubber",	variable: "type",	arg: vb_scrubber},
			{str: "Bool",		variable: "type",	arg: vb_bool},
			{str: "Color",		variable: "type",	arg: vb_color},
			ctx_separator,
			{str: "Destroy", variable: "destroy", arg: true},
		])
	}
	
	
	
	
	get_input = function(){
	
	static vb = o_console.VALUE_BOX
	
	if prev_type != type
	{
		selected = false
		color_picking = false
	}
	
	var mouse_on = not o_console.COLOR_PICKER.mouse_on and gui_mouse_between(
		x-vb.border-vb.border_w, 
		y-vb.border, 
		x+width+value_width+vb.border, 
		y+vb.border+vb.text_h
	)
	
	var mouse_on_value = mouse_on and gui_mouse_between(
		x+width-vb.outline_dist-vb.border_w, 
		y-vb.outline_dist, 
		x+width+value_width+vb.outline_dist,
		y+vb.text_h+vb.outline_dist,
	)
	
	if mouse_on o_console.value_box_mouse_on = true
	
	if mouse_on and not mouse_on_value and not o_console.value_box_dragging and mouse_check_button_pressed(mb_left)
	{
		dragging = true
		o_console.value_box_dragging = true
		
		prev_mx = gui_mx
		prev_my = gui_my
		
		ds_list_insert(o_console.value_boxes, 0, self)
		ds_list_delete(o_console.value_boxes, index+1)
		index = 0
		
		for(var i = 0; i <= ds_list_size(o_console.value_boxes)-1; i++)
		{
			if is_struct(o_console.value_boxes[| i]) o_console.value_boxes[| i].index = i
		}
	}
	
	if dragging
	{
		if mouse_check_button(mb_left)
		{
			x += gui_mx - prev_mx
			y += gui_my - prev_my
			
			prev_mx = gui_mx
			prev_my = gui_my
		}
		else
		{
			dragging = false
			x = clamp( x, 0, gui_width-30 )
			y = clamp( y, 0, gui_height-30 )
		}
	}
	
	if mouse_on and not lock_type
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

		if mouse_on_value and mouse_check_button_pressed(mb_left)
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
			
			if mouse_on_value 
			{
				value = not value
				text = value ? "true" : "false"
				variable_string_set(variable, value)
			}
		}
		
		value = variable_string_get(variable)
	break
	
	case vb_scrubber:
		value_width = string_length(text)*vb.text_w
	
		if not is_numeric(value)
		{
			selected = false
			o_console.keyboard_scope = o_console.BAR
		}
		else if mouse_check_button_pressed(mb_left)
		{
			if mouse_on_value
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
				o_console.keyboard_scope = o_console.BAR
			}
		}

		if not selected and change
		{
			change = false
			value = string_is_float(text) ? real(text) : 0
			variable_string_set(variable, value)
		}
		else if not selected value = variable_string_get(variable)
	
		if not is_numeric(value) scrolling = false
	
		if scrolling and not mouse_check_button(mb_left)
		{
			if mouse_on_value 
			{
				selected = true
				o_console.keyboard_scope = self
			}
		
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
			if is_numeric(value) text = rounding ? string(round(value)) : value
			else text = NaN
		}
	
		if selected and not scrolling
		{
			if not string_is_float(text) text = ""
		
			var valstring = string(text)
			var _valstring = valstring
		
			if keyboard_check_pressed(vk_enter) 
			{
				selected = false
				o_console.keyboard_scope = o_console.BAR
			}
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
		
		if not is_numeric(value) 
		{
			value = o_console.colors.body_real
			text = NaN
		}
		
		if selected and not color_picking
		{
			selected = false
		}
		
		if mouse_check_button_pressed(mb_left) and mouse_on_value
		{
				selected = true
				color_picking = true
				o_console.COLOR_PICKER.x = gui_mx+20
				o_console.COLOR_PICKER.y = gui_my+20
				o_console.COLOR_PICKER.variable = variable
		}
		
		if mouse_check_button_pressed(mb_any) and not mouse_on_value and selected and not o_console.COLOR_PICKER.mouse_on
		{
			selected = false
			color_picking = false
			o_console.COLOR_PICKER.variable = ""
		}
		
	break
	}
	
	if type != vb_color and color_picking
	{
		color_picking = false
		selected = false
		o_console.COLOR_PICKER.variable = ""
	}

	o_console.value_box_deleted = destroy
	prev_type = type
	}
	
	
	
	
	draw = function(){

	static vb = o_console.VALUE_BOX

	draw_set_font(o_console.font)

	draw_set_halign(fa_left)
	draw_set_valign(fa_middle)

	width		= string_length(varname)*vb.text_w + vb.border_w*3 + vb.outline_dist+1
	value_width = string_length(text)*vb.text_w + vb.border_w

	draw_set_color(o_console.colors.body_real)
	draw_roundrect_ext(
		x-vb.border-vb.border_w, 
		y-vb.border, 
		x+width+value_width+vb.border, 
		y+vb.text_h+vb.border, 
		vb.border_radius, vb.border_radius, false
	)
	draw_set_color((selected or scrolling) ? o_console.colors.output : o_console.colors.body_accent)
	draw_roundrect_ext(
		x+width-vb.outline_dist-vb.border_w, 
		y-vb.outline_dist, 
		x+width+value_width+vb.outline_dist, 
		y+vb.text_h+vb.outline_dist, 
		vb.outline_radius1, vb.outline_radius1, false
	)
	draw_set_color((type == vb_color and not is_undefined(value)) ? value : o_console.colors.body_real)
	draw_roundrect_ext(
		x+width-vb.outline_dist-vb.border_w+1, 
		y-vb.outline_dist+1, 
		x+width+value_width+vb.outline_dist-1, 
		y+vb.text_h+vb.outline_dist-1, 
		vb.outline_radius2, vb.outline_radius2, false
	)
	
	var _textcol = dt_unknown
	
	switch type
	{
		case vb_bool:		_textcol = dt_real
		break
		case vb_scrubber:	_textcol = dt_real
		break
		case vb_color:		_textcol = dt_real
	}
	
	draw_set_color(o_console.colors.output)
	draw_text(
		x+1,
		floor(y+vb.text_h/2)+2,
		varname
	)
	
	draw_set_color(o_console.colors[$ _textcol])
	draw_text(
		x+width+1, 
		floor(y+vb.text_h/2)+2, 
		text
	)

	draw_set_color(c_white)
	}
}