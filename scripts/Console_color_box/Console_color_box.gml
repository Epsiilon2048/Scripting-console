
function new_color_box(name, variable){
var c = new Console_color_box()
c.initialize(variable)
c.name = name
return c
}


function Console_color_box() constructor{

initialize = function(variable){
	
	docked = false
	
	name = is_undefined(variable) ? "Color box" : string(variable)
	enabled = true
	
	draw_name = true
	
	x = 0
	y = 0
	xprevious = 0
	yprevious = 0
	moved = true
	
	self.variable = variable
	color = 0
	scoped = false
	
	mouse_on = false
	mouse_on_name = false
	mouse_on_box = false
	clicking = false
	dragging = false
	
	mouse_xoffset = 0
	mouse_yoffset = 0
	
	left = 0
	top = 0
	right = 0
	bottom = 0
	
	box_left = 0
	
	cbox_left = undefined
	cbox_top = undefined
	cbox_right = undefined
	cbox_bottom = undefined
	
	name_text_x = 0
	name_text_y = 0
	
	update_id = o_console.TEXT_BOX.update_id++
	
	association = undefined
	
	using_color_picker = false
	
	copy = false
	paste = false
	
	att = {} with att {
		draw_box = true // Whether or not the box is drawn around the color
	
		update_when_is_front = true

		length = 3 // Character widths
		
		scoped_color = "output"
		
		allow_input = true // If the color can be edited
		allow_exinput = true // If the color can be changed when the associated variable is
		allow_scoped_exinput = false // If the color can be changed when the associated variable is when scoped
	
		set_variable_on_input = true // Set variable every time theres input, rather than just once it's descoped
	}
}


set_scoped = function(enabled){
	
	if enabled
	{
		
	}
	else
	{
		
	}
}



set_att = function(att){
	self.att = att
	return self
}



set_boundaries = function(){
		
	#region Scaling
	var tb = o_console.TEXT_BOX
	
	draw_set_font(o_console.font)
	var cw = string_width(" ")
	var ch = string_height(" ")
	var asp = ch/tb.char_height
	
	var _text_wdist = floor(tb.text_wdist*asp)
	var _text_hdist = floor(tb.text_hdist*asp)
	#endregion
	
	#region Dragging
	if dragging
	{
		if not mouse_check_button(mb_left) dragging = false
		else
		{		
			x = gui_mx-mouse_xoffset
			y = gui_my-mouse_yoffset
			
			mouse_on = true
			mouse_on_name = true
			
			mouse_on_console = true
		}
	}
	#endregion
	
	#region Defining boundries
	
	left = x
	top = y
	
	box_left = left + (draw_name ? (string_length(name)*cw + _text_wdist*2*att.draw_box) : 0)
	right = box_left + att.length*cw + _text_wdist*2*att.draw_box + cw*(not att.draw_box and draw_name)
	bottom = top + ch + _text_hdist*2*att.draw_box
	
	name_text_x = left + _text_wdist*att.draw_box
	name_text_y = top+1 + _text_hdist*att.draw_box
	#endregion
}


update_variable = function(){ if not is_undefined(variable) {
	
	if is_undefined(variable) return undefined
	
	var _association = is_undefined(association) ? (docked ? dock.association : self) : association
	with _association other.color = variable_string_get(other.variable)
	
	if is_string(color) color = o_console.colors[$ color]
	if not is_numeric(color) color = c_black
}}


undock = function(){
	if is_undefined(association) association = dock.association
}


get_input = function(){

	copy = false
	paste = false
		
	#region Disabled defaulting
	if not enabled
	{
		left = x
		top = y
		right = x
		bottom = y
		
		text_x = x
		text_y = y
		
		mouse_on = false
		clicking = false
		scoped = false
		using_color_picker = false
		
		return undefined
	}
	#endregion
	
	if enabled and right == x set_boundaries()
	
	moved = xprevious != x or yprevious != y
	if dragging or moved set_boundaries()
	
	#region Mouse inputs
	
	var mouse_left_pressed = mouse_check_button_pressed(mb_left)
	var mouse_left = mouse_check_button(mb_left)
	
	if is_undefined(cbox_left)
	{
		var _left = box_left
		var _top = top
		var _right = right
		var _bottom = bottom
	}
	else
	{
		var _left = cbox_left
		var _top = cbox_top
		var _right = cbox_right
		var _bottom = cbox_bottom
	}
	
	if not mouse_on_console and not clicking_on_console and gui_mouse_between(_left, _top, _right, _bottom)
	{
		mouse_on_console = true
		
		if not mouse_on_box
		{
			mouse_on_box = true
			window_set_cursor(cr_handpoint)
		}
	}
	else if mouse_on_box and not clicking
	{
		mouse_on_box = false
		if not using_color_picker window_set_cursor(cr_default)
	}
	
	mouse_on = false
	if mouse_on_box or (not mouse_on_console and not clicking_on_console and gui_mouse_between(left, top, right, bottom))
	{
		mouse_on = true
		mouse_on_console = true
	}
	mouse_on_name = mouse_on and not mouse_on_box
	
	var _association = is_undefined(association) ? (docked ? dock.association : self) : association
	
	var key_super = keyboard_check(vk_super)
	var key_escape_pressed = keyboard_check_pressed(vk_escape)
	var key_enter_pressed = keyboard_check_pressed(vk_enter)
	
	if not (mouse_left_pressed or key_escape_pressed or key_enter_pressed) and clicking and not mouse_left
	{
		clicking = false
		char_mouse = false
	}
	
	if scoped and o_console.keyboard_scope != noone 
	{
		o_console.COLOR_PICKER.global_color_picker = false
		using_color_picker = false
		scoped = false
	}
	
	if clicking clicking_on_console = true

	if mouse_on_name and mouse_left_pressed
	{
		dragging = true
		mouse_xoffset = gui_mx-x
		mouse_yoffset = gui_my-y
		
		o_console.element_dragging = self
		clicking_on_console = true
	}
	#endregion
	
	#region Scope/descope
	if mouse_left_pressed or key_escape_pressed or key_enter_pressed or (using_color_picker and not o_console.COLOR_PICKER.global_color_picker.enabled)
	{	
		if mouse_on_box and mouse_left_pressed and not using_color_picker
		{
			clicking = true
			scoped = true
			using_color_picker = true
			call_color_box_ext(variable, undefined, undefined, self, _association)
		}
		else if scoped and (key_escape_pressed or key_enter_pressed) or (mouse_left_pressed and not o_console.COLOR_PICKER.global_color_picker.mouse_on)
		{
			scoped = false
			using_color_picker = false
			
			if att.allow_input and not is_undefined(variable) with _association variable_string_set(other.variable, other.color)
		}
	}
	#endregion
	
	if using_color_picker
	{
		color = o_console.COLOR_PICKER.global_color_picker.color
		if docked clicking = o_console.COLOR_PICKER.global_color_picker.clicking
	}
	else if (docked and dock.is_front and att.update_when_is_front) or (scoped and att.allow_scoped_exinput) or (not scoped and att.allow_exinput and get_update_turn(update_id))
	{
		update_variable()
	}
	
	#region Keyboard inputs
	if scoped
	{
		if key_super
		{
			copy = keyboard_check_pressed(ord("C"))
			paste = att.allow_input and keyboard_check_pressed(ord("V")) and clipboard_has_text()
		}
		
		if copy clipboard_set_text(color_to_hex(color))
		else if paste
		{
			var color_changed = false
			var clipboard = clipboard_get_text()
			var char = string_char_at(clipboard, 1)
			
			var is_hex
			if char == "$" or char == "#" 
			{
				clipboard = "0x"+string_delete(clipboard, 1, 1)
				is_hex = true
			}
			else is_hex = string_is_float(clipboard) or string_is_float("0x"+clipboard)
			
			if is_hex
			{
				color = hex_to_color(clipboard)
				color_changed = true
			}
			else if not (slice(clipboard, 1, 3, 1) == "0x" or string_digits(clipboard) == "")
			{
				var group = ""
				var r = undefined
				var g = undefined
				var b = undefined
				for(var i = 1; i <= string_length(clipboard); i++)
				{
					var char = string_char_at(clipboard, i)
					if string_is_int(string_char_at(clipboard, i))
					{
						group += char
					}
					else if group != ""
					{	
						if is_undefined(r) r = min(real(group), 255)
						else if is_undefined(g) g = min(real(group), 255)
						else if is_undefined(b) b = min(real(group), 255)
						else break
						group = ""
					}
				}
				if is_undefined(b) and group != "" b = real(group)
				
				if not is_undefined(g) and not is_undefined(b)
				{
					color = make_color_rgb(r, g, b)
					color_changed = true
				}
			}
			
			if color_changed and att.set_variable_on_input and not is_undefined(variable)
			{
				with _association variable_string_set(other.variable, other.color)
			}
		}
	}
	#endregion
	
	xprevious = x
	yprevious = y
}


draw = function(){
	
	if right == x and bottom == y return undefined
	
	var old_color = draw_get_color()
	var old_alpha = draw_get_alpha()
	var old_font = draw_get_font()
	var old_halign = draw_get_halign()
	var old_valign = draw_get_valign()

	draw_set_font(o_console.font)
	var tb = o_console.TEXT_BOX

	var ch = string_height(" ")
	var asp = ch/tb.char_height
	
	var _outline_width = tb.outline_width*asp
	
	if not (docked and not dock.is_front)
	{
		draw_set_color(o_console.colors.body_real)
		draw_rectangle(left, top, box_left, bottom, false)
	}
	draw_set_color(color)
	draw_rectangle(box_left, top, right, bottom, false)
	
	if att.draw_box
	{
		if draw_name and docked
		{
			draw_set_color(o_console.colors.body_accent)
			draw_hollowrect(left, top, right, bottom, _outline_width)
		}
		
		draw_set_color(o_console.colors.body_real)
		draw_hollowrect(box_left, top, right, bottom, _outline_width*2)
		
		if not copy and scoped and att.allow_input	draw_set_color(is_real(att.scoped_color) ? att.scoped_color : o_console.colors[$ att.scoped_color])
		else							draw_set_color(o_console.colors.body_accent)
		draw_hollowrect(box_left, top, right, bottom, _outline_width)
	}
	
	if draw_name
	{
		draw_set_halign(fa_left)
		draw_set_valign(fa_top)
	
		draw_set_color(o_console.colors.output)
		draw_text(name_text_x, name_text_y, name)
	}
	
	draw_set_color(old_color)
	draw_set_alpha(old_alpha)
	draw_set_font(old_font)
	draw_set_halign(old_halign)
	draw_set_valign(old_valign)
}
}