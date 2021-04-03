
function Embedded_text() constructor{

set = function(text) {

	static _colors_list			= ds_list_create()
	static _clickable_list		= ds_list_create()
	static _subclickable_list	= ds_list_create()
	static _dynamic_list		= ds_list_create()
	
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

		if is_struct(_text[i])
		{
			_str = variable_struct_exists_get(_text[i], "str", "")
			var _newlines = string_count("\n", _str)
		
			if variable_struct_exists(_text[i], "cbox") _str = _str + "[/]"
		
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
					
					s.length = string_length(line_split[0])
					
					for(var j = 1; j <= array_length(line_split)-1; j++)
					{
						if line_split[j] != "" ds_list_add(_subclickable_list, {
							id: _click_id,
							y:	s.y+j,
							length: string_length(line_split[j]),
						})
					}
				}
				else s.length = string_length(_str)
			
				ds_list_add(_clickable_list, s)
			}
		
			if _clickable or variable_struct_exists(_text[i], "col")
			{
				var col = variable_struct_exists_get(_text[i], "col", "embed")
				
				ds_list_add(_colors_list, {
					x: _width,
					y: self.height,
					str: _str,
					col: col,
					id: _clickable ? _click_id++ : -1,
				})
			}
		
			if not _newlines self.colortext += string_repeat(" ", string_length(_str))
			else 
			{ //ughhhhhhhhhh im soooo tired of this part im just gonna go with the really garbage way of doing it
				var _colorstr = ""
				
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
		
		self.plaintext += _str
		
		self.height += _newlines
	
		_width = (_newlines ? 0 : _width) + string_length( 
			string_copy( 
				_str, 
				string_pos_pop("\n", _str), 
				string_length(_str) 
			)
		) - (_newlines > 0)
	}

	self.colors			= ds_list_to_array(_colors_list)
	self.clickable		= ds_list_to_array(_clickable_list)
	self.subclickable	= ds_list_to_array(_subclickable_list)
	self.dynamic		= ds_list_to_array(_dynamic_list)

	self.height += 1
	self.width = string_width(self.plaintext)/string_width(" ")

	ds_list_clear(_colors_list)
	ds_list_clear(_clickable_list)
	ds_list_clear(_subclickable_list)
	ds_list_clear(_dynamic_list)
	}
}

function draw_embedded_text(x, y, text){

var cw = string_width (" ")
var ch = string_height(" ")

var prev_halign = draw_get_halign()
var prev_valign = draw_get_valign()
draw_set_align(fa_left, fa_top)

var _col = o_console.colors.output

draw_set_color(_col)
if not is_struct(text)
{
	draw_text(x, y, text,) //_col, _col, _col, _col, 1)
	draw_set_align(prev_halign, prev_valign)
	return false
}

draw_text(x, y, text.colortext,)// _col, _col, _col, _col, 1)

var mouse_on = gui_mouse_between(x, y, x+text.width*cw, y+text.height*ch)
var mouse_on_item = false

text.mouse_index = -1

if mouse_on
{
	var i = 0
	
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
			i = c.id
			break
		}
	}
	
	for(; i <= array_length(text.clickable)-1; i++)
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
				var _check	= variable_string_get(c.cbox)
				if is_numeric(_check) variable_string_set(c.cbox, not _check)
			
				//Set output
				if c.outp 
				{
					if keyboard_check(vk_shift) output_set(_output)
					else
					{
						text.set(_output)
						exit
					}
				}
			}
		
			if not mouse_check_button(mb_left) and text.click_index == c.id text.click_index = -1
		
			mouse_on_item = true
			break
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
		if text.click_index == c.id _col = o_console.colors.plain
		else if text.click_index == -1 and text.mouse_index == c.id _col = o_console.colors.embed_hover
		else _col = o_console.colors[$ c.col]
	}
	else _col = c.col
	
	var nl = string_pos("\n", c.str)
	
	draw_text_color(
		x + c.x*cw, y + c.y*ch, 
		(nl ? string_copy(c.str, 1, nl-1) : c.str),
		_col, _col, _col, _col, 1
	)
	
	if nl draw_text_color(
		x, y + c.y*ch + ch,
		string_copy(c.str, nl+1, string_length(c.str)),
		_col, _col, _col, _col, 1
	)
}

draw_set_align(prev_halign, prev_valign)
return mouse_on
}