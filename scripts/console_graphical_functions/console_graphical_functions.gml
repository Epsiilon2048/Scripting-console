
function draw_console_text(x, y, console_text){

if not is_struct(console_text) or array_length(console_text.colors) < 1 return undefined

var old_color  = draw_get_color()
var old_font   = draw_get_font()
var old_halign = draw_get_halign()

draw_set_font(o_console.font)
draw_set_halign(fa_left)

var char_width = string_width(" ")
var char_height = string_height(" ")

var y1
var y2

switch draw_get_valign()
{
case fa_top:
	y1 = y
	y2 = y+char_height
break
case fa_center:
	y1 = y-char_height/2
	y2 = y+char_height/2
break
case fa_bottom:
	y1 = y-char_height
	y2 = y
}

var lastpos = 1

draw_outline_text(x, y, console_text.text)

for(var i = 0; i <= array_length(console_text.colors)-1; i++)
{
	var _text = string_copy( console_text.text, lastpos, console_text.colors[i].pos - lastpos )
	
	var len = char_width*string_length(_text)
	
	var c = console_text.colors[i].col
	var hl = console_text.colors[i].hl
	var ol = console_text.colors[i].ol
	if not is_undefined(hl)
	{
		draw_set_color( is_string(hl) ? o_console.colors[$ hl] : hl )
		draw_rectangle(x, y1, x+len-1, y2-2, false)
	}

	if ol
	{
		draw_set_color(o_console.colors.plain)
		draw_outline_text(x, y, _text, ol)
	}
	
	draw_set_color( is_string(c) ? o_console.colors[$ c] : c )
	draw_text(x, y, _text)
	
	x += len
	lastpos = console_text.colors[i].pos
}

draw_set_color(old_color)
draw_set_font(old_font)
draw_set_halign(old_halign)
}



function console_bar_inputs(){ with o_console {

if BAR.docked and not BAR.run_in_dock
{
	if BAR.dock.enabled return undefined
	
	with BAR
	{
		docked = false
		x = undefined
		y = undefined
		width = undefined
	}
}
else if BAR.run_in_dock BAR.docked = true

var old_font = draw_get_font()
draw_set_font(o_console.font)

var cw = string_width(" ")
var ch = string_height(" ")
var asp = ch/BAR.char_height

var _win_dist		= floor(BAR.win_dist*asp)
var _height			= ceil(BAR.height*asp)
var _text_dist		= ceil(BAR.text_dist*asp)
var _sep			= ceil(BAR.sep*asp)
var _sidebar_width	= max(1, floor(BAR.sidebar_width*asp))

var sidetext_width = string_length(BAR.sidetext_string)*cw

var _x = is_undefined(BAR.x) ? _win_dist : BAR.x
var _y = is_undefined(BAR.y) ? (gui_height - _win_dist - ch - _height) : BAR.y
var _width

if BAR.docked _width = is_undefined(BAR.width) ? round(BAR.docked_width*asp) : BAR.width
else _width = is_undefined(BAR.width) ? (gui_width - _x - _win_dist) : BAR.width


if BAR.docked BAR.enabled = BAR.dock.show
else
{
	if keyboard_check_pressed(console_key) and keyboard_scope == noone
	{
		BAR.enabled = not BAR.enabled
	
		if BAR.enabled
		{
			keyboard_string = ""
			BAR.text_box.scoped = true
			o_console.keyboard_scope = BAR.text_box
		}
	}

	if keyboard_check_pressed(vk_escape) 
	{
		BAR.enabled = false
		BAR.text_box.scoped = false
		o_console.keyboard_scope = noone
	}
}

if BAR.enabled and keyboard_scope == BAR.text_box
{
	enter		= keyboard_check_pressed(vk_enter)
	log_up		= keyboard_check_pressed(vk_up)
	log_down	= keyboard_check_pressed(vk_down)
	
	if log_up and ds_list_size(input_log)
	{
		if input_log_index == -1 input_log_save = console_string
		input_log_index = min(input_log_index+1, ds_list_size(input_log)-1)
		console_string = input_log[| input_log_index]
	}
	else if log_down
	{
		if input_log_index == 0
		{
			input_log_index = -1
			console_string = input_log_save
			input_log_save = ""
		}
		else if input_log_index != -1
		{
			input_log_index --
			console_string = input_log[| input_log_index]
		}
	}
	
	if log_up or log_down
	{
		BAR.text_box.blink_step = 0
		BAR.text_box.char_pos1 = string_length(console_string)
		BAR.text_box.char_pos2 = BAR.text_box.char_pos1
		BAR.text_box.char_pos_selection = false
	}
	
	#region Parse command
	if enter
	{	
		var _compile = gmcl_compile(console_string)
		var _output  = gmcl_run(_compile)
		
		if is_struct(_compile)
		{
			prev_command = console_string
			prev_compile = _compile
			
			output_set_lines(_output)
			
			input_log_index = -1
			ds_list_insert(input_log, 0, console_string)
			if ds_list_size(input_log) > input_log_limit ds_list_delete(input_log, input_log_limit-1)
			
			console_log_input(console_string, _output, false)
		}
		else output_set_lines(_output)
		
		BAR.text_box.blink_step = 0
		keyboard_string = ""
		console_string = ""
	}
	#endregion
}
else BAR.blink_step = 0

if not is_undefined(object) and instance_exists(object) 
{
	BAR.sidetext_string = (object == global) ? "global" : object_get_name( object.object_index )
}
else BAR.sidetext_string = "noone"

BAR.left	= _x+_sidebar_width
BAR.top		= _y
BAR.right	= _x+_width
BAR.bottom	= _y+ch+_height

BAR.bar_right = BAR.right-sidetext_width-_text_dist*2-_sep-1
BAR.sidetext_left = BAR.right-sidetext_width-_text_dist*2-1

BAR.text_x = BAR.left+_text_dist
BAR.text_y = ceil(BAR.top+_text_dist/2)

var mouse_on_prev = BAR.mouse_on
BAR.mouse_on = gui_mouse_between(BAR.left, BAR.top, BAR.right, BAR.bottom)

with BAR
{
	text_box.enabled = enabled
	text_box.cbox_left = left
	text_box.cbox_top = top
	text_box.cbox_right = bar_right
	text_box.cbox_bottom = bottom
	text_box.att.length_min = (bar_right - text_x)/cw
	text_box.att.length_max = text_box.att.length_min
	text_box.x = text_x
	text_box.y = text_y
	text_box.get_input()
}

if BAR.docked and keyboard_check_pressed(console_key) and keyboard_scope == noone
{
	BAR.dock.show = true
	BAR.dock.is_front = true
	BAR.text_box.scoped = true
	keyboard_scope = BAR.text_box

	clicking_on_console = true
	keyboard_string = ""
}
	
if BAR.text_box.text_changed and input_log_index != -1
{
	input_log_index = -1
	input_log_save = ""
}

draw_set_font(old_font)
}}



