// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function draw_instance_cursor(x, y, text){

var text_dampner = 1.3
var text_offsetx = 7
var triangle_size = 9
var line_width = 2
var box_col  = o_console.colors.body
var text_col = o_console.colors.output

draw_set_font(fnt_debug)
draw_set_align(fa_left, fa_bottom)

draw_set_color(box_col)
gpu_set_blendmode(o_console.colors.body_bm)
draw_rectangle(x, y, x+text_offsetx+string_width(text)+3, y-string_height(text)-3, false)

gpu_set_blendmode(bm_normal)
draw_set_color(text_col)

draw_round_line(x, y, x+text_offsetx+string_width(text)/text_dampner, y, line_width)
draw_round_line(x, y, x, y-string_height(text), line_width)
draw_triangle(x, y, x+triangle_size, y, x, y-triangle_size, false)

draw_text(x+text_offsetx, y, text)

draw_reset_properties()
}