
function is_on_display(variable){

for(var i = 0; i <= ds_list_size(display_list)-1; i++)
{
	if display_list[| i].variable == variable
	{
		return i
	}
}
return -1
}







function console_window_inputs(win){ with win {

if not enabled 
{
	left = x
	top = y
	right = x
	bottom = y
	
	sidebar_x = x
	
	mouse_on = false
	mouse_on_sidebar = false
	dragging = false
	right_mb = false
	
	sidebar = 0
	
	return undefined
}

var wn = o_console.WINDOW

var old_font = draw_get_font()
draw_set_font(o_console.font)

var cw = string_width(" ")
var ch = string_height(" ")

var asp = ch/wn.char_height

var is_left = sidebar_side != fa_right
var is_top = valign != fa_bottom

var _border_w = ceil(wn.border_w*asp)
var _border_h = ceil(wn.border_h*asp)

text.get_input()

if not dragging
{
	if not is_left	x = clamp(x, -_border_w, gui_width-_border_w*2)
	else			x = clamp(x, 0, gui_width-_border_w)
	
	//hmu
	if is_top	y = clamp(y, -text.height*ch+_border_h, gui_height-_border_h*3)
	else		y = clamp(y, _border_h, gui_height+text.height*ch-_border_h*3)
}

left	= ((!is_left)	? (x - text.width*cw) : x)
top		= (is_top	? y : (y - text.height*ch))
right	= _border_w*2 + ((!is_left) ? x : (x + text.width*cw))
bottom	= _border_h*2 + (is_top ? (y + text.height*ch) : y)

sidebar_x = is_left ? left : right

mouse_on = dragging or (not mouse_on_console and not clicking_on_console and gui_mouse_between(left, top, right, bottom))
mouse_on_sidebar = dragging or (mouse_on and not text.mouse_on_item and gui_mouse_between(sidebar_x, top, sidebar_x + wn.mouse_border*asp*signbool(is_left), bottom))

if mouse_on mouse_on_console = true
if dragging clicking_on_console = true

if mouse_on and mouse_check_button_pressed(mb_right) right_mb = true
if (right_mb and not mouse_check_button(mb_right))
{
	right_mb = false
	
	if mouse_on o_console.CTX_MENU.ctx = ctx
}

if mouse_on_sidebar and not dragging and mouse_check_button_pressed(mb_left)
{
	dragging = true
	mouse_offsetx = gui_mx - x
	mouse_offsety = gui_my - y
}
else if dragging and not mouse_check_button(mb_left)
{
	dragging = false
}
else if dragging
{
	x = gui_mx - mouse_offsetx
	y = gui_my - mouse_offsety
	
	left	= ((!is_left)	? (x - text.width*cw) : x)
	top		= (is_top	? y : (y - text.height*ch))
	right	= _border_w*2 + ((!is_left) ? x : (x + text.width*cw))
	bottom	= _border_h*2 + (is_top ? (y + text.height*ch) : y)

	sidebar_x = is_left ? left : right
}

sidebar = lerp(sidebar, mouse_on_sidebar ? 1 : 0, wn.sidebar_lerp)

draw_set_font(old_font)
}}


function draw_console_window(win){ with win {

if right == x and bottom == y return undefined

var wn = o_console.WINDOW

var old_color = draw_get_color()
var old_alpha = draw_get_alpha()
var old_font = draw_get_font()

draw_set_font(o_console.font)

var cw = string_width(" ")
var ch = string_height(" ")

var asp = ch/wn.char_height

var is_left = sidebar_side != fa_right
var is_top = valign != fa_bottom

var _border_w = ceil(wn.border_w*asp)
var _border_h = ceil(wn.border_h*asp)

if show
{
	var text_x = left + wn.border_w*asp
	var text_y = top + wn.border_h*asp
	
	draw_console_body(left, top, right, bottom)
	draw_embedded_text(text_x, text_y+1, text, o_console.colors.output, 1)
}

var _sidebar = ceil((wn.sidebar_min + wn.sidebar_max*sidebar)*asp*signbool(is_left))

var _sidebar_x1 = min(sidebar_x, sidebar_x+_sidebar)
var _sidebar_x2 = max(sidebar_x, sidebar_x+_sidebar)

draw_set_color(o_console.colors.output)
draw_set_alpha(1)
draw_rectangle(_sidebar_x1, top, _sidebar_x2, bottom, false)

draw_set_color(old_color)
draw_set_alpha(old_alpha)
draw_set_font(old_font)
}}







