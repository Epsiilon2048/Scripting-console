
function Text_box() constructor{

initialize = function(){
		
	x = 0
	y = 0
	
	text = ""
	variable = undefined
	value = 0
	scoped = false
	
	mouse_on = false
	clicking = false
	typing = false
	scrubbing = false
	
	mouse_previous = 0
	
	scroll = 0
	
	dclick_step = 0
	
	char_pos1 = 0
	char_pos2 = 0
	char_selection = false
	char_mouse = false
	
	char_pos_max = 0
	char_pos_min = 0
	
	text_width = 0
	blink_step = 0
	
	left = 0
	top = 0
	right = 0
	bottom = 0
	
	text_x = 0
	text_y = 0
	
	colors = undefined
	
	
	draw_box = true // Whether or not the box is drawn around the text
	
	// The length of the box itself
	length_min = 1
	length_max = infinity
	lock_text_length = false // Whether or not the text can be longer than the max length
	
	exit_with_enter = true // If pressing enter descopes
	
	color_method = noscript // The script used to color the string
		
	allow_input = true // If the text can be edited
	allow_external_input = true // If the text can be changed when the associated variable is
	allow_alpha = true // Alphabetical
	
	select_all_on_click = false
	
	set_variable_on_input = false // Set variable every time theres input, rather than just once it's descoped
	
	value_conversion = string // How the value is converted from the text
	
	// If not allowing alphabet
	allow_float = true
	allow_negative = true
		
	float_places = 2
	
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
	
	text_width = cw*clamp(string_length(text), length_min, length_max)
	
	left = x
	top = y
	right = x + text_width + (draw_box ? _text_wdist*2 : 0)
	bottom = y + ch + (draw_box ? _text_hdist*2 : 0)
	
	text_x = draw_box ? x+_text_wdist : x
	text_y = draw_box ? y+_text_hdist : y
	
	var shift = keyboard_check(vk_shift)
	
	if gui_mouse_between(left, top, right, bottom)
	{
		if not mouse_on
		{
			mouse_on = true
			window_set_cursor(scrubber ? cr_size_we : cr_beam)
		}
	}
	else if mouse_on and not clicking
	{
		mouse_on = false
		window_set_cursor(cr_default)
	}

	dclick_step ++

	if scrubbing and not mouse_check_button(mb_left) 
	{
		if not is_undefined(variable) variable_string_set(variable, value)
		scrubbing = false
	}

	if mouse_check_button_pressed(mb_left) or keyboard_check_pressed(vk_escape) or (exit_with_enter and keyboard_check_pressed(vk_enter))
	{	
		if mouse_on and scoped and scrubber and not typing and mouse_check_button_pressed(mb_left)
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
		
			if not scoped and scrubber 
			{
				scrubbing = true
				mouse_previous = gui_mx
				typing = false
				char_selection = false
				char_pos1 = 0
				char_pos2 = 0
			}
			else if (scoped and not char_selection and dclick_step <= tb.dclick_time*(room_speed/60)) or (not scoped and select_all_on_click)
			{
				char_selection = true
				typing = true
				char_pos1 = string_length(text)
				char_pos2 = 0
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
	
	if clicking blink_step = 0
	
	if not scoped and allow_external_input and not is_undefined(variable)
	{
		value = value_conversion(variable_string_get(variable))
		text = string(value)
	}
	
	if scoped
	{
		if scrubber and not typing and keyboard_key != vk_nokey
		{
			show_debug_message(1)
			typing = true
			scrubbing = false
			char_pos1 = string_length(text)
			char_pos2 = 0
			char_selection = true
		}
		
		if typing
		{
			blink_step ++
			var text_changed = false
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
		
			if allow_input
			{
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
		
				var paste = keyboard_check_multiple_pressed(vk_control, ord("V")) and clipboard_has_text()
		
				if paste or string_length(text) < string_length(keyboard_string)
				{
					var char 
					if paste char = clipboard_get_text()
					else char = slice(keyboard_string, string_length(text)+1, -1, 1)
			
					if char_selection
					{
						text = string_delete(text, char_pos_min+1, char_pos_max-char_pos_min)
						char_pos1 = char_pos_min
						char_selection = false
					}
			
					if not allow_alpha 
					{
						if allow_negative and string_pos("-", char)
						{
							if string_char_at(text, 1) == "-" 
							{
								text = string_delete(text, 1, 1)
								char_pos1 --
							}
							else 
							{
								text = "-"+text
								char_pos1 ++
							}
							text_changed = true
						}
						if allow_float and string_pos(".", char)
						{
							text = string_delete(text, string_pos(".", text), 1)
							text = string_insert(".", text, char_pos1+1)
							char_pos1 ++
							text_changed = true
						}
						char = string_digits(char)
					}
				
					if lock_text_length and (string_length(char)+string_length(text)) > length_max
					{
						var overlap = -(length_max-(string_length(char)+string_length(text)))
					
						if sign(overlap) != -1 char = ""
						else char = slice(char, 1, overlap, 1)
					}
				
					show_debug_message(char == "")
					if char != ""
					{			
						text = string_insert(char, text, char_pos1+1)
						char_pos1 += string_length(char)
						char_pos2 = char_pos1
						text_changed = true
					}
					keyboard_string = text
				}
		
				if text_changed
				{
					if not allow_alpha and text == "" 
					{
						text = "0"
					}
					
					keyboard_string = text
				
					value = value_conversion(text)
					if set_variable_on_input and not is_undefined(variable) variable_string_set(variable, value)
			
					text_width = cw*clamp(string_length(text), length_min, length_max)
	
					left = x
					top = y
					right = x + text_width + (draw_box ? _text_wdist*2 : 0)
					bottom = y + ch + (draw_box ? _text_hdist*2 : 0)
				
					char_mouse = false
				
					if color_method != noscript
					{
						colors = color_method(text)
					}
					blink_step = 0
				}
			}
		}
		else if scrubbing
		{
			if abs(gui_mx-mouse_previous) >= scrubber_pixels_per_step
			{
				value += floor((gui_mx-mouse_previous)/scrubber_pixels_per_step)*scrubber_step
				mouse_previous = gui_mx
			
				if not allow_float value = floor(value)
				text = string_format_float(value, float_places)
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

	if draw_box
	{
		var cw = string_width(" ")
		var ch = string_height(" ")
		var asp = ch/tb.char_height
	
		var _text_wdist = floor(tb.text_wdist*asp)
		var _text_hdist = floor(tb.text_hdist*asp)
	
		draw_set_color(o_console.colors.body_real)
		draw_rectangle(left, top, right, bottom, false)
	
		draw_set_color((scoped and allow_input) ? o_console.colors.output : o_console.colors.body_accent)
		draw_rectangle(left+1, top+1, right-1, bottom-1, true)
	}
	else
	{
		var cw = string_width(" ")
		var _text_wdist = 0
		var _text_hdist = 0
	}
	
	draw_set_color(o_console.colors.plain)
	draw_set_halign(fa_left)
	draw_set_valign(fa_top)
	if draw_box and string_length(text) > length_max clip_rect_cutout(left, top, right, bottom)
	if color_method != noscript and is_struct(colors) draw_console_text(text_x, text_y, colors)
	else draw_text(text_x, text_y, text)
	
	if scoped and typing
	{
		var x1 = text_x+cw*char_pos1
		var y1 = text_y
		var y2 = text_y+ch
		
		if char_selection and char_pos1 != char_pos2
		{
			draw_set_alpha(tb.char_selection_alpha)
			draw_rectangle(text_x+cw*char_pos_min, y1, text_x+cw*char_pos_max, y2, false)
			draw_set_alpha(1)
		}
		if allow_input and not floor((blink_step/(tb.blink_time*(room_speed/60))) mod 2) draw_line(x1, y1-1, x1, y2)
	}
	if draw_box and string_length(text) > length_max shader_reset()

	draw_set_color(old_color)
	draw_set_alpha(old_alpha)
	draw_set_font(old_font)
	draw_set_halign(old_halign)
	draw_set_valign(old_valign)
}
}