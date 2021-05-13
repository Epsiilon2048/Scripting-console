
function draw_console_text(x, y, console_text, font){

if not is_struct(console_text) or array_length(console_text.colors) < 1 return undefined

var old_color  = draw_get_color()
var old_font   = draw_get_font()
var old_halign = draw_get_halign()

draw_set_font(is_undefined(font)?o_console.font:font)
draw_set_halign(fa_left)

var char_width = string_width(" ")
var char_height = string_height(" ")

var lastpos = 1

for(var i = 0; i <= array_length(console_text.colors)-1; i++)
{
	var _text = string_copy( console_text.text, lastpos, console_text.colors[i].pos - lastpos )
	
	var c = console_text.colors[i].col
	
	draw_set_color( is_string(c) ? o_console.colors[$ c] : c )
	draw_text(x, y, _text)
	
	x += string_width(_text)//char_width*string_length(_text)
	lastpos = console_text.colors[i].pos
}

draw_set_color(old_color)
draw_set_font(old_font)
draw_set_halign(old_halign)
}




function draw_console_bar(x, y, width){ with o_console {
///@description draw_console_bar([x], [y], [width])

var old_color = draw_get_color()
var old_font = draw_get_font()
var old_halign = draw_get_halign()
var old_valign = draw_get_valign()

draw_set_font(font)

var _char_width = string_width(" ")
var _char_height = string_height(" ")
var asp = _char_height/BAR.char_height

var _win_dist		= floor(BAR.win_dist*asp)
var _height			= ceil(BAR.height*asp)
var _text_dist		= ceil(BAR.text_dist*asp)
var _sep			= ceil(BAR.sep*asp)
var _sidebar_width	= max(1, floor(BAR.sidebar_width*asp))

var sidetext_width = string_length(sidetext_string)*_char_width

if is_undefined(x)		x = _win_dist
if is_undefined(y)		y = gui_height - _win_dist - _char_height - _height
if is_undefined(width)	width = gui_width - x - _win_dist

var left	= x
var top		= y
var right	= x+width
var bottom	= y+_char_height+_height

var text_x = left+_text_dist
var text_y = ceil(bottom - _height/2)+1

draw_console_body(left, top, right-sidetext_width-_text_dist*2-_sep-1, bottom)	// Draw bar
draw_console_body(right-sidetext_width-_text_dist*2-1, top, right, bottom)		// Draw sidetext bar

clip_rect_cutout(left, top, right-sidetext_width-_text_dist*3-_sep+1, bottom+1)
draw_set_valign(fa_bottom)
if command_colors draw_console_text(text_x, text_y, color_string)				// Draw console colors

draw_set_color(colors.plain)
if not command_colors draw_text(text_x, text_y, console_string)					// Draw console string
																				
draw_rectangle(left, top, left+_sidebar_width, bottom, false)					// Draw sidebar
draw_rectangle(																	// Draw selection
	text_x + _char_width*(char_pos1-(char_pos1-char_pos2))-1, 
	text_y - _char_height,
	text_x + _char_width*(char_pos1-1), 
	text_y - 2,
	false
)
if string_length(console_string) > char_pos1-1
{
	draw_set_color(colors.selection)											
	draw_text(																	// Draw selection text
		text_x + _char_width*(char_pos1-1),
		text_y, 
		string_copy(console_string, char_pos1, char_pos2-char_pos1+1)
	)
}
shader_reset()

draw_set_color(colors.output)
draw_set_halign(fa_right)
draw_text(right-_text_dist, text_y, sidetext_string)							// Draw sidetext

draw_set_color(old_color)
draw_set_font(old_font)
draw_set_halign(old_halign)
draw_set_valign(old_valign)
}}




function draw_instance_cursor(x, y, text){

static text_dampner = 1.3
static text_offsetx = 7
static triangle_size = 9
static line_width = 2

with o_console {

var old_color	= draw_get_color()
var old_font	= draw_get_font()
var old_halign	= draw_get_halign()
var old_valign	= draw_get_valign()

var text_height	= string_height(text)
var text_width	= string_width(text)

draw_console_body(x, y, x+text_offsetx+text_width+3, y-text_height-3)

draw_line_width_color(x, y, x+text_offsetx+text_width/text_dampner, y, line_width, colors.output, colors.output)
draw_line_width_color(x, y, x, y-text_height, line_width, colors.output, colors.output)
draw_triangle_color(x, y, x+triangle_size, y, x, y-triangle_size, colors.output, colors.output, colors.output, false)

draw_set_color(colors.output)
draw_set_font(font)
draw_set_halign(fa_left)
draw_set_valign(fa_bottom)

draw_text(x+text_offsetx, y, text)

draw_set_color(old_color)
draw_set_font(old_font)
draw_set_halign(old_halign)
draw_set_valign(old_valign)
}}




