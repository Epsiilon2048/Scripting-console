// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function draw_console_text(x, y, color_list){

draw_set_font(fnt_debug)
draw_set_halign(fa_left)
for(var i = 0; i <= array_length(color_list)-1; i++)
{
	draw_set_color(color_list[i].col)
	draw_text(x, y, color_list[i].text)
	x += string_width(color_list[i].text)
}
draw_set_color(c_white)
}