
function draw_context_strip(x, y, string, hovering){ with CTX_STRIP {

if is_string(string) and string != ""
{
draw_set_font(font)
draw_set_align(fa_left, fa_top)

var w = string_width (string)
var h = string_height(string)

x += dist*2
y += dist

var x1 = x - border*2	 
var y1 = y - border	 
var x2 = x+w+border*2
var y2 = y+h+border	 

if x2 > display_get_gui_width()-w
{
	x  = x  - w - dist*4
	x1 = x1 - w - dist*4
	x2 = x2 - w - dist*4
}
if y2 > display_get_gui_height()-h
{
	y  = y  - h - dist*2
	y1 = y1 - h - dist*2
	y2 = y2 - h - dist*2
}

draw_set_color(o_console.colors.body_real)

draw_rectangle(x1, y1, x2, y2, false)

draw_set_color(o_console.colors.output)
draw_text(x, y+1, string)

draw_line_width(x1, y2+line_width/2, x1, y1-1, line_width)
draw_line_width(x1, y2, x2, y2, line_width)

draw_reset_properties()
}
}}