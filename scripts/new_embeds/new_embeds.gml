
#macro cbox_true  "[x]"
#macro cbox_false "[ ]"
#macro cbox_NaN	  "[/]"

function Embedded_text() constructor{

set = function(text) {

	static _colors_list			= ds_list_create()
	static _clickable_list		= ds_list_create()
	static _subclickable_list	= ds_list_create()
	
	delete self.colors		
	delete self.clickable	
	delete self.subclickable
	
	var _text = variable_struct_exists_get(text, "o", text)
	
	_text = is_array(_text) ? _text : [ is_undefined(_text) ? "" : _text ]

	self.plaintext = ""
	self.colortext = ""
	self.width = 0
	self.height = 0
	self.mouse_index = -1
	self.click_index = -1

	var _width = 0
	var _click_id = 0
	
	for(var i = 0; i <= array_length(_text)-1; i++) 
	{
		var _str
		var _clickable = false
		var cbox_length = 0
		var cbox_space = ""

		if is_struct(_text[i])
		{
			_str = variable_struct_exists_get(_text[i], "str", variable_struct_exists_get(_text[i], "s", ""))
			var _newlines = string_count("\n", _str)
		
			var s = {}

			_clickable = (
				variable_struct_exists(_text[i], "func") or 
				variable_struct_exists(_text[i], "vari") or
				variable_struct_exists(_text[i], "cbox") or 
				variable_struct_exists(_text[i], "outp") or
				
				variable_struct_exists(_text[i], "checkbox") or
				variable_struct_exists(_text[i], "outout") or
				variable_struct_exists(_text[i], "scr")
			)
			   
			s.func	= variable_struct_exists_get(_text[i], "func",	noscript	)
			s.vari	= variable_struct_exists_get(_text[i], "vari",	""			)
			s.cbox	= variable_struct_exists_get(_text[i], "cbox",	""			)

			s.arg	= variable_struct_exists_get(_text[i], "arg",	undefined	)
			s.args	= variable_struct_exists_get(_text[i], "args",	[s.arg]		)
			s.outp	= variable_struct_exists_get(_text[i], "outp",	false		)
			
			//original names, kept for backwards compatability
			if s.cbox == ""			s.cbox	= variable_struct_exists_get(_text[i], "checkbox",	"")
			if s.outp == false		s.outp	= variable_struct_exists_get(_text[i], "output",	false)
			if s.func == noscript	s.func	= variable_struct_exists_get(_text[i], "scr",		noscript)
			
			cbox_length = (s.cbox != "") ? string_length(cbox_true) : 0
			cbox_space = (s.cbox != "") ? string_repeat(" ", string_length(cbox_true)) : ""
			
			if _clickable
			{
				var j = 1
				
				if _newlines
				{ 
					while string_char_at(_str, j) == "\n"
					{
						_width = 0
						j++
					}
				}
				
				s.x  = _width
				s.y  = self.height
				s.id = _click_id
				
				if _newlines
				{
					var line_split = string_split("\n", _str)
					
					s.length = string_length(line_split[0]) + cbox_length
					
					for(var j = 1; j <= array_length(line_split)-1; j++)
					{
						if line_split[j] != "" ds_list_add(_subclickable_list, {
							id: _click_id,
							y:	s.y+j,
							length: string_length(line_split[j]),
						})
					}
				}
				else s.length = string_length(_str) + cbox_length
			
				ds_list_add(_clickable_list, s)
			}
		
			if _clickable or variable_struct_exists(_text[i], "col")
			{
				var col = variable_struct_exists_get(_text[i], "col", "embed")
				
				ds_list_add(_colors_list, {
					x: _width,
					y: self.height,
					id: _clickable ? _click_id++ : -1,
					str: _str,
					col: col,
					cbox: s.cbox,
				})
			}
		
			if not _newlines self.colortext += string_repeat(" ", string_length(_str) + cbox_length)
			else 
			{ //ughhhhhhhhhh im soooo tired of this part im just gonna go with the really garbage way of doing it
				var _colorstr = cbox_space
				
				for(var j = 1; j <= string_length(_str); j++)
				{
					if string_char_at(_str, j) == "\n"
					{
						_colorstr += "\n"
					}
					else _colorstr += " "
				}
				
				self.colortext += _colorstr
			}
		}
		else
		{
			_str = string(_text[i])
			var _newlines = string_count("\n", _str)
			self.colortext += _str
		}
		
		self.plaintext += ((_clickable and s.cbox != "") ? cbox_NaN : "") + _str
		
		self.height += _newlines
	
		_width = (_newlines ? 0 : _width) + (string_length(_str) - string_last_pos("\n", _str)) + cbox_length
	}

	self.colors			= ds_list_to_array(_colors_list)
	self.clickable		= ds_list_to_array(_clickable_list)
	self.subclickable	= ds_list_to_array(_subclickable_list)

	self.height += 1
	self.width = string_width(self.plaintext)/string_width(" ")

	ds_list_clear(_colors_list)
	ds_list_clear(_clickable_list)
	ds_list_clear(_subclickable_list)
	}
}




