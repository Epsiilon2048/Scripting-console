// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function draw_context_strip(x, y, string, hovering){

if not (is_undefined(string) or string == "")
{
draw_set_alpha((hovering-o_console.context_time)*o_console.context_alpha_spd)
	
var dist   = 7
var border = 5

draw_set_font(fnt_debug)
draw_set_halign(fa_left)
draw_set_valign(fa_top)

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

draw_set_color(-o_console.colors.body)

draw_rectangle(x1, y1, x2, y2, false)
gpu_set_blendmode(bm_normal)

draw_set_color(o_console.colors.output)
draw_text(x, y+1, string)

draw_line_width(x1, y2, x1, y1, 2)
draw_line_width(x1, y2, x2, y2, 2)

draw_reset_properties()
}
}