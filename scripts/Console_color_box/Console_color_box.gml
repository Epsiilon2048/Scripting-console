
function Console_color_box() constructor{

initialize = function(variable){
	
	docked = false
	
	name = is_undefined(variable) ? "Text box" : string(variable)
	enabled = true
	
	show_name = true
	
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
	
	att = {} with att {
		draw_box = true // Whether or not the box is drawn around the color
	
		update_when_is_front = true

		length = 2 // Character widths
		
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
	
	box_left = left + (show_name ? (string_length(name)*cw + _text_wdist*2*att.draw_box) : 0)
	right = box_left + att.length*cw + _text_wdist*2*att.draw_box + cw*(not att.draw_box and show_name)
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
		
		return undefined
	}
	#endregion
	
	#region Scaling
	var tb = o_console.TEXT_BOX
	
	draw_set_font(o_console.font)
	var cw = string_width(" ")
	var ch = string_height(" ")
	var asp = ch/tb.char_height
	
	var _text_wdist = floor(tb.text_wdist*asp)
	//var _text_hdist = floor(tb.text_hdist*asp)
	#endregion
	
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
			window_set_cursor((att.scrubber and not typing) ? cr_size_we : cr_beam)
		}
	}
	else if mouse_on_box and not clicking
	{
		mouse_on_box = false
		window_set_cursor(cr_default)
	}
	
	mouse_on = false
	if mouse_on_box or (not mouse_on_console and not clicking_on_console and gui_mouse_between(left, top, right, bottom))
	{
		mouse_on = true
		mouse_on_console = true
	}
	mouse_on_name = mouse_on and not mouse_on_box
	
	var _association = is_undefined(association) ? (docked ? dock.association : self) : association
	if scrubbing and not mouse_left
	{
		if not is_undefined(variable) with _association variable_string_set(other.variable, other.value)
		scrubbing = false
		if not scrubbed and att.select_all_on_click 
		{
			typing = true
			char_pos1 = string_length(text)
			char_pos2 = 0
			char_selection = true
			
			o_console.keyboard_scope = self
			scoped = true
			keyboard_string = text
		}
		scrubbed = false
	}
	
	var key_shift = keyboard_check(vk_shift)
	var key_super = keyboard_check(vk_super)
	var key_escape_pressed = keyboard_check_pressed(vk_escape)
	var key_enter_pressed = keyboard_check_pressed(vk_enter)
	
	if not (mouse_left_pressed or key_escape_pressed or (att.exit_with_enter and key_enter_pressed)) and clicking and not mouse_left
	{
		clicking = false
		char_mouse = false
	}
	else if char_mouse
	{
		char_pos1 = mouse_get_char_pos()
		char_selection = char_pos1 != char_pos2
	}
	
	if scoped and o_console.keyboard_scope != self 
	{
		scoped = false
		if att.scrubber typing = false
	}
	
	if clicking
	{
		clicking_on_console = true
		blink_step = 0
	}

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
	text_changed = false
	dclick_step ++

	if mouse_left_pressed or key_escape_pressed or (att.exit_with_enter and key_enter_pressed)
	{	
		if mouse_on_box and scoped and att.scrubber and not typing and mouse_left_pressed
		{
			scrubbing = true
			mouse_previous = gui_mx
		}
		
		if mouse_on_box and mouse_left_pressed
		{
			clicking = true
		
			if not scoped and att.scrubber 
			{
				scrubbing = true
				mouse_previous = gui_mx
				typing = false
				char_selection = false
				char_pos1 = 0
				char_pos2 = 0
			}
			else if (scoped and not char_selection and dclick_step <= tb.dclick_time*(room_speed/60)) or (not scoped and att.select_all_on_click)
			{
				char_selection = true
				typing = true
				
				if att.allow_alpha
				{
					char_pos1 = string_char_next(tb.word_sep, text, char_pos1, 1)
					char_pos2 = string_char_next(tb.word_sep, text, char_pos1, -1)
					char_pos1 -= string_pos(string_char_at(text, char_pos1), tb.word_sep) != 0
				}
				else
				{
					char_pos1 = string_length(text)
					char_pos2 = 0
				}
				
				window_set_cursor(cr_beam)
			}
			else
			{
				char_mouse = true
				char_pos1 = mouse_get_char_pos()
				if not key_shift char_pos2 = char_pos1
				char_selection = char_pos1 != char_pos2
			}
			
			o_console.keyboard_scope = self
			scoped = true
			keyboard_string = text
			
			dclick_step = 0
		}
		else if scoped
		{
			if o_console.keyboard_scope == self o_console.keyboard_scope = noone
			scoped = false
			if att.scrubber typing = false
			
			if not att.allow_alpha and att.allow_float
			{
				var pos = string_pos(".", text)
				var step_places = float_count_places(scrubber_step, 10)
				
				if pos == 0 and not step_places att.float_places = undefined
				else att.float_places = max(float_count_places(scrubber_step, 10), string_length(text)-string_pos(".", text))
			}
			
			if att.allow_input and not is_undefined(variable) with _association variable_string_set(other.variable, other.value)
		}
	}
	#endregion
	
	if (docked and dock.is_front and att.update_when_is_front) or (scoped and att.allow_scoped_exinput) or (not scoped and att.allow_exinput and get_update_turn(update_id))
	{
		update_variable()
	}
	
	#region Keyboard inputs
	if scoped
	{
		if att.allow_input
		{	
			var rt = tb.repeat_time*(room_speed/60)
			var r = tb.repeat_step mod ((room_speed/60)*2) == 0
			tb.repeat_step ++
		
			var _key_left				= keyboard_check(vk_left)
			var _key_right				= keyboard_check(vk_right)
			var _key_backspace			= keyboard_check(vk_backspace)
			var _key_delete				= keyboard_check(vk_delete)
		
			with tb
			{
				rleft		= (_key_left + rleft)*_key_left
				rright		= (_key_right + rright)*_key_right
				rbackspace	= (_key_backspace + rbackspace)*_key_backspace
				rdel		= (_key_delete + rdel)*_key_delete

				var key_left		= keyboard_check_pressed(vk_left) or (_key_left and (r and rt < rleft))
				var key_right		= keyboard_check_pressed(vk_right) or (_key_right and (r and rt < rright))
				var key_backspace	= keyboard_check_pressed(vk_backspace) or (_key_backspace and (r and rt < rbackspace))
				var key_delete		= keyboard_check_pressed(vk_delete) or (_key_delete and (r and rt < rdel))
			}
		}
		
		var select_all	= false
		var copy		= false
		var paste		= false
		
		if key_super
		{
			select_all	= keyboard_check_pressed(ord("A"))
			copy		= keyboard_check_pressed(ord("C")) and text != ""
			paste		= att.allow_input and keyboard_check_pressed(ord("V")) and clipboard_has_text()
			
			if select_all or paste and (not typing and att.allow_input)
			{
				typing = true
				scrubbing = false
				char_pos1 = string_length(text)
				char_pos2 = 0
				char_selection = true
			}
		}
		
		if (char_selection or not typing) and copy
		{
			if not typing clipboard_set_text(text)
			else clipboard_set_text(slice(text, char_pos_min+1, char_pos_max+1, 1))
			blink_step = 0
		}
		
		if att.scrubber and not typing and (select_all or paste or keyboard_key != vk_nokey)
		{	
			var char = slice(keyboard_string, string_length(text)+1, -1, 1)
			var digits = string_digits(char) != ""
			if digits or key_backspace or key_delete or (sign(att.value_min) == -1 and string_pos("-", char)) or (att.allow_float and string_pos(".", char))
			{
				typing = true
				scrubbing = false
				char_pos1 = string_length(text)
				if digits or key_backspace or key_delete
				{
					char_pos2 = 0
					char_selection = true
				}
				else char_pos2 = char_pos1
				show_debug_message(1)
			}
		}
		
		if not typing and not att.allow_alpha and (key_left or key_right)
		{
			value = clamp(value + att.incrementor_step*(key_right-key_left), att.value_min, att.value_max)
			text = string_format_float(value, att.float_places)
			
			if att.set_variable_on_input and not is_undefined(variable) with _association variable_string_set(other.variable, other.value)
		}
		
		if typing and att.allow_input
		{
			blink_step ++

			if select_all
			{
				char_pos1 = string_length(text)
				char_pos2 = 0
				char_selection = true
				char_mouse = false
				blink_step = 0
			}

			if key_left
			{	
				char_pos1 = key_super ? string_char_next(tb.word_sep, text, char_pos1, -1) : (char_pos1-1)
				char_selection = key_shift
				char_mouse = false
				blink_step = 0

				if not key_shift
				{
					char_selection = false
					char_pos2 = char_pos1
				}
			}
			if key_right
			{	
				char_pos1 = key_super ? string_char_next(tb.word_sep, text, char_pos1, 1) : (char_pos1+1)
				char_selection = key_shift
				char_mouse = false
				blink_step = 0
			
				if not key_shift 
				{
					char_selection = false
					char_pos2 = char_pos1
				}
			}
		
			char_pos_max = max(char_pos1, char_pos2)
			char_pos_min = min(char_pos1, char_pos2)
		
			if att.allow_input
			{
				if paste or (keyboard_lastchar != "" or string_length(text) < string_length(keyboard_string))
				{
					var newtext = text
					var char = ""
					if paste char = clipboard_get_text()
					else char = slice(keyboard_string, string_length(text)+1, -1, 1)
			
					if char_selection newtext = string_delete(newtext, char_pos_min+1, char_pos_max-char_pos_min)
			
					if not att.allow_alpha 
					{
						if sign(att.value_min) == -1 and string_pos("-", char)
						{
							char_pos1 = char_pos_min
							
							if string_char_at(newtext, 1) == "-" 
							{
								newtext = string_delete(newtext, 1, 1)
								char_pos1 --
							}
							else 
							{
								newtext = "-"+newtext
								char_pos1 ++
							}
							char_pos_min = char_pos1
							text_changed = true
						}
						if att.allow_float and string_pos(".", char)
						{
							char_pos1 = char_pos_min
							var pos = string_pos(".", newtext)
							if pos == 0 pos = infinity
							newtext = string_delete(newtext, pos, 1)
							newtext = string_insert(".", newtext, char_pos1+(char_pos1 < pos))
							char_pos1 += (char_pos1 < pos)
							char_pos_min = char_pos1
							text_changed = true
						}
						char = string_digits(char)
					}
				
					if att.lock_text_length and (string_length(char)+string_length(newtext)) > att.length_max
					{
						var overlap = -(att.length_max-(string_length(char)+string_length(newtext)))
					
						if sign(overlap) != -1 char = ""
						else char = slice(char, 1, overlap, 1)
					}
					
					if att.char_filter != noscript char = att.char_filter(char)
					
					if text_changed or char != ""
					{
						char_pos1 = char_pos_min
						char_selection = false
						
						if not att.allow_alpha and char != "" and (newtext == "0" or newtext == "-0")
						{
							newtext = (newtext == "-0") ? "-" : ""
							char_pos1 --
						}
						
						text = string_insert(char, newtext, char_pos1+1)
						char_pos1 += string_length(char)
						char_pos2 = char_pos1
						text_changed = true
					}
					keyboard_string = text
				}
		
				if (key_backspace or (char_selection and key_delete)) and (char_selection or char_pos1 != 0)
				{
					if char_selection
					{
						text = string_delete(text, char_pos_min+1, char_pos_max-char_pos_min)
						char_pos1 = char_pos_min
					}
					else 
					{
						text = string_delete(text, char_pos1, 1)
						char_pos1 --
					}
					char_pos2 = char_pos1
					char_selection = false
					text_changed = true
				}
				else if key_delete and (char_selection or char_pos1 != string_length(text))
				{
					text = string_delete(text, char_pos1+1, 1)
					text_changed = true
				}
		
				if text_changed
				{
					if not att.allow_alpha
					{
						if not string_is_float(text)
						{
							text = "0"
							char_pos1 = 1
							char_pos2 = char_pos1
							char_selection = false
						}
						else
						{
							text = string_format_float(clamp(real(text), att.value_min, att.value_max), att.float_places)
						}
					}
				
					convert(text)
					
					if att.set_variable_on_input and not is_undefined(variable) with _association variable_string_set(other.variable, other.value)
			
					text_width = cw*clamp(string_length(text), att.length_min, att.length_max)
	
					right = box_left + text_width + (att.draw_box ? _text_wdist*2 : 0)
				
					char_mouse = false
				
					colors = att.color_method(text)
					blink_step = 0
					keyboard_string = text
				}
			}
		}
 		else if scrubbing
		{
			if abs(gui_mx-mouse_previous) >= att.scrubber_pixels_per_step
			{
				value = clamp(value + floor((gui_mx-mouse_previous)/att.scrubber_pixels_per_step)*scrubber_step, att.value_min, att.value_max)
				mouse_previous = gui_mx
				scrubbed = true
				
				if not att.allow_float value = floor(value)
				text = string_format_float(value, att.float_places)
				
				if att.set_variable_on_input and not is_undefined(variable) with _association variable_string_set(other.variable, other.value)
				
				set_boundaries()
			}
		}
	}
	
	char_pos1 = clamp(char_pos1, 0, string_length(text))
	char_pos2 = clamp(char_pos2, 0, string_length(text))
	
	char_pos_max = max(char_pos1, char_pos2)
	char_pos_min = min(char_pos1, char_pos2)
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

	var cw = string_width(" ")
	var ch = string_height(" ")
	
	if att.draw_box
	{
		var asp = ch/tb.char_height
	
		var _text_wdist = floor(tb.text_wdist*asp)
		var _text_hdist = floor(tb.text_hdist*asp)
		var _outline_width = tb.outline_width*asp
	
		if not (docked and not dock.is_front)
		{
			draw_set_color(o_console.colors.body_real)
			
			if docked draw_rectangle(left, top, box_left, bottom, false)
			else
			{
				draw_rectangle(left, top, box_left, bottom, false)
				draw_console_body(box_left, top, right, bottom)
			}
		}
	
		if show_name and docked
		{
			draw_set_color(o_console.colors.body_accent)
			draw_hollowrect(left, top, right, bottom, _outline_width)
		}
	
		if scoped and att.allow_input draw_set_color(is_real(att.scoped_color) ? att.scoped_color : o_console.colors[$ att.scoped_color])
		else draw_set_color(o_console.colors.body_accent)
		draw_hollowrect(box_left, top, right, bottom, _outline_width)
	}
	else
	{
		var _text_wdist = 0
		var _text_hdist = 0
	}
	
	draw_set_color(o_console.colors.body_accent)
	draw_set_halign(fa_left)
	draw_set_valign(fa_top)
	
	if show_name
	{
		draw_set_color(o_console.colors.output)
		draw_text(name_text_x, text_y, name)
	}
	
	if ((text == "") ? string_length(initial_ghost_text) : string_length(text)) > att.length_max clip_rect_cutout(box_left, top, right, bottom)
	
	if text != ""
	{
		if att.color_method != noscript and is_struct(colors) draw_color_text(text_x, text_y, colors)
		else
		{
			draw_set_color(is_numeric(att.text_color) ? att.text_color : o_console.colors[$ att.text_color])
			draw_text(text_x, text_y, text)
		}
	}
	else if initial_ghost_text != ""
	{
		draw_set_color(o_console.colors.body_accent)
		draw_text(text_x, text_y, initial_ghost_text)
	}
	
	draw_set_color(o_console.colors[$ att.text_color])
	if scoped and typing and o_console.keyboard_scope == self
	{
		var x1 = text_x+cw*char_pos1
		var y1 = text_y
		var y2 = text_y+ch-1
		
		if char_selection and char_pos1 != char_pos2
		{
			draw_set_alpha(tb.char_selection_alpha)
			draw_rectangle(text_x+cw*char_pos_min, y1, text_x+cw*char_pos_max, y2, false)
			draw_set_alpha(1)
		}
	}
	if string_length(text) > att.length_max shader_reset()
	if scoped and typing and att.allow_input and x1 < right+1 and not floor((blink_step/(tb.blink_time*(room_speed/60))) mod 2) draw_line(x1, y1-1, x1, y2)

	draw_set_color(old_color)
	draw_set_alpha(old_alpha)
	draw_set_font(old_font)
	draw_set_halign(old_halign)
	draw_set_valign(old_valign)
}
}