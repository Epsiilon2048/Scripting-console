
function Text_box() constructor{

initialize = function(){
		
	x = 0
	y = 0
	
	draw_box = true
	
	text = ""
	variable = undefined
	value = 0
	scoped = false
	
	mouse_on = false
	clicking = false
	
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
	
	length_min = 1
	length_max = infinity
		
	color_method = noscript
		
	allow_input = true
	allow_external_input = true
	allow_alpha = true
	
	select_all_on_click = false
	
	value_conversion = string
	
	// If not allowing alphabet
	allow_float = true
	allow_negative = true
		
	float_places = 2
	
	value_min = -infinity
	value_max = infinity
	
	incrementor = true
	incrementor_step = 1
	incrementor_curve = animcurvetype_linear
	
	scrubber = false
	scrubber_step = 1
	scrubber_pixels_per_step = 1
	scrubber_curve = animcurvetype_linear
}



mouse_get_char_pos = function(rounding_method){
	
	var old_font = draw_get_font()
	draw_set_font(o_console.font)
	var cw = string_width(" ")
	draw_set_font(old_font)
	
	return clamp( rounding_method((gui_mx-text_x) / cw)-(rounding_method == ceil), 0, string_length(text)+1 )
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
	
	scoped = o_console.keyboard_scope == self
	
	var shift = keyboard_check(vk_shift)
	
	if gui_mouse_between(left, top, right, bottom)
	{
		if not mouse_on
		{
			mouse_on = true
			window_set_cursor(cr_beam)
		}
	}
	else if mouse_on
	{
		mouse_on = false
		window_set_cursor(cr_default)
	}

	dclick_step ++

	if mouse_check_button_pressed(mb_left)
	{	
		if mouse_on
		{
			clicking = true
		
			if (scoped and dclick_step <= tb.dclick_time) or (not scoped and select_all_on_click)
			{
				char_selection = true
				char_pos1 = string_length(text)
				char_pos2 = 1
			}
			else
			{
				char_mouse = true
				char_pos1 = mouse_get_char_pos((sign(char_pos1-char_pos2) == -1) ? floor : ceil)
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
			o_console.keyboard_scope = noone
			scoped = false
		}
	}
	else if clicking and not mouse_check_button(mb_left)
	{
		clicking = false
		char_mouse = false
	}
	else if char_mouse
	{
		char_pos1 = mouse_get_char_pos((sign(char_pos1-char_pos2) == -1) ? floor : ceil)
		char_selection = char_pos1 != char_pos2
	}
	
	if not scoped and not is_undefined(variable)
	{
		if allow_external_input
		{
			value = value_conversion(variable_string_get(variable))
			text = string(value)
		}
		else
		{
			variable_string_set(variable, value)
		}
	}
	
	if scoped and not clicking
	{
		var text_changed = false
		
		if keyboard_check_pressed(vk_left)
		{	
			char_pos1 --
			char_selection = shift

			if not shift
			{
				char_selection = false
				char_pos2 = char_pos1
			}
		}
		if keyboard_check_pressed(vk_right)
		{	
			char_pos1 ++
			char_selection = shift
			
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
		}
		
		char_pos_max = max(char_pos1, char_pos2)
		char_pos_min = min(char_pos1, char_pos2)
		
		if (keyboard_check_pressed(vk_backspace) or (char_selection and keyboard_check_pressed(vk_delete))) and (char_selection or char_pos1 != 0)
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
			keyboard_string = text
			
			char_pos2 = char_pos1
			char_selection = false
			
			text_changed = true
		}
		else if keyboard_check_pressed(vk_delete) and (char_selection or char_pos1 != string_length(text))
		{
			text = string_delete(text, char_pos1+1, 1)
			keyboard_string = text
			
			text_changed = true
		}
		
		if string_length(text) < string_length(keyboard_string)
		{
			var char = slice(keyboard_string, string_length(text)+1, -1, 1)
			
			if char_selection
			{
				text = string_delete(text, char_pos_min+1, char_pos_max-char_pos_min)
				char_pos1 = char_pos_min
				char_selection = false
			}
			
			text = string_insert(char, text, char_pos1+1)
			keyboard_string = text
			char_pos1 += string_length(char)
			char_pos2 = char_pos1
			
			text_changed = true
		}
		
		if text_changed
		{
			value = value_conversion(text)
			
			text_width = cw*clamp(string_length(text), length_min, length_max)
	
			left = x
			top = y
			right = x + text_width + (draw_box ? _text_wdist*2 : 0)
			bottom = y + ch + (draw_box ? _text_hdist*2 : 0)
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
	
		draw_set_color(scoped ? o_console.colors.output : o_console.colors.body_accent)
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
	draw_text(text_x, text_y, text)
	
	if scoped
	{
		var x1 = text_x+cw*char_pos1
		var y1 = text_y
		var y2 = text_y+ch
		
		if char_selection 
		{
			draw_set_alpha(tb.char_selection_alpha)
			draw_rectangle(text_x+cw*char_pos_min, y1, text_x+cw*char_pos_max, y2, false)
			draw_set_alpha(1)
		}
		draw_line(x1, y1, x1, y2)
	}
	if draw_box and string_length(text) > length_max shader_reset()

	draw_set_color(old_color)
	draw_set_alpha(old_alpha)
	draw_set_font(old_font)
	draw_set_halign(old_halign)
	draw_set_valign(old_valign)
}
}