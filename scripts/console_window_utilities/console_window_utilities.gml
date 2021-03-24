
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




function draw_console_window(win){

var sidebar_width	   = SCALE_ 2
var sidebar_width_max  = SCALE_ 4
var sidebar_width_lerp = .4

var sidebar_range = SCALE_ 17 //mouse activation dist

var border_x = SCALE_ 19 //spacing between text and edges of window
var border_y = SCALE_ 9

var mouse_over_embed = false

var left
var right
var top
var bottom
	
if win.side != SIDES.RIGHT
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

//sidebar_width+win.sidebar
var r = (win.side == SIDES.RIGHT)

var sidebar_x1 = win.x + r
var sidebar_y1 = top
var sidebar_x2 = sidebar_x1 + (sidebar_width*(r+1) + win.sidebar)*signbool(not r)
var sidebar_y2 = bottom

if win.mouse_over_sidebar and mouse_check_button(mb_left)
{		
	if mouse_check_button_pressed(mb_left)
	{
		mouse_x_previous = gui_mx
		mouse_y_previous = gui_my
	}
		
	win.x += gui_mx-mouse_x_previous
	win.y += gui_my-mouse_y_previous
	mouse_x_previous = gui_mx
	mouse_y_previous = gui_my
}
else
{
	win.x = clamp(win.x, sidebar_width, gui_width-sidebar_width)
	win.y = clamp(win.y, -win.text_h, gui_height-string_height(" "))
}

if not o_console.collapse_windows win.show = true

if win.show
{
	draw_set_font(o_console.font)
	draw_set_halign(fa_left)
	draw_set_valign(fa_top)
	
	draw_console_body(left, top, right, bottom)
	draw_set_color(colors.output)
	
	clip_rect_cutout(left, top, right, bottom)
	
	if (o_console.embed_text and o_console.window_embed_text) or (win.name == "Output" and o_console.embed_text) mouse_over_embed = draw_embedded_text(left+border_x, top+border_y+1, win.text, win.plaintext)
	else draw_text(left+border_x, top+border_y+1, win.plaintext)

	shader_reset()
}
	
draw_set_color(colors.output)
draw_set_alpha(1)
draw_rectangle(sidebar_x1, sidebar_y1, sidebar_x2, sidebar_y2, false)
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
