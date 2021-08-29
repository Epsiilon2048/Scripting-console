
function Text_box() constructor{

set_value = function(text){

	self.text = text
	if not att.allow_alpha and not string_is_float(text) text = "0"

	convert(text)

	if att.allow_alpha
	{
		if not att.allow_negative value = abs(value)
		if not att.allow_float value = round(value)
	}
}



initialize = function(variable){
	
	format_for_dock(undefined)
	
	x = 0
	y = 0
	
	text = ""
	self.variable = variable
	value = 0
	scoped = false
	
	mouse_on = false
	clicking = false
	typing = true
	scrubbing = false
	
	mouse_previous = 0
	
	scroll = 0
	
	dclick_step = 0
	
	char_pos1 = 0
	char_pos2 = 0
	char_selection = false
	char_mouse = false
	
	text_changed = false
	
	char_pos_max = 0
	char_pos_min = 0
	
	text_width = 0
	blink_step = 0
	
	left = 0
	top = 0
	right = 0
	bottom = 0
	
	cbox_left = undefined
	cbox_top = undefined
	cbox_right = undefined
	cbox_bottom = undefined
	
	text_x = 0
	text_y = 0
	
	colors = undefined
	
	convert = function(value){
		try{
			self.value = att.value_conversion(value)
		}
		catch(_){
			self.value = undefined
		}
	}
	
	att = {} with att {
		draw_box = true // Whether or not the box is drawn around the text
	
		// The length of the box itself
		length_min = 1
		length_max = infinity
		lock_text_length = false // Whether or not the text can be longer than the max length
	
		exit_with_enter = true // If pressing enter descopes
	
		text_color = undefined
		scoped_color = "output"
		color_method = noscript // The script used to color the string
		
		allow_input = true // If the text can be edited
		allow_exinput = true // If the text can be changed when the associated variable is
		allow_scoped_exinput = false // If the text can be changed when the associated variable is when scoped
		allow_alpha = true // Alphabetical
	
		select_all_on_click = false
	
		set_variable_on_input = false // Set variable every time theres input, rather than just once it's descoped
	
		value_conversion = string // How the value is converted from the text
	
		// If not allowing alphabet
		allow_float = true
		allow_negative = true
		
		float_places = undefined
		whole_places = 0
	
		value_min = -infinity
		value_max = infinity
	
		incrementor = true // Up/down buttons on the side
		incrementor_step = 1
		incrementor_curve = animcurvetype_linear
	
		scrubber = false // The mouse scrubbing the value
		scrubber_step = 1
		scrubber_pixels_per_step = 10
		scrubber_curve = animcurvetype_linear
	}
}



initialize_scrubber = function(variable, step){

	initialize(variable)

	if is_undefined(step) att.scrubber_step = 1
	else att.scrubber_step = step

	typing = false
	
	att.float_places = ((att.scrubber_step mod 1) == 0) ? undefined : float_count_places(att.scrubber_step, 10)
	att.length_min = 4
	att.length_max = infinity
	att.scrubber = true
	att.select_all_on_click = true
	att.allow_alpha = false
	att.value_conversion = real
	att.set_variable_on_input = true
	att.text_color = dt_real
	att.scoped_color = dt_real
}



mouse_get_char_pos = function(){
	
	var old_font = draw_get_font()
	draw_set_font(o_console.font)
	var cw = string_width(" ")
	draw_set_font(old_font)
	
	return clamp( floor((gui_mx-text_x+3) / cw), 0, string_length(text)+1 )
}



get_input = function(){
	
	var tb = o_console.TEXT_BOX
	
	draw_set_font(o_console.font)
	var cw = string_width(" ")
	var ch = string_height(" ")
	var asp = ch/tb.char_height
	
	var _text_wdist = floor(tb.text_wdist*asp)
	var _text_hdist = floor(tb.text_hdist*asp)
	
	text_width = cw*clamp(string_length(text), att.length_min, att.length_max)
	
	left = x
	top = y
	
	if docked and not is_undefined(dock_element_x) and dock_element_x > 0 and instanceof(dock.elements[@ dock_element_y, dock_element_x-1]) == "Text_box"
	{
		var left_el = dock.elements[@ dock_element_y, dock_element_x-1]
		left = left_el.right+1
	}
	
	right = left + text_width + (att.draw_box ? _text_wdist*2 : 0)
	bottom = top + ch + (att.draw_box ? _text_hdist*2 : 0)
	
	text_x = att.draw_box ? left+_text_wdist : left
	text_y = att.draw_box ? top+_text_hdist+1 : top+1
	
	text_changed = false
	
	var shift = keyboard_check(vk_shift)
	
	if is_undefined(cbox_left)
	{
		var _left = left
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
		
		if not mouse_on
		{
			mouse_on = true
			window_set_cursor((att.scrubber and not typing) ? cr_size_we : cr_beam)
		}
	}
	else if mouse_on and not clicking
	{
		mouse_on = false
		if not clicking_on_console and not mouse_on_console window_set_cursor(cr_default)
	}

	dclick_step ++

	if scrubbing and not mouse_check_button(mb_left)
	{
		if not is_undefined(variable) variable_string_set(variable, value)
		scrubbing = false
	}

	if mouse_check_button_pressed(mb_left) or keyboard_check_pressed(vk_escape) or (att.exit_with_enter and keyboard_check_pressed(vk_enter))
	{	
		if mouse_on and scoped and att.scrubber and not typing and mouse_check_button_pressed(mb_left)
		{
			scrubbing = true
			mouse_previous = gui_mx
		}
		
		if mouse_on and mouse_check_button_pressed(mb_left)
		{
			clicking = true
			
			tb.rleft		= 0
			tb.rright		= 0
			tb.rbackspace	= 0
			tb.rdel			= 0
		
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
				char_pos1 = string_length(text)
				char_pos2 = 0
				
				window_set_cursor(cr_beam)
			}
			else
			{
				char_mouse = true
				char_pos1 = mouse_get_char_pos()
				if not shift char_pos2 = char_pos1
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
				var step_places = float_count_places(att.scrubber_step, 10)
				
				if pos == 0 and not step_places att.float_places = undefined
				else att.float_places = max(float_count_places(att.scrubber_step, 10), string_length(text)-string_pos(".", text))
			}
			
			if not is_undefined(variable) variable_string_set(variable, value)
		}
	}
	else if clicking and not mouse_check_button(mb_left)
	{
		clicking = false
		char_mouse = false
	}
	else if char_mouse
	{
		char_pos1 = mouse_get_char_pos()
		char_selection = char_pos1 != char_pos2
	}
	
	if scoped and o_console.keyboard_scope != self scoped = false
	
	if clicking 
	{
		clicking_on_console = true
		blink_step = 0
	}
	
	if (not scoped and att.allow_exinput) or (scoped and att.allow_scoped_exinput) and not is_undefined(variable)
	{
		convert(variable_string_get(variable))
		text = string_format_float(value, att.float_places, att.whole_places)
		colors = att.color_method(text)
	}
	
	if scoped
	{
		var rt = tb.repeat_time*(room_speed/60)
		
		tb.rleft		= (keyboard_check(vk_left)+tb.rleft)*keyboard_check(vk_left)
		tb.rright		= (keyboard_check(vk_right)+tb.rright)*keyboard_check(vk_right)
		tb.rbackspace	= (keyboard_check(vk_backspace)+tb.rbackspace)*keyboard_check(vk_backspace)
		tb.rdel			= (keyboard_check(vk_delete)+tb.rdel)*keyboard_check(vk_delete)
		
		var r = tb.repeat_step mod (2*(room_speed/60)) == 0
		tb.repeat_step ++
		
		var key_left		= (r and rt < tb.rleft) or keyboard_check_pressed(vk_left)
		var key_right		= (r and rt < tb.rright) or keyboard_check_pressed(vk_right)
		var key_backspace	= (r and rt < tb.rbackspace) or keyboard_check_pressed(vk_backspace)
		var key_delete		= (r and rt < tb.rdel) or keyboard_check_pressed(vk_delete)
		
		
		if att.scrubber and not typing and keyboard_key != vk_nokey
		{	
			var char = slice(keyboard_string, string_length(text)+1, -1, 1)
			var digits = string_digits(char) != ""
			if digits or key_backspace or key_delete or (att.allow_negative and string_pos("-", char)) or (att.allow_float and string_pos(".", char))
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
			}
		}
		
		
		if not typing and not att.allow_alpha and (key_left or key_right)
		{
			value += att.incrementor_step*(key_right-key_left)
			text = string_format_float(value, att.float_places, att.whole_places)
			
			if att.set_variable_on_input and not is_undefined(variable) variable_string_set(variable, value)
		}
		
		
		if typing
		{
			blink_step ++
		
			if key_left
			{	
				char_pos1 --
				char_selection = shift
				char_mouse = false
				blink_step = 0

				if not shift
				{
					char_selection = false
					char_pos2 = char_pos1
				}
			}
			if key_right
			{	
				char_pos1 ++
				char_selection = shift
				char_mouse = false
				blink_step = 0
			
				if not shift 
				{
					char_selection = false
					char_pos2 = char_pos1
				}
			}
			if keyboard_check_multiple_pressed(vk_control, ord("A"))
			{
				char_pos1 = string_length(text)
				char_pos2 = 0
				char_selection = true
				char_mouse = false
				blink_step = 0
			}
		
			char_pos_max = max(char_pos1, char_pos2)
			char_pos_min = min(char_pos1, char_pos2)
		
			if char_selection and keyboard_check_multiple_pressed(vk_control, ord("C"))
			{
				clipboard_set_text(slice(text, char_pos_min+1, char_pos_max+1, 1))
				blink_step = 0
			}
		
			if att.allow_input
			{
				var paste = keyboard_check_multiple_pressed(vk_control, ord("V")) and clipboard_has_text()
		
				if paste or string_length(text) < string_length(keyboard_string)
				{
					var newtext = text
					var char 
					if paste char = clipboard_get_text()
					else char = slice(keyboard_string, string_length(text)+1, -1, 1)
			
					if char_selection newtext = string_delete(newtext, char_pos_min+1, char_pos_max-char_pos_min)
			
					if not att.allow_alpha 
					{
						if att.allow_negative and string_pos("-", char)
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
					if not att.allow_alpha and not string_is_float(text)
					{
						text = "0"
						char_pos1 = 1
						char_pos2 = char_pos1
						char_selection = false
					}
					
					keyboard_string = text
				
					convert(text)
					if att.set_variable_on_input and not is_undefined(variable) variable_string_set(variable, value)
			
					text_width = cw*clamp(string_length(text), att.length_min, att.length_max)
	
					left = x
					top = y
					right = x + text_width + (att.draw_box ? _text_wdist*2 : 0)
					bottom = y + ch + (att.draw_box ? _text_hdist*2 : 0)
				
					char_mouse = false
				
					colors = att.color_method(text)
					blink_step = 0
				}
			}
		}
		else if scrubbing
		{
			if abs(gui_mx-mouse_previous) >= att.scrubber_pixels_per_step
			{
				value += floor((gui_mx-mouse_previous)/att.scrubber_pixels_per_step)*att.scrubber_step
				mouse_previous = gui_mx
				
				if not att.allow_float value = floor(value)
				text = string_format_float(value, att.float_places)
				
				if att.set_variable_on_input and not is_undefined(variable) variable_string_set(variable, value)
			}
		}
	}
	
	char_pos1 = clamp(char_pos1, 0, string_length(text))
	char_pos2 = clamp(char_pos2, 0, string_length(text))
	
	char_pos_max = max(char_pos1, char_pos2)
	char_pos_min = min(char_pos1, char_pos2)
}



