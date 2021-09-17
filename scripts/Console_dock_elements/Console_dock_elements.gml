
#region Dock text
function new_cd_text(text, color){

var t = new Cd_text()
t.initialize(text)
t.color = color
return t
}



function new_cd_var(variable){
var v = new Cd_text()
v.set()
v.variable = variable
return v
}



function Cd_text() constructor{

initialize = function(text){
	
	enabled = true
	
	set(text)
	
	x = 0
	y = 0
	
	left = 0
	top = 0
	right = 0
	bottom = 0
	
	color_text = undefined
	color = undefined
	color_method = noscript
	
	variable = undefined
	float_places = 1
	
	is_button = false
	mouse_on = false
	clicking = false
	
	func = noscript
}


set = function(text){

	if not variable_struct_exists(self, "enabled") initialize()

	var old_font = draw_get_font()
	draw_set_font(o_console.font)
	
	var cw = string_width(" ")
	var ch = string_height(" ")
	
	self.text = string(text)
	name = self.text
	width = string_width(self.text)/cw
	height = string_height(self.text)/ch	
	
	draw_set_font(old_font)
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
	
	var cw = string_width(" ")
	var ch = string_height(" ")
	
	if not is_undefined(variable)
	{
		var value = variable_string_get(variable)
		var newtext = string_format_float(value, float_places)
		
		if newtext != text
		{
			text = newtext
			color_text = color_method(newtext)
			width = string_width(text)/cw
			height = string_height(text)/ch
		}
	}
	
	left = x
	top = y
	right = x+width*cw
	bottom = y+height*ch
	
	if clicking and not mouse_check_button(mb_left)
	{
		clicking = false
		func()
	}
	
	mouse_on = (is_button or clicking) and not mouse_on_console and not clicking_on_console and gui_mouse_between(left, top, right, bottom)
	
	if mouse_on and mouse_check_button_pressed(mb_left)
	{
		clicking = true
	}
	
	draw_set_font(old_font)
}


draw = function(){

	if right == x and bottom == y return undefined

	var old_color = draw_get_color()
	var old_font = draw_get_font()
	var old_halign = draw_get_halign()
	var old_valign = draw_get_valign()
	
	draw_set_font(o_console.font)
	draw_set_halign(fa_left)
	draw_set_valign(fa_top)

	var dc = o_console.DOCK
	
	if not is_button or not (mouse_on or clicking)
	{
		if color_method == noscript
		{
			if is_undefined(color) draw_set_color(is_button ? dc.colors.embed : dc.colors.output)
			else draw_set_color(is_numeric(color) ? color : dc.colors[$ color])
			draw_text(x, y+1, text)
		}
		else draw_color_text(x, y+1, color_text)
	}
	else
	{
		draw_set_color(clicking ? dc.colors.plain : dc.colors.embed_hover)
		draw_text(x, y+1, text)
	}
	
	draw_set_color(old_color)
	draw_set_font(old_font)
	draw_set_halign(old_halign)	draw_set_valign(old_valign)
}
}
#endregion