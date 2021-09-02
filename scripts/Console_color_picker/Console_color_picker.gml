
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