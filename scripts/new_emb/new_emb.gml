
function Embedded_text() constructor{

set = function(text) {
	//nm	name of struct variable
	//ne	value if struct variable doesn't exist
	//cl	makes text clickable

	static _colors_list		= ds_list_create()
	static _clickable_list	= ds_list_create()
	static _dynamic_list	= ds_list_create()

	var _text = is_array(text) ? text : [text]

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
				variable_struct_exists(_text[i], "cbox")
			)
			   
			s.func	= variable_struct_exists_get(_text[i], "func",	noscript	)
			s.vari	= variable_struct_exists_get(_text[i], "vari",	""			)
			s.cbox	= variable_struct_exists_get(_text[i], "cbox",	""			)
			
			s.str	= variable_struct_exists_get(_text[i], "str",	""			)
			s.arg	= variable_struct_exists_get(_text[i], "arg",	undefined	)
			s.args	= variable_struct_exists_get(_text[i], "args",	[s.arg]		)
			s.outp	= variable_struct_exists_get(_text[i], "outp",	false		)
				 
			if _clickable
			{
				s.x = _width
				s.y = self.height
				s.id = _click_id
				
				s.length = not _newlines ? string_length(_str) : string_length(
					string_copy(
						_str,
						1,
						string_pos(_str, "\n")-1
					)
				)
			
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
			{
				var _colorstr = ""
				
				for(var j = 1; j <= string_length(_str); j++)
				{
					if string_char_at(_str, j) == "\\" and string_char_at(_str, j) == "\n"
					{
						_colorstr += "\n"
						j += 2
					}
					else _colorstr += " "
				}
				
				self.colortext += _colorstr
			}
		}
		else
		{
			_str = is_string(_text[i]) ? _text[i] : string(_text[i])
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

	self.colors		= ds_list_to_array(_colors_list)
	self.clickable	= ds_list_to_array(_clickable_list)
	self.dynamic	= ds_list_to_array(_dynamic_list)

	self.height += 1
	self.width = string_width(self.plaintext)/string_width(" ")

	ds_list_clear(_colors_list)
	ds_list_clear(_clickable_list)
	ds_list_clear(_dynamic_list)
	}
}

function draw_embedded_text_new(x, y, text){

var cw = string_width (" ")
var ch = string_height(" ")

var prev_halign = draw_get_halign()
var prev_valign = draw_get_valign()
draw_set_align(fa_left, fa_top)

var _col = o_console.colors.output

if not is_struct(text)
{
	draw_text_color(x, y, text, _col, _col, _col, _col, 1)
	draw_set_align(prev_halign, prev_valign)
	return false
}

draw_text_color(x, y, text.colortext, _col, _col, _col, _col, 1)

var mouse_on = gui_mouse_between(x, y, x+text.width*cw, y+text.height*ch)

var i = (text.click_index == -1) ? 0 : text.click_index

if mouse_on for(; i <= array_length(text.clickable)-1; i++)
{
	var c = text.clickable[i]
	
	if gui_mouse_between(
		x + c.x*cw, 
		y + c.y*ch,
		x + (c.x + c.length)*cw,
		y + c.y*ch + ch
	)
	{
		text.mouse_index = c.id
		if mouse_check_button_pressed(mb_left)
		{
			text.click_index = c.id
		}
		else if text.click_index == c.id and not mouse_check_button(mb_left)
		{
			text.click_index = -1
			
			//Run method
			var _output = script_execute_ext_builtin(c.func, c.args)
			
			//Set variable
			variable_string_set(c.vari, c.arg)
			
			//Set checkbox
			var _check	= variable_string_get(c.cbox)
			if is_numeric(_check) variable_string_set(c.cbox, not _check)
			
			//Set output
			if c.outp output_set(_output)
		}
		
		if not mouse_check_button(mb_left) and text.click_index == c.id text.click_index = -1
		break
	}
	else 
	{
		if text.mouse_index == c.id text.mouse_index = -1
		if not mouse_check_button(mb_left) and text.click_index == c.id text.click_index = -1
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
		string_copy(c.str, nl+2, string_length(c.str)),
		_col, _col, _col, _col, 1
	)
}

draw_set_align(prev_halign, prev_valign)
return mouse_on
}