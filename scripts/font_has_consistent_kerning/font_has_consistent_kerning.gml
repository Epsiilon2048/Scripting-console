
function font_has_consistent_kerning(font){

var old_font = draw_get_font()
draw_set_font(font)

var sw = string_width("W")
var same = true

for(var i = 32; i <= 126; i++)
{
	if string_width(chr(i)) != sw
	{
		same = false
		break
	}
}

draw_set_font(old_font)
return same
}