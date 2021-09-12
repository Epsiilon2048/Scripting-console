
function draw_color_text(x, y, color_text){

if not is_struct(color_text) or array_length(color_text.colors) < 1 return undefined

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

draw_outline_text(x, y, color_text.text, undefined)

for(var i = 0; i <= array_length(color_text.colors)-1; i++)
{
	var _text = string_copy( color_text.text, lastpos, color_text.colors[i].pos - lastpos )
	
	var len = char_width*string_length(_text)
	
	var c = color_text.colors[i].col
	var hl = variable_struct_get(color_text.colors[i], "hl")
	var ol = variable_struct_get(color_text.colors[i], "ol")
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
	lastpos = color_text.colors[i].pos
}

draw_set_color(old_color)
draw_set_font(old_font)
draw_set_halign(old_halign)
}
