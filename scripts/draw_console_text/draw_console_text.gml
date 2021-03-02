// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function draw_console_text(x, y, console_text){

if not is_struct(console_text) or array_length(console_text.colors) < 1 return

draw_set_font(o_console.font)
draw_set_halign(fa_left)

var lastpos = 1

for(var i = 0; i <= array_length(console_text.colors)-1; i++)
{
	draw_set_color( o_console.colors[$ console_text.colors[i].col] )
	
	var _text = string_copy( console_text.text, lastpos, console_text.colors[i].pos - lastpos )
	
	draw_text( x, y, _text )
	
	x += o_console.char_width*string_length(_text)
	
	lastpos = console_text.colors[i].pos
}
}