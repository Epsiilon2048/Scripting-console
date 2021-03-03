// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function draw_embedded_text(x, y, text, plain){
//pretty messy, ill clean it up at some point lol
//only supports alignment top left :(

if is_string(text) text = [text]

var col = draw_get_color()

draw_set_font(o_console.font)
draw_set_halign(fa_left)
draw_set_valign(fa_top)
draw_set_color(c_white)

var line_width  = 0
var line_height = 0
var char		= 0

if is_undefined(plain) plain = embedded_text_get_plain(text)

var mouse_over	= false

var mouse_char = 0

var clicking = false

var scr = -1
var arg  = undefined
var args = []
var func = -1
var output = false
var scr_return = undefined
var checkvar = ""
var check = false
var _check = undefined

if gui_mouse_between(x, y, x+string_width(plain), y+string_height(plain)) 
{
	mouse_char = text_char_at(global.gui_mx, global.gui_my, x, y, plain)
}

for(var i = 0; i <= array_length(text)-1; i++)
{
	var _str	  =  variable_struct_exists_get(text[i], "str",			text[i])
	var _col	  =  variable_struct_exists_get(text[i], "col",			col)
	var _scr	  =  variable_struct_exists_get(text[i], "scr",			-1)
	var _func	  =  variable_struct_exists_get(text[i], "func",		-1)
	var _linkcol  =  variable_struct_exists_get(text[i], "linkcol",		o_console.colors.embed)
	var _scrcol   =  variable_struct_exists_get(text[i], "scrcol",		o_console.colors.embed_hover)
	var _arg	  =  variable_struct_exists_get(text[i], "arg",			undefined)
	var _args	  =  variable_struct_exists_get(text[i], "args",		[])
	var _output   =  variable_struct_exists_get(text[i], "output",		false)
	var _checkbox =  variable_struct_exists_get(text[i], "checkbox",	"")
	
	if _checkbox != "" 
	{
		_check = variable_string_get(_checkbox)
	
		var _checkstr = ""
		
		if _check != 1 and _check != 0 _checkstr = "[/]"
		else if _check			_checkstr = "[x]"
		else					_checkstr = "[ ]"

		_str = _checkstr+_str
	}

	if _scr != -1 or _func != -1 or _checkbox != ""
	{
		_col = _linkcol
		
		if char < mouse_char and mouse_char < char + string_length(_str)+(string_pos("\n", _str) != 1)
		{
			_col = _scrcol
			mouse_over = true
			//window_set_cursor(cr_handpoint)
		
			if not clicking and mouse_check_button_pressed(mb_left) 
			{
				clicking = true
			
				scr		 = _scr
				arg		 = _arg
				args	 = _args
				func	 = _func
				output	 = _output
				checkvar = _checkbox
				check	 = _check
			}
		}
	}
	
	var _list = string_split_keep("\n", _str)
	draw_set_color(_col)

	for(var j = 0; j <= array_length(_list)-1; j++)
	{
		draw_text(x+line_width, y+line_height, _list[j])
		line_width += string_width(_list[j])
		char += string_length(_list[j])-string_count("\n", _list[j])
		
		if string_count("\n", _list[j])
		{
			line_width  =  0
			line_height += string_height(" ")
		}
	}
}

if checkvar != ""
{
	variable_string_set(checkvar, not check)
}

if scr != -1
{
	o_console.run_in_embed = true
	
	try
	{
		if arg != undefined scr_return = scr(arg)
		else				scr_return = script_execute_ext(scr, args)
	}
	
	o_console.run_in_embed = false
}

if func != -1	scr_return = func()

if output 
{
	output_set(scr_return)
}

draw_set_color(col)

return mouse_over
}