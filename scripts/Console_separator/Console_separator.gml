
function new_separator(){
var s = new Console_separator()
s.initialize()
return s
}



function Console_separator() constructor{

initialize = function(){
	
	docked = false
	in_ctx_menu = false
	
	enabled = true
	name = "Separator"

	text = ""
	color = "body_accent"
	
	parent = undefined
}



get_printout = function(){
	return ""
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
	
	if docked parent = dock
	else if in_ctx_menu parent = ctx_menu
	else return undefined
	
	var old_font = draw_get_font()
	draw_set_font(o_console.font)
	
	var sp = o_console.SEPARATOR
	var ch = string_height("W")
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
	var ch = string_height("W")
	var asp = ch/sp.char_height
	var _wdist = round(sp.wdist*asp)
	
	var off = 0
	if in_ctx_menu off = -1
	
	draw_set_color(is_numeric(color) ? color : o_console.colors[$ color])
	draw_rectangle(parent.left+_wdist, top+off, parent.right-_wdist, bottom-1+off, false)
	
	draw_set_font(old_color)
	draw_set_font(old_font)
	draw_set_font(old_halign)
	draw_set_font(old_valign)
}
}