function draw_color_picker(){ 
	
static mouse_on_h  = false
static mouse_on_sv = false

static u_position = shader_get_uniform(shd_hue, "u_Position")

static _color = 0
	
with o_console.COLOR_PICKER { if variable_string_exists(variable) {

var old_alpha = draw_get_alpha()

var _size = size/255
var _h_strip_pos = 255+h_strip_dist
var _border_color = -o_console.colors.body_real

var clicking_ctx = o_console.CTX_MENU.clicking_on

mouse_on = draw_console_bubble_body(
	x, 
	y, 
	x + (_h_strip_pos+h_strip_width)*_size, 
	y + round( (255+color_bar_dist+color_bar_height)*_size )
)

if mouse_check_button_pressed(mb_left) and not clicking_ctx
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
if (mouse_on_h or mouse_on_sv) and mouse_check_button(mb_left) and not clicking_ctx
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

draw_set_alpha(border_alpha)
draw_rectangle_color(
	x1-border_width, y1-border_width, x2+border_width-1, y2+border_width-1,
	_border_color, _border_color, _border_color, _border_color, false
)

draw_set_alpha(1)
shader_set(shd_hue)
shader_set_uniform_f(u_position, (-hue/255)*(pi*2))
draw_sprite_pos(sv_square, 0, x1, y1, x2, y1, x2, y2, x1, y2, 1)
shader_reset()


//Draw hue strip
var x1 = x + round( _h_strip_pos*_size )
var x2 = x + round( (_h_strip_pos+h_strip_width)*_size )

var y1 = y
var y2 = y + round( 255*_size )

draw_set_alpha(border_alpha)
draw_rectangle_color(
	x1-border_width, y1-border_width, x2+border_width-1, y2+border_width-1, 
	_border_color, _border_color, _border_color, _border_color, false
)

draw_set_alpha(1)
draw_sprite_pos(h_strip, 0, x1, y1, x2, y1, x2, y2, x1, y2, 1)


//Draw hue strip bar
var x1 = x1
var x2 = x2-1

var y1 = max(y1+1, y + (hue - h_strip_bar_height/2)*_size - 1)
var y2 = min(y2-1, y + (hue + h_strip_bar_height/2)*_size + 1)

draw_rectangle_color(x1, y1-1, x2, y2+1, c_black, c_black, c_black, c_black, true)

var c = make_color_hsv(hue, 255, 255)
draw_rectangle_color(x1, y1, x2, y2, c, c, c, c, false)

draw_rectangle_color(x1+1, y1, x2-1, y2, c_white, c_white, c_white, c_white, true)


//Draw hv square dropper
var r  = round(sv_square_dropper_radius*_size)
var x1 = round( x+sat*_size )
var y1 = round( y+(255-val)*_size )

draw_circle_color(x1, y1, r+2+round(.5*_size), c_black, c_black, false)
draw_circle_color(x1, y1, r+1, c_white, c_white, false)
draw_circle_color(x1, y1,r-round(.5*_size), _color, _color, false)


//Draw color bar
var x1 = x
var x2 = x + round( (_h_strip_pos+h_strip_width)*_size )

var y1 = y + round( (255+color_bar_dist)*_size )
var y2 = y + round( (255+color_bar_dist+color_bar_height)*_size )

draw_set_alpha(border_alpha)
draw_rectangle_color(x1-border_width, y1-border_width, x2+border_width, y2+border_width, _border_color, _border_color, _border_color, _border_color, false)

draw_set_alpha(1)
draw_rectangle_color(x1, y1, x2, y2, _color, _color, _color, _color, false)

draw_set_alpha(old_alpha)
}}}




function draw_checkbox(x, y, enabled, invert){ with o_console.CHECKBOX {

var old_swf_aa = draw_get_swf_aa_level()
draw_set_swf_aa_level(1)

var _invert = is_undefined(invert) ? false : invert

if enabled
{
	var col1 = _invert ? o_console.colors.body_accent	 : o_console.colors.output
	var col2 = _invert ? o_console.colors.output : o_console.colors.body_real
	
	draw_sprite_stretched_ext(
		s_checkbox_full, 0, 
		x, y, width, width, 
		col1, 1
	)
	
	draw_sprite_stretched_ext(
		s_checkbox_check, 0, 
		x, y, width, width, 
		col2, 1
	)
}
else //if disabled
{
	var col1 = o_console.colors.plain
	
	draw_sprite_stretched_ext(
		s_checkbox_empty, 0, 
		x, y, width, width, 
		col1, 1
	)
}

draw_set_swf_aa_level(old_swf_aa)
}}




function clip_rect_cutout(x1, y1, x2, y2){

static u_bounds = shader_get_uniform(shd_clip_rect, "u_bounds")

shader_set(shd_clip_rect)
shader_set_uniform_f(u_bounds, x1, y1, x2, y2)
}