
function new_text_box(name, variable){
var text_box = new Console_text_box()
text_box.initialize(variable)

if not is_undefined(name) text_box.name = name
text_box.draw_name = not is_undefined(name)

return text_box
}


function new_display_box(name, variable, draw_box){
var text_box = new_text_box(name, variable)
text_box.att.allow_input = false
text_box.att.draw_box = draw_box
text_box.att.length_min = 0
text_box.att.select_all_on_click = true

return text_box
}


function new_static_display_box(name, text, draw_box){
var text_box = new_display_box(name, undefined, draw_box)
text_box.value = text
text_box.text = text

return text_box
}



function new_scrubber(name, variable, step){
var text_box = new Console_text_box()
text_box.initialize_scrubber(variable, step)

if not is_undefined(name) text_box.name = name
text_box.draw_name = not is_undefined(name)
return text_box
}



function new_value_box(name, variable, is_scrubber, scrubber_step, length_min, length_max, value_min, value_max, allow_float, float_places){
var s = new_scrubber(name, variable, scrubber_step)
s.att.text_color = "plain"
s.att.scrubber = is_scrubber
s.att.value_min = value_min
s.att.value_max = value_max
s.att.length_min = length_min
s.att.length_max = length_max
s.att.allow_float = allow_float
s.att.float_places = float_places
return s
}


