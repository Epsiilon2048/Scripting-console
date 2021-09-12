
function new_separator(){
var s = new Console_separator()
s.initialize()
return s
}



function Console_separator() constructor{

initialize = function(){
	
	enabled = true
	name = "Separator"
	
	double = false
	text = ""
	color = "body_accent"
}


get_input = function(){
	
	if not enabled
	{
		left = x
		top = y
		right = x
		bottom = y
		return undefined
	}
	
	var old_font = draw_get_font()
	draw_set_font(o_console.font)
	
	var sp = o_console.SEPARATOR
	var ch = string_height(" ")
	var asp = ch/sp.char_height
	var _width = max(1, round(sp.width*asp))
	
	left = x
	top = y
	right = left
	bottom = top+_width
	
	draw_set_font(old_font)
}


draw = function(){
	
	if bottom == y return undefined
	
	var old_color = draw_get_color()
	var old_font = draw_get_font()
	var old_halign = draw_get_halign()
	var old_valign = draw_get_valign()
	
	draw_set_font(o_console.font)
	
	var sp = o_console.SEPARATOR
	var ch = string_height(" ")
	var asp = ch/sp.char_height
	var _wdist = round(sp.wdist*asp)
	
	draw_set_color(is_numeric(color) ? color : o_console.colors[$ color])
	draw_rectangle(dock.left+_wdist, top, dock.right-_wdist, bottom-1, false)
	
	draw_set_font(old_color)
	draw_set_font(old_font)
	draw_set_font(old_halign)
	draw_set_font(old_valign)
}
}