function draw_console_bar(){ with o_console {

if not BAR.enabled return undefined
if BAR.docked and not BAR.run_in_dock and BAR.dock.enabled return undefined

var old_color = draw_get_color()
var old_font = draw_get_font()
var old_halign = draw_get_halign()
var old_valign = draw_get_valign()

draw_set_font(font)

var cw = string_width(" ")
var ch = string_height(" ")
var asp = ch/BAR.char_height

var _text_dist		= ceil(BAR.text_dist*asp)
var _sidebar_width	= max(1, floor(BAR.sidebar_width*asp))

var sidetext_width = string_length(BAR.sidetext_string)*cw

var draw_dock_body
if BAR.docked
{
	if BAR.dock.is_front
	{
		draw_dock_body = draw_rectangle
		draw_set_color(o_console.colors.body_real)
	}
	else draw_dock_body = noscript
}
else draw_dock_body = draw_console_body

draw_dock_body(BAR.left, BAR.top, BAR.bar_right, BAR.bottom, false)	// Draw bar
draw_dock_body(BAR.sidetext_left, BAR.top, BAR.right, BAR.bottom, false)		// Draw sidetext bar

if BAR.docked
{
	var _outline_width = round(BAR.outline_width*asp)
	
	draw_set_color(o_console.colors.body_accent)
	draw_hollowrect(BAR.left, BAR.top, BAR.bar_right, BAR.bottom, _outline_width)
	draw_hollowrect(BAR.sidetext_left, BAR.top, BAR.right, BAR.bottom, _outline_width)
}

draw_set_color(colors.output)
draw_rectangle(BAR.left-_sidebar_width, BAR.top, BAR.left, BAR.bottom, false)					// Draw sidebar

BAR.text_box.draw()

draw_set_color(colors.output)
draw_set_halign(fa_right)
draw_set_valign(fa_top)
draw_text(BAR.right-_text_dist, BAR.text_box.y+1, BAR.sidetext_string)							// Draw sidetext

draw_set_color(old_color)
draw_set_font(old_font)
draw_set_halign(old_halign)
draw_set_valign(old_valign)
}}



function console_output_inputs(){ with o_console {
	
var ot = OUTPUT
	
if ot.docked and not ot.run_in_dock return undefined

if output_as_window
{
	ot.dock.show_name = true
}
else
{
	ot.dock.show_name = false
}

ot.dock.get_input()

with OUTPUT
{
	left = ot.dock.left
	top = ot.dock.top
	right = ot.dock.right
	bottom = ot.dock.bottom
}
}}
	
	
function draw_console_output(){ with o_console {

var ot = OUTPUT

if ot.docked and not ot.run_in_dock return undefined

ot.dock.draw()
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