function draw_console_window_old(win){ with win {

if not enabled 
{
	left = x
	top = y
	right = x
	bottom = y
	
	sidebar_x = x
	
	mouse_on = false
	mouse_on_sidebar = false
	dragging = false
	right_mb = false
	
	sidebar = 0
	
	return undefined
}

var wn = o_console.WINDOW

var old_color = draw_get_color()
var old_alpha = draw_get_alpha()
var old_font = draw_get_font()

draw_set_font(o_console.font)

var cw = string_width(" ")
var ch = string_height(" ")

var asp = ch/wn.char_height

var is_left = sidebar_side != fa_right
var is_top = valign != fa_bottom

var _border_w = ceil(wn.border_w*asp)
var _border_h = ceil(wn.border_h*asp)

if not dragging
{
	if not is_left	x = clamp(x, -_border_w, gui_width-_border_w*2)
	else			x = clamp(x, 0, gui_width-_border_w)
	
	//hmu
	if is_top	y = clamp(y, -text.height*ch+_border_h, gui_height-_border_h*3)
	else		y = clamp(y, _border_h, gui_height+text.height*ch-_border_h*3)
}

left	= ((!is_left)	? (x - text.width*cw) : x)
top		= (is_top	? y : (y - text.height*ch))
right	= _border_w*2 + ((!is_left) ? x : (x + text.width*cw))
bottom	= _border_h*2 + (is_top ? (y + text.height*ch) : y)

sidebar_x = is_left ? left : right

mouse_on = dragging or (not mouse_on_console and not clicking_on_console and gui_mouse_between(left, top, right, bottom))
mouse_on_sidebar = dragging or (mouse_on and not text.mouse_on_item and gui_mouse_between(sidebar_x, top, sidebar_x + wn.mouse_border*asp*signbool(is_left), bottom))

if mouse_on mouse_on_console = true
if dragging clicking_on_console = true

if mouse_on and mouse_check_button_pressed(mb_right) right_mb = true
if (right_mb and not mouse_check_button(mb_right))
{
	right_mb = false
	
	if mouse_on o_console.CTX_MENU.ctx = ctx
}

if mouse_on_sidebar and not dragging and mouse_check_button_pressed(mb_left)
{
	dragging = true
	mouse_offsetx = gui_mx - x
	mouse_offsety = gui_my - y
}
else if dragging and not mouse_check_button(mb_left)
{
	dragging = false
}
else if dragging
{
	x = gui_mx - mouse_offsetx
	y = gui_my - mouse_offsety
	
	left	= ((!is_left)	? (x - text.width*cw) : x)
	top		= (is_top	? y : (y - text.height*ch))
	right	= _border_w*2 + ((!is_left) ? x : (x + text.width*cw))
	bottom	= _border_h*2 + (is_top ? (y + text.height*ch) : y)

	sidebar_x = is_left ? left : right
}

if show
{
	var text_x = left + wn.border_w*asp
	var text_y = top + wn.border_h*asp
	
	draw_console_body(left, top, right, bottom)
	draw_embedded_text(text_x, text_y+1, text, o_console.colors.output, 1)
}

sidebar = lerp(sidebar, mouse_on_sidebar ? 1 : 0, wn.sidebar_lerp)

var _sidebar = ceil((wn.sidebar_min + wn.sidebar_max*sidebar)*asp*signbool(is_left))

var _sidebar_x1 = min(sidebar_x, sidebar_x+_sidebar)
var _sidebar_x2 = max(sidebar_x, sidebar_x+_sidebar)

draw_set_color(o_console.colors.output)
draw_set_alpha(1)
draw_rectangle(_sidebar_x1, top, _sidebar_x2, bottom, false)

draw_set_color(old_color)
draw_set_alpha(old_alpha)
draw_set_font(old_font)
}}