draw = function(){
	
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
	
		draw_set_color(o_console.colors.body_real)
		draw_rectangle(left, top, right, bottom, false)
	
		if scoped and att.allow_input draw_set_color(is_real(att.scoped_color) ? att.scoped_color : o_console.colors[$ att.scoped_color])
		else draw_set_color(o_console.colors.body_accent)
		draw_hollowrect(left, top, right, bottom, _outline_width)
	}
	else
	{
		var _text_wdist = 0
		var _text_hdist = 0
	}
	
	var is_front = true //not docked or (docked and dock.is_front)
	
	draw_set_color(is_front ? o_console.colors.plain : o_console.colors.body_accent)
	draw_set_halign(fa_left)
	draw_set_valign(fa_top)
	if string_length(text) > att.length_max clip_rect_cutout(left, top, right, bottom)
	if is_front and att.color_method != noscript and is_struct(colors) draw_console_text(text_x, text_y, colors)
	else
	{
		if is_front and not is_undefined(att.text_color) draw_set_color(is_numeric(att.text_color) ? att.text_color : o_console.colors[$ att.text_color])
		draw_text(text_x, text_y, text)
	}
	
	if scoped and typing
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
	if scoped and typing and att.allow_input and x1 < right and not floor((blink_step/(tb.blink_time*(room_speed/60))) mod 2) draw_line(x1, y1-1, x1, y2)

	draw_set_color(old_color)
	draw_set_alpha(old_alpha)
	draw_set_font(old_font)
	draw_set_halign(old_halign)
	draw_set_valign(old_valign)
}
}



function new_text_box(variable){
var text_box = new Text_box()
text_box.initialize(variable)
return text_box
}

function new_scrubber(variable, step){
var text_box = new Text_box()
text_box.initialize_scrubber(variable, step)
return text_box
}