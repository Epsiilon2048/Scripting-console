
function draw_console_window(win){

var win_w = display_get_gui_width()
var win_h = display_get_gui_height()

var sidebar_width	   = SCALE_ 2
var sidebar_width_max  = SCALE_ 4
var sidebar_width_lerp = SCALE_ .4
var
var sidebar_range = SCALE_ 17 //mouse activation dist
var
var border_x = SCALE_ 19 //spacing between text and edges of window
var border_y = SCALE_ 9

var mouse_over_embed = false

var sidebar_x1
var sidebar_y1
var sidebar_x2
var sidebar_y2

var left
var right
var top
var bottom
	
if win.side != SIDES.RIGHT//win.side = SIDES.LEFT or win.side = SIDES.TOP
{
	left   = win.x
	top    = win.y
	right  = win.x + win.text_w + border_x*2
	bottom = win.y + win.text_h + border_y*2
}
else if win.side == SIDES.RIGHT
{
	left   = win.x - win.text_w - border_x*2
	top    = win.y
	right  = win.x
	bottom = win.y + win.text_h + border_y*2
}

if win.side == SIDES.LEFT or win.side == SIDES.RIGHT or win.side == SIDES.BOTTOM
{
	sidebar_x1 = win.x-1 + win.sidebar/2*signbool(win.side == SIDES.LEFT)
	sidebar_y1 = top-1
	sidebar_x2 = sidebar_x1
	sidebar_y2 = bottom
}
else if win.side == SIDES.TOP //or win.side == SIDES.BOTTOM
{
	sidebar_x1 = left-1
	sidebar_y1 = win.y-1 + win.sidebar/2*signbool(win.side == SIDES.TOP)
	sidebar_x2 = right
	sidebar_y2 = sidebar_y1
}
	
if win.mouse_over_sidebar and mouse_check_button(mb_left)
{
	var mx = device_mouse_x_to_gui(0)
	var my = device_mouse_y_to_gui(0)
		
	if mouse_check_button_pressed(mb_left)
	{
		mouse_x_previous = mx
		mouse_y_previous = my
	}
		
	win.x += mx-mouse_x_previous
	win.y += my-mouse_y_previous
	mouse_x_previous = mx
	mouse_y_previous = my
}
else
{
	win.x = clamp(win.x, sidebar_width, win_w-sidebar_width)
	win.y = clamp(win.y, -win.text_h, win_h-string_height(" "))
}

if not o_console.collapse_windows win.show = true

if win.show
{
	draw_set_font(o_console.font)
	draw_set_halign(fa_left)
	draw_set_valign(fa_top)
	
	draw_set_color(colors.body) 
	gpu_set_blendmode(colors.body_bm)
	
	draw_rectangle(left, top, right, bottom, false)
	
	draw_set_color(colors.output)
	draw_set_alpha(1)
	gpu_set_blendmode(bm_normal)
	
	if (o_console.embed_text and o_console.window_embed_text) or (win.name == "Output" and o_console.embed_text) mouse_over_embed = draw_embedded_text(left+border_x, top+border_y+1, win.text, win.plaintext)
	else draw_text(left+border_x, top+border_y+1, win.plaintext)
}
	
draw_set_color(colors.output)
draw_set_alpha(1)
draw_line_width(sidebar_x1, sidebar_y1, sidebar_x2, sidebar_y2, sidebar_width+win.sidebar)
draw_set_color(c_white)

if not mouse_over_embed
{
	win.mouse_over_sidebar =
	(
		(win.mouse_over_sidebar and mouse_check_button(mb_left)) or
		(not mouse_check_button(mb_left) and 
		 gui_mouse_between(win.x - sidebar_range, win.y, win.x + sidebar_range, win.y + win.text_h + border_y*2))
	)
}
win.sidebar = max(
	lerp(win.sidebar, sidebar_width_max*win.mouse_over_sidebar, sidebar_width_lerp), 
	sidebar_width_max*(not win.show)
)
}