function draw_embedded_text(x, y, text, plaintext_color, alpha){

var cw = string_width (" ")
var ch = string_height(" ")

var old_halign = draw_get_halign()
var old_valign = draw_get_valign()
var old_alpha = draw_get_alpha()

if is_undefined(alpha) alpha = 1

draw_set_align(fa_left, fa_top)
draw_set_alpha(alpha)

var set_text = false
var plain_col = is_undefined(plaintext_color) ? o_console.colors.output : plaintext_color

draw_set_color(plain_col)
if not is_struct(text)
{
	draw_text(x, y, text)
	draw_set_align(old_halign, old_valign)
	return undefined
}
else if not o_console.embed_text
{
	draw_text(x, y, text.plaintext)
	draw_set_align(old_halign, old_valign)
	return undefined
}

draw_text(x, y, text.colortext)

var mouse_on = gui_mouse_between(x, y, x+text.width*cw, y+text.height*ch)
var mouse_on_item = false

text.mouse_index = -1

if mouse_on
{
	for(var j = 0; j <= array_length(text.subclickable)-1; j++)
	{
		var c = text.subclickable[j]
		
		if gui_mouse_between(
			x,
			y + c.y*ch,
			x + c.length*cw,
			y + c.y*ch + ch
		){
			text.mouse_index = c.id
			break
		}
	}
	
	for(var i = 0; i <= array_length(text.clickable)-1; i++)
	{
		var c = text.clickable[i]

		if text.mouse_index == c.id or (c.length and gui_mouse_between(
			x + c.x*cw, 
			y + c.y*ch,
			x + (c.x + c.length)*cw,
			y + c.y*ch + ch
		)){
			text.mouse_index = c.id
			
			if mouse_check_button_pressed(mb_left)
			{
				text.click_index = c.id
			}
			else if text.click_index == c.id and not mouse_check_button(mb_left)
			{
				text.click_index = -1
			
				//Run method
				o_console.run_in_embed = true
				var _output = script_execute_ext_builtin(c.func, c.args)
				o_console.run_in_embed = false
				
				//Set variable
				variable_string_set(c.vari, c.arg)
			
				//Set checkbox
				var _check = variable_string_get(c.cbox)
				if is_numeric(_check) variable_string_set(c.cbox, not _check)
			
				//Set output
				set_text = c.outp
			}
		
			if not mouse_check_button(mb_left) and text.click_index == c.id text.click_index = -1
		
			mouse_on_item = true
		}
		else 
		{
			if text.mouse_index == c.id text.mouse_index = -1
			if not mouse_check_button(mb_left) and text.click_index == c.id text.click_index = -1
		}
	}
}
else 
{
	text.mouse_index = -1
	
	if not mouse_check_button(mb_left) text.click_index = -1
}

for(var i = 0; i <= array_length(text.colors)-1; i++)
{
	var c = text.colors[i]
	var _col
	
	if is_string(c.col)
	{
		if		c.id != -1 and text.click_index == c.id								_col = o_console.colors.plain
		else if c.id != -1 and text.click_index == -1 and text.mouse_index == c.id	_col = o_console.colors.embed_hover
		else if variable_struct_exists(o_console.colors, c.col)						_col = o_console.colors[$ c.col]
		else																		_col = plain_col
	}
	else _col = c.col
	
	var nl = string_pos("\n", c.str)
	var cbox = ""
	
	if c.cbox != ""
	{
		var cbox_value = variable_string_get(c.cbox)
		
		if is_numeric(cbox_value) cbox = cbox_value ? cbox_true : cbox_false
		else cbox = cbox_NaN
	}
	
	draw_set_color(_col)
	draw_text(
		x + c.x*cw, y + c.y*ch, 
		cbox + (nl ? string_copy(c.str, 1, nl-1) : c.str),
	)
	
	if nl draw_text(
		x, y + c.y*ch + ch,
		string_copy(c.str, nl+1, string_length(c.str)),
	)
}

if set_text text.set(_output)

draw_set_align(old_halign, old_valign)
draw_set_alpha(old_alpha)
return mouse_on
}