function Console_text_box() constructor{

format_console_element()

initialize = function(variable){
	
	docked = false
	
	name = is_undefined(variable) ? "Text box" : string(variable)
	enabled = true
	
	draw_name = true
	
	x = 0
	y = 0
	xprevious = 0
	yprevious = 0
	moved = true
	
	text = ""
	initial_ghost_text = ""
	self.variable = variable
	variable_exists = variable_string_exists(variable)
	value = ""
	scoped = false
	
	mouse_on = false
	mouse_on_name = false
	mouse_on_box = false
	clicking = false
	dragging = false
	
	mouse_xoffset = 0
	mouse_yoffset = 0
	
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
	copy = false
	paste = false
	
	char_pos_max = 0
	char_pos_min = 0
	
	text_width = 0
	blink_step = 0
	
	left = 0
	top = 0
	right = 0
	bottom = 0
	
	box_left = 0
	box_right = 0
	
	cbox_left = undefined
	cbox_top = undefined
	cbox_right = undefined
	cbox_bottom = undefined
	
	text_x = 0
	text_y = 0
	
	name_text_x = 0
	
	colors = undefined
	
	allow_printing = true
	instant_update = false
	
	scrubbed = false
	
	update_id = o_console.TEXT_BOX.update_id++
	
	convert = function(value){
		try{
			self.value = value_conversion(value)
		}
		catch(_){
			self.value = undefined
		}
	}
	
	error = false
	
	association = undefined
	
	added_float_places = 0
	
	enter_func = noscript
	char_filter = noscript
	color_method = noscript // The script used to color the string
	value_conversion = string // How the value is converted from the text
	autofill_method = noscript
	
	att = {} with att {
		draw_box = true // Whether or not the box is drawn around the text
	
		// The length of the box itself
		length_min = 7
		length_max = infinity
		lock_text_length = false // Whether or not the text can be longer than the max length
	
		exit_with_enter = true // If pressing enter descopes
	
		text_color = "plain"
		scoped_color = "output"
		error_color = dt_real

		allow_input = true // If the text can be edited
		allow_exinput = true // If the text can be changed when the associated variable is
		allow_scoped_exinput = false // If the text can be changed when the associated variable is when scoped
		allow_alpha = true // Alphabetical
		allow_dragging = true
		
		select_all_on_click = false
	
		set_variable_on_input = true // Set variable every time theres input, rather than just once it's descoped
	
		// If not allowing alphabet
		allow_float = true
		
		float_places = undefined
	
		value_min = -infinity
		value_max = infinity
	
		incrementor_step = 1
	
		scrubber = false // The mouse scrubbing the value
		scrubber_step = 1
		scrubber_pixels_per_step = 10
	}
	
	update_variable()
}


initialize_scrubber = function(variable, step){

	initialize(variable)

	if is_undefined(step) scrubber_step = 1
	else scrubber_step = step

	typing = false
	value = 0
	
	value_conversion = real
	att.incrementor_step = scrubber_step
	att.float_places = ((scrubber_step mod 1) == 0) ? undefined : float_count_places(scrubber_step, 10)
	att.length_min = 4
	att.length_max = infinity
	att.scrubber = true
	att.select_all_on_click = false
	att.allow_alpha = false
	att.set_variable_on_input = true
	att.scoped_color = dt_real
}


set_name = function(name){
self.name = name
set_boundaries()
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



mouse_get_char_pos = function(){
	
	var old_font = draw_get_font()
	draw_set_font(o_console.font)
	var cw = string_width("W")
	draw_set_font(old_font)
	
	return clamp( floor((gui_mx-text_x+3) / cw), 0, string_length(text)+1 )
}



set_boundaries = function(){
		
	#region Scaling
	var tb = o_console.TEXT_BOX
	
	draw_set_font(o_console.font)
	var cw = string_width("W")
	var ch = string_height("W")
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
	text_width = clamp(string_width_oneline(text), att.length_min*cw, att.length_max*cw)
	
	left = x
	top = y
	
	if docked and dock_element_x > 0 and instanceof(dock.elements[@ dock_element_y, dock_element_x-1]) == "Console_text_box"
	{
		var left_el = dock.elements[@ dock_element_y, dock_element_x-1]
		if not left_el.draw_name left = left_el.right + (att.draw_box ? 1 : cw)
	}
	
	box_left = left + (draw_name ? (string_width_oneline + _text_wdist*2*att.draw_box) : 0)
	right = box_left + text_width + _text_wdist*2*att.draw_box + cw*(not att.draw_box and draw_name)
	bottom = top + ch + _text_hdist*2*att.draw_box
	
	name_text_x = left + _text_wdist*att.draw_box
	
	text_x = box_left + _text_wdist*att.draw_box + cw*(not att.draw_box and draw_name)
	text_y = top+1 + _text_hdist*att.draw_box
	
	if not att.scrubber or (not docked or (docked and (att.allow_dragging and dock.allow_element_dragging))) box_right = right
	else box_right = min(right, text_x+max(cw, string_width_oneline(text))+_text_wdist/2)
	#endregion
}


update_variable = function(){ if not is_undefined(variable) {
	
	error = false
	
	if is_undefined(variable) 
	{
		variable_exists = false
		return undefined
	}
	
	var old_text = text
	var _association = is_undefined(association) ? (docked ? dock.association : self) : association
	
	var var_info = {exists: false}
	with _association var_info = variable_string_info(other.variable)
	variable_exists = var_info.exists
	
	if variable_exists
	{
		if not att.allow_alpha and not is_numeric(var_info.value) var_info.value = NaN
		convert(var_info.value)
	
		var places = undefined
		if is_numeric(value) places = is_undefined(att.float_places) ? float_count_places(value, max(3, added_float_places)) : att.float_places+added_float_places
	
		if not att.allow_alpha
		{
			if not is_numeric(value) or is_nan(value)
			{
				text = "NaN"
				value = NaN
			}
			else 
			text = string_format_float(value, places)
		}
		else 
		{
			text = string_format_float(value, places)
		}
	}
	else
	{
		value = undefined
		error = true
		text = "!"
	}
	
	if att.lock_text_length and string_length(text) > att.length_max text = slice(text, 1, att.length_max+1, 1)
	
	if old_text != text 
	{
		if scoped o_console.AUTOFILL.show = false
		colors = color_method(text)
	}

	set_boundaries()
}}



get_printout = function(){
	update_variable()
	if not allow_printing return undefined
	else if is_string(variable) return variable+" = "+text+";"
	else return text
}



undock = function(){
	if is_undefined(association) association = dock.association
}



generate_ctx_menu = function(){

var m = [
	new_ctx_text("Settings", function(){clipboard_set_text(get_printout())}),
]

return m
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
		
		text_changed = false
		mouse_on = false
		clicking = false
		
		char_pos2 = char_pos1
		char_pos_selection = false
		
		if scoped
		{
			scoped = false
			if att.scrubber typing = false
			if o_console.keyboard_scope == self o_console.keyboard_scope = noone
		}
		return undefined
	}
	#endregion
	
	#region Scaling
	var tb = o_console.TEXT_BOX
	
	draw_set_font(o_console.font)
	var cw = string_width("W")
	var ch = string_height("W")
	var asp = ch/tb.char_height
	
	var _text_wdist = floor(tb.text_wdist*asp)
	var _text_hdist = floor(tb.text_hdist*asp)
	#endregion
	
	moved = xprevious != x or yprevious != y
	if dragging or moved or right == x set_boundaries()
	
	#region Mouse inputs
	
	var mouse_left_pressed = mouse_check_button_pressed(mb_left)
	var mouse_left = mouse_check_button(mb_left)
	
	if is_undefined(cbox_left)
	{
		var _left = box_left
		var _top = top
		var _right = box_right
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

			if not error and att.scrubber and not typing window_set_cursor(cr_size_we)
			else window_set_cursor(cr_beam)
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
			keyboard_key = vk_nokey
		}
		scrubbed = false
	}
	
	var key_shift = keyboard_check(vk_shift)
	var key_super = keyboard_check(vk_super)
	var key_escape_pressed = keyboard_check_pressed(vk_escape)
	var key_enter_pressed = keyboard_check_pressed(vk_enter)
	
	if key_enter_pressed and scoped enter_func()
	if not (mouse_left_pressed or key_escape_pressed or (att.exit_with_enter and key_enter_pressed)) and clicking and not mouse_left
	{
		clicking = false
		char_mouse = false
	}
	else if char_mouse
	{
		char_pos1 = mouse_get_char_pos()
		char_selection = char_pos1 != char_pos2 and not (char_pos2 == char_pos1-1 and char_pos1 == string_length(text)+1)
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

	if mouse_on_name and mouse_left_pressed and att.allow_dragging and (not docked or dock.allow_element_dragging)
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
		if mouse_on_box and scoped and att.scrubber and not typing and mouse_left_pressed and not error
		{
			scrubbing = true
			mouse_previous = gui_mx
		}
		
		if mouse_on_box and mouse_left_pressed
		{
			clicking = true
		
			if not error and not scoped and att.scrubber and not error
			{
				scrubbing = true
				mouse_previous = gui_mx
				typing = false
				char_selection = false
				char_pos1 = 0
				char_pos2 = 0
			}
			else if (scoped and not char_selection and dclick_step <= tb.dclick_time*(room_speed/60)) or (not scoped and (error or att.select_all_on_click))
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
				char_selection = char_pos1 != char_pos2 and not (char_pos2 == char_pos1-1 and char_pos1 == string_length(text)+1)
			}
			
			o_console.keyboard_scope = self
			scoped = true
			keyboard_string = text
			keyboard_key = vk_nokey
			
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
			}
			
			if att.allow_input and not is_undefined(variable) with _association variable_string_set(other.variable, other.value)
			update_variable()
		}
	}
	#endregion
	
	if (not scoped and docked and dock.is_front) or (scoped and att.allow_scoped_exinput and not typing) or (not scoped and att.allow_exinput and (instant_update or get_update_turn(update_id)))
	{
		update_variable()
	}
	
	#region Keyboard inputs
	if scoped
	{
		var _key_left		= false
		var _key_right		= false
		var _key_backspace	= false
		var _key_delete		= false
		var key_left		= false
		var key_right		= false
		var key_backspace	= false
		var key_delete		= false
		
		if not error and att.allow_input
		{	
			var rt = tb.repeat_time*(room_speed/60)
			var r = tb.repeat_step mod ((room_speed/60)*2) == 0
			tb.repeat_step ++
		
			_key_left				= keyboard_check(vk_left)
			_key_right				= keyboard_check(vk_right)
			_key_backspace			= keyboard_check(vk_backspace)
			_key_delete				= keyboard_check(vk_delete)
		
			with tb
			{
				rleft		= (_key_left + rleft)*_key_left
				rright		= (_key_right + rright)*_key_right
				rbackspace	= (_key_backspace + rbackspace)*_key_backspace
				rdel		= (_key_delete + rdel)*_key_delete

				key_left		= keyboard_check_pressed(vk_left) or (_key_left and (r and rt < rleft))
				key_right		= keyboard_check_pressed(vk_right) or (_key_right and (r and rt < rright))
				key_backspace	= keyboard_check_pressed(vk_backspace) or (_key_backspace and (r and rt < rbackspace))
				key_delete		= keyboard_check_pressed(vk_delete) or (_key_delete and (r and rt < rdel))
			}
		}
		
		var select_all	= false
		
		if key_super
		{
			select_all	= keyboard_check_pressed(ord("A"))
			copy		= keyboard_check_pressed(ord("C")) and text != ""
			paste		= not error and att.allow_input and keyboard_check_pressed(ord("V")) and clipboard_has_text()
			
			if select_all or paste and (not typing and not error and att.allow_input)
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
		
		if not error and att.scrubber and not typing and (select_all or paste or keyboard_key != vk_nokey)
		{	
			var char = slice(keyboard_string, string_length(text)+1, -1, 1)
			var digits = string_digits(char) != ""
			if digits or key_backspace or key_delete or ((sign(att.value_min) == -1 or sign(value) == -1) and string_pos("-", char)) or (att.allow_float and string_pos(".", char))
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
			if value mod att.incrementor_step != 0
			{
				if key_left value -= value mod att.incrementor_step
				else value += att.incrementor_step - (value mod att.incrementor_step)
				
			}
			else value = clamp(value + att.incrementor_step*(key_right-key_left), att.value_min, att.value_max)
			text = string_format_float(value, att.float_places)
			added_float_places = 0
			
			if att.set_variable_on_input and not is_undefined(variable) with _association variable_string_set(other.variable, other.value)
		}
		
		if typing and not error and att.allow_input
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
		
			if not error and att.allow_input
			{
				if paste or (keyboard_key != vk_nokey or string_length(text) < string_length(keyboard_string))
				{				
					if not att.allow_alpha and not string_is_float(text)
					{
						text = ""
					}
					
					var newtext = text
					var char = ""
					if paste char = clipboard_get_text()
					char += slice(keyboard_string, string_length(text)+1, -1, 1)
			
					if char_selection newtext = string_delete(newtext, char_pos_min+1, char_pos_max-char_pos_min)
				
					for(var i = 1; i <= string_length(char); i++)
					{
						var num = ord(string_char_at(char, i))
						if 32 > num or num > 126 char = string_delete(char, i, 1)
					}
			
					if not att.allow_alpha 
					{
						if char == "i"
						{
							newtext = infinity*signbool(string_char_at(newtext, 1) != "-")
						}
						if (sign(att.value_min) == -1 or sign(value) == -1) and string_pos("-", char)
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
							char = string_delete(char, string_pos(".", char), 1)
							var pos = string_pos(".", newtext)
							
							if char_pos1 == 0 and string_char_at(newtext, 1) == "-" 
							{
								char_pos1 = 1
								char_pos_min = char_pos1
							}
							
							if char_pos1+1 == pos
							{
								char_pos1 = ++char_pos_min
								text_changed = true
							}
							else if char_pos1 != pos or char_pos1 == 0
							{
								char_pos1 = char_pos_min
								
								if pos
								{
									newtext = string_delete(newtext, pos, 1)
									char_pos1 -= char_pos1 > pos
								}
								newtext = string_insert(".", newtext, char_pos1+1)
							
								char_pos1 ++

								char_pos_min = char_pos1
								text_changed = true
							}
						}
						char = string_digits(char)
						if char_pos1 == 0 and char != "" and string_char_at(newtext, 1) == "-" 
						{
							char_pos1 = 1
							char_pos_min = char_pos1
						}
					}
				
					if att.lock_text_length and (string_length(char)+string_length(newtext)) > att.length_max
					{
						var overlap = -(att.length_max-(string_length(char)+string_length(newtext)))
					
						if sign(overlap) != -1 char = ""
						else char = slice(char, 1, overlap, 1)
					}
					
					if char_filter != noscript char = char_filter(char)
					
					if text_changed or char != ""
					{
						char_pos1 = char_pos_min
						char_selection = false
						
						if not att.allow_alpha and char != "" and (newtext == "0" or newtext == "-0")
						{
							newtext = (newtext == "-0") ? "-" : ""
							char_pos1 --
						}
						
						if is_infinity(newtext) text = string(newtext)
						else text = string_insert(char, newtext, char_pos1+1)
						char_pos1 += string_length(string(char))
						char_pos2 = char_pos1
						text_changed = true
						
						if string_pos(string_last(char), o_console.refresh_sep) 
						{
							o_console.AUTOFILL.show = false
						}
					}
					keyboard_string = text
					keyboard_key = vk_nokey
				}
		
				if (key_backspace or (char_selection and key_delete)) and (char_selection or char_pos1 != 0)
				{
					if char_selection
					{
						text = string_delete(text, char_pos_min+1, char_pos_max-char_pos_min)
						text = string_delete(text, char_pos_min+1, char_pos_max-char_pos_min)
						char_pos1 = char_pos_min
					}
					else if key_super
					{
						var prev = max(1, string_char_next(tb.word_sep, text, char_pos1, -1))
						text = string_delete(text, prev, char_pos1-prev+1+(prev == 0))
						char_pos1 = prev+1-(char_pos1 != 1)*2
					}
					else 
					{
						text = string_delete(text, min(char_pos1, string_length(text)), 1)
						char_pos1 --
					}
					char_pos2 = char_pos1
					char_selection = false
					text_changed = true
				}
				else if key_delete and (char_selection or char_pos1 != string_length(text))
				{
					if key_super
					{
						var next = max(1, string_char_next(tb.word_sep, text, char_pos1+1, 1))
						text = string_delete(text, char_pos1+1, next-char_pos1)
					}
					else text = string_delete(text, char_pos1+1, 1)
					text_changed = true
				}
		
				if text_changed
				{	
					var _value = text
					if not att.allow_alpha
					{
						if text = "" or text == "-" or text == "." or text == "-."
						{
							_value = "0"
						}
						else if not string_is_float(text)
						{
							text = "0"
							char_pos1 = 1
							char_pos2 = char_pos1
							char_selection = false
							_value = text
						}
						else
						{
							var remove = 0
							if string_char_at(text, 1) == "." remove = 1
							else if (slice(text, 1, 3, 1) == "-.") remove = 2
							
							added_float_places = max(0, float_count_places(real(text), 8) - (is_undefined(att.float_places) ? 0 : att.float_places))
							
							text = string_delete(string_format_float(clamp(real(text), att.value_min, att.value_max), float_count_places(real(text), 8)) + (string_last(text) == "." ? "." : ""), remove, 1)
							_value = text
						}
					}
				
					convert(_value)
					
					if att.set_variable_on_input and not is_undefined(variable) with _association variable_string_set(other.variable, other.value)
			
					//text_width = clamp(string_width_oneline(text), att.length_min*cw, att.length_max*cw)
	
					right = box_left + text_width + (att.draw_box ? _text_wdist*2 : 0)
				
					char_mouse = false
				
					colors = color_method(text)
					blink_step = 0
					keyboard_string = text
					keyboard_key = vk_nokey
					
					if autofill_method != noscript
					{
						autofill_method(text, char_pos1)
						o_console.AUTOFILL.show = true
						o_console.AUTOFILL.x = left
						o_console.AUTOFILL.y = top - _text_hdist
					}
					
					set_boundaries()
				}
			}
		}
 		else if scrubbing and abs(gui_mx-mouse_previous) >= att.scrubber_pixels_per_step
		{
			if not is_numeric(value) or is_nan(value) value = 0
				
			value = clamp(value + floor((gui_mx-mouse_previous)/att.scrubber_pixels_per_step)*att.scrubber_step, att.value_min, att.value_max)
			mouse_previous = gui_mx
			scrubbed = true
				
			added_float_places = 0
				
			if not att.allow_float value = floor(value)
			text = string_format_float(value, att.float_places)
				
			if att.set_variable_on_input and not is_undefined(variable) with _association variable_string_set(other.variable, other.value)
			
			text_changed = true
			
			set_boundaries()
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

	var cw = string_width("W")
	var ch = string_height("W")
	
	if att.draw_box
	{
		var asp = ch/tb.char_height
	
		var _text_wdist = floor(tb.text_wdist*asp)
		var _text_hdist = floor(tb.text_hdist*asp)
		var _outline_width = tb.outline_width*asp
	
		if not att.scrubber or (not docked or (docked and (att.allow_dragging and dock.allow_element_dragging)))
		{
			if not (docked and not dock.is_front)
			{
				draw_set_color(o_console.colors.body_real)
			
				if docked draw_rectangle(left, top, (dragging ? right : box_left), bottom, false)
				else
				{
					draw_rectangle(left, top, box_left, bottom, false)
					draw_console_body(box_left, top, right, bottom)
				}
			}
	
			if draw_name and docked
			{
				draw_set_color(o_console.colors.body_accent)
				draw_hollowrect(left, top, right, bottom, _outline_width)
			}
	
			if not copy and scoped and att.allow_input draw_set_color(is_numeric(att.scoped_color) ? att.scoped_color : o_console.colors[$ att.scoped_color])
			else draw_set_color(o_console.colors.body_accent)
			draw_hollowrect(box_left, top, right, bottom, _outline_width)
		}
		else
		{
			var _left = text_x-_text_wdist/2
			
			if not copy and scoped draw_set_color(is_numeric(att.scoped_color) ? att.scoped_color : o_console.colors[$ att.scoped_color])
			else draw_set_color(o_console.colors.body_accent)
			
			if string_length(text) > att.length_max
			{
				draw_rectangle(_left, bottom, box_right-_outline_width*2.5, bottom-_outline_width*2-1, false)
				draw_rectangle(box_right-_outline_width, bottom, box_right, bottom-_outline_width*2-1, false)
			}
			else draw_rectangle(_left, bottom, box_right, bottom-_outline_width*2-1, false)
		}
	}
	else
	{
		var _text_wdist = 0
		var _text_hdist = 0
	}
	
	draw_set_color(o_console.colors.body_accent)
	draw_set_halign(fa_left)
	draw_set_valign(fa_top)
	
	if draw_name
	{
		draw_set_color(o_console.colors.output)
		draw_text(name_text_x, text_y, name)
	}
	
	if ((text == "") ? (string_length(initial_ghost_text) > att.length_min) : (string_length(text) > att.length_max)) clip_rect_cutout(box_left, top, right, bottom)
	
	if text != ""
	{
		if color_method != noscript and is_struct(colors) draw_color_text(text_x, text_y, colors)
		else
		{
			var col = error ? att.error_color : att.text_color
			
			draw_set_color(is_numeric(col) ? col : o_console.colors[$ col])
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
	if shader_current() != -1 shader_reset()
	if scoped and typing and not error and att.allow_input and x1 < right+1 and not floor((blink_step/(tb.blink_time*(room_speed/60))) mod 2) draw_line(x1, y1-1, x1, y2)

	draw_set_color(old_color)
	draw_set_alpha(old_alpha)
	draw_set_font(old_font)
	draw_set_halign(old_halign)
	draw_set_valign(old_valign)
}
}