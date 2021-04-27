
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

draw_console_body(left, top, right-sidetext_width-_text_dist*2-_sep, bottom)	// Draw bar
draw_console_body(right-sidetext_width-_text_dist*2, top, right, bottom)		// Draw sidetext bar

clip_rect_cutout(left, top, right-sidetext_width-_text_dist*3-_sep+1, bottom+1)
draw_set_valign(fa_bottom)
if command_colors draw_console_text(text_x, text_y, color_string)				// Draw console colors

draw_set_color(colors.plain)
if not command_colors draw_text(text_x, text_y, console_string)					// Draw console string
																				
draw_rectangle(left, top, left+_sidebar_width, bottom, false)					// Draw sidebar
draw_rectangle(																	// Draw selection
	text_x + _char_width*(char_pos1-(char_pos1-char_pos2)), 
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