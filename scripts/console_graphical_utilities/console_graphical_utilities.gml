
function draw_console_text(x, y, console_text){

if not is_struct(console_text) or array_length(console_text.colors) < 1 return undefined

draw_set_font(o_console.font)
draw_set_halign(fa_left)

var lastpos = 1

for(var i = 0; i <= array_length(console_text.colors)-1; i++)
{
	draw_set_color( o_console.colors[$ console_text.colors[i].col] )
	
	var _text = string_copy( console_text.text, lastpos, console_text.colors[i].pos - lastpos )
	
	draw_text( x, y, _text )
	
	x += o_console.char_width*string_length(_text)
	
	lastpos = console_text.colors[i].pos
}
}




function draw_instance_cursor(x, y, text){

var text_dampner = 1.3
var text_offsetx = 7
var triangle_size = 9
var line_width = 2
var box_col  = o_console.colors.body
var text_col = o_console.colors.output

draw_set_font(o_console.font)
draw_set_align(fa_left, fa_bottom)

draw_set_color(box_col)
gpu_set_blendmode(o_console.colors.body_bm)
draw_rectangle(x, y, x+text_offsetx+string_width(text)+3, y-string_height(text)-3, false)

gpu_set_blendmode(bm_normal)
draw_set_color(text_col)

draw_roundline(x, y, x+text_offsetx+string_width(text)/text_dampner, y, line_width)
draw_roundline(x, y, x, y-string_height(text), line_width)
draw_triangle(x, y, x+triangle_size, y, x, y-triangle_size, false)

draw_text(x+text_offsetx, y, text)

draw_reset_properties()
}



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
	mouse_char = text_char_at(gui_mx, gui_my, x, y, plain)
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




function draw_color_picker(){ with o_console.COLOR_PICKER { if variable_string_exists(variable) {

static mouse_on_h = false
static mouse_on_sv = false

static u_position = shader_get_uniform(shd_hue, "u_Position")

static _color = 0

var _size = size/255
var _h_strip_pos = 255+h_strip_dist
var _border_color = -o_console.colors.body_real

mouse_on = draw_console_bubble_body(
	x, 
	y, 
	x + (_h_strip_pos+h_strip_width)*_size, 
	y + round( (255+color_bar_dist+color_bar_height)*_size )
)

if mouse_check_button_pressed(mb_left)
{
	if gui_mouse_between(x+255*_size, y, x+(_h_strip_pos+h_strip_width)*_size, y+255*_size)
	{
		mouse_on_h = true
	}
	else if gui_mouse_between(x*_size, y, x+255*_size, y+255*_size)
	{
		mouse_on_sv = true
	}
}
if (mouse_on_h or mouse_on_sv) and mouse_check_button(mb_left)
{
	if mouse_on_h
	{
		hue = clamp((gui_my-y)/_size, 0, 255)
	}
	else if mouse_on_sv
	{
		sat = clamp((gui_mx-x)/_size, 0, 255)
		val = clamp(255-(gui_my-y)/_size, 0, 255)
	}
	
	_color = make_color_hsv(hue, sat, val)
	variable_string_set(variable, _color)
}
else
{
	var _newcol = variable_string_get(variable)
	
	if _color != _newcol
	{
		hue = color_get_hue(_newcol)
		sat = color_get_saturation(_newcol)
		val = color_get_value(_newcol)
	}
	
	_color = _newcol
	
	mouse_on_h  = false
	mouse_on_sv = false
}

//Draw sv square
var x1 = x
var x2 = x + size

var y1 = y
var y2 = y + size

draw_set_properties(_border_color, border_alpha, undefined)
draw_rectangle(x1-border_width, y1-border_width, x2+border_width-1, y2+border_width-1, false)

shader_set(shd_hue)
shader_set_uniform_f(u_position, (-hue/255)*(pi*2))
draw_set_alpha(1)
draw_set_color(c_white)
draw_sprite_pos(sv_square, 0, x1, y1, x2, y1, x2, y2, x1, y2, 1)
shader_reset()


//Draw hue strip
var x1 = x + round( _h_strip_pos*_size )
var x2 = x + round( (_h_strip_pos+h_strip_width)*_size )

var y1 = y
var y2 = y + round( 255*_size )

draw_set_properties(_border_color, border_alpha, undefined)
draw_rectangle(x1-border_width, y1-border_width, x2+border_width-1, y2+border_width-1, false)

draw_set_alpha(1)
draw_set_color(c_white)
draw_sprite_pos(h_strip, 0, x1, y1, x2, y1, x2, y2, x1, y2, 1)


//Draw hue strip bar
var x1 = x1
var x2 = x2-1

var y1 = max(y1+1, y + (hue - h_strip_bar_height/2)*_size - 1)
var y2 = min(y2-1, y + (hue + h_strip_bar_height/2)*_size + 1)

draw_set_color(c_black)
draw_rectangle(x1, y1-1, x2, y2+1, true)

draw_set_color(make_color_hsv(hue, 255, 255))
draw_rectangle(x1, y1, x2, y2, false)

draw_set_color(c_white)
draw_rectangle(x1+1, y1, x2-1, y2, true)


//Draw hv square dropper
var r  = round(sv_square_dropper_radius*_size)
var x1 = round( x+sat*_size )
var y1 = round( y+(255-val)*_size )

draw_set_color(c_black)
draw_circle(x1, y1, r+2+round(.5*_size), false)

draw_set_color(c_white)
draw_circle(x1, y1, r+1,  false)

draw_set_color(_color)
draw_circle(x1, y1,r-round(.5*_size),  false)


//Draw color bar
var x1 = x
var x2 = x + round( (_h_strip_pos+h_strip_width)*_size )

var y1 = y + round( (255+color_bar_dist)*_size )
var y2 = y + round( (255+color_bar_dist+color_bar_height)*_size )

draw_set_properties(_border_color, border_alpha, undefined)
draw_rectangle(x1-border_width, y1-border_width, x2+border_width, y2+border_width, false)

draw_set_alpha(1)
draw_set_color(_color)
draw_rectangle(x1, y1, x2, y2, false)

draw_reset_properties()
}}}