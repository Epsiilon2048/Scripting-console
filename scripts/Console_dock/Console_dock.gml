
function format_for_dock(scope){

var vesg = variable_struct_exists_get
var _dock

if is_undefined(scope) 
{
	scope = self
	_dock = undefined
	
}
else _dock = self
with scope
{
	dock		= vesg(self, "dock", _dock)

	dock_halign = vesg(self, "dock_halign", fa_left)
	dock_valign	= vesg(self, "dock_valign", fa_middle)

	x			= vesg(self, "x", 0)
	y			= vesg(self, "y", 0)
	left		= vesg(self, "left", 0)
	top			= vesg(self, "top", 0)
	right		= vesg(self, "right", 0)
	bottom		= vesg(self, "bottom", 0)

	dragging	= vesg(self, "dragging", false)
}
}

function Cd_text() constructor{

set = function(text){
	
	var old_font = draw_get_font()
	draw_set_font(o_console.font)
	
	var cw = string_width(" ")
	var ch = string_height(" ")
	
	self.text = text
	width = string_width(text)/cw
	height = string_height(text)/ch
	
	x = 0
	y = 0
	
	left = 0
	top = 0
	right = 0
	bottom = 0
	
	variable = undefined
	float_places = 3
	
	draw_set_font(old_font)
}

initialize = set

get_input = function(){
	
	var old_font = draw_get_font()
	draw_set_font(o_console.font)
	
	var cw = string_width(" ")
	var ch = string_height(" ")
	
	if not is_undefined(variable)
	{
		var value = variable_string_get(variable)
		var newtext = is_real(value) ? string_format_float(value, float_places) : string(value)
		
		if newtext != text
		{
			text = newtext
			width = string_width(text)/cw
			height = string_height(text)/ch
		}
	}
	
	left = x
	top = y
	right = x+width*cw
	bottom = y+height*ch
	
	draw_set_font(old_font)
}

draw = function(){

	var old_color = draw_get_color()
	var old_font = draw_get_font()
	var old_halign = draw_get_halign()
	var old_valign = draw_get_valign()
	
	draw_set_color(o_console.colors.output)
	draw_set_font(o_console.font)
	draw_set_halign(fa_left)
	draw_set_valign(fa_top)
	
	draw_text(x, y, text)
	
	draw_set_color(old_color)
	draw_set_font(old_font)
	draw_set_halign(old_halign)	draw_set_valign(old_valign)
}
}



function Cd_button() constructor{

initialize = function(name, func){
	
	self.name = name
	self.func = func
	
	length = undefined
}
}



function Cd_checkbox() constructor{
	
}


function Cd_color_picker() constructor{
	
}


function Console_dock() constructor{

initialize = function(){
	
	format_for_dock(undefined)
	
	name = ""
	association = noone
	
	x = 0
	y = 0
	
	left = 0
	top = 0
	right = 0
	bottom = 0
	
	mouse_on = false
	mouse_on_bar = false
	
	active_element = undefined
	
	dragging = false
	mouse_xoffset = 0
	mouse_yoffset = 0
	
	elements = []
}


set = function(elements){
	
	static create_text = function(text){
		var element = new Cd_text()
		element.set(is_real(text) ? string_format_float(text, undefined) : string(text))
		return element
	}
	
	for(var i = 0; i <= array_length(elements)-1; i++)
	{
		if is_array(elements[i]) for(var j = 0; j <= array_length(elements[i])-1; j++)
		{
			if not is_struct(elements[@ i, j]) elements[@ i, j] = create_text(elements[@ i, j])
			format_for_dock(elements[@ i, j])
		}
		else 
		{	
			if not is_struct(elements[i]) elements[i] = create_text(elements[i])
			format_for_dock(elements[i])
		}
	}
	
	self.elements = elements
}


get_input = function(){
	
	var dc = o_console.DOCK
	
	var old_font = draw_get_font()
	draw_set_font(o_console.font)
	
	var cw = string_width(" ")
	var ch = string_height(" ")
	var asp = ch/dc.char_height
	
	var _name_wdist = round(dc.name_wdist*asp)
	var _name_hdist = round(dc.name_hdist*asp)
	var _element_wdist = round(dc.element_wdist*asp)
	var _element_hdist = round(dc.element_hdist*asp)
	var _element_wsep = round(dc.element_wsep*asp)
	var _element_hsep = round(dc.element_hsep*asp)
	
	if dragging
	{
		if not mouse_check_button(mb_left)
		{
			dragging = false
		}
		else
		{
			x = gui_mx-mouse_xoffset
			y = gui_my-mouse_yoffset
		}
	}
	
	left = x
	top = y
	right = x + string_length(name)*cw + _name_wdist*2
	bottom = y + ch + _name_hdist*2 + _element_hdist
	
	var xx = x + _element_wdist
	var yy = bottom
	
	var was_clicking_on_console = clicking_on_console
	
	if not is_undefined(active_element) 
	{
		active_element.get_input()
	}
	
	for(var i = 0; i <= array_length(elements)-1; i++)
	{		
		if not is_array(elements[i])
		{
			var el = elements[i]
				
			el.x = xx
			el.y = yy
			if active_element != el el.get_input()
			el.dragging = false
			el.x = xx
			el.y = yy
			
			if not was_clicking_on_console and clicking_on_console
			{
				active_element = el
			}
				
			right = max(right, el.right+_element_wdist)
			bottom = max(bottom, el.bottom)
		}
		else
		{			
			for(var j = 0; j <= array_length(elements[i])-1; j++)
			{
				var el = elements[@ i, j]
				
				el.x = xx
				el.y = yy
				if active_element != el el.get_input()
				el.dragging = false
				el.x = xx
				el.y = yy
				
				if not was_clicking_on_console and clicking_on_console
				{
					active_element = el
				}
				
				xx = max(xx, el.right+_element_wsep)
				right = max(right, el.right+_element_wdist)
				bottom = max(bottom, el.bottom)
			}
		}
		
		if not clicking_on_console active_element = undefined

		xx = x + _element_wdist
		yy = bottom+_element_hsep
	}
	bottom += _element_hdist
	
	mouse_on = not mouse_on_console and gui_mouse_between(left, top, right, bottom)
	mouse_on_bar = mouse_on and gui_mouse_between(left, top, right, top + ch + _name_hdist*2)
	
	if not clicking_on_console and mouse_check_button_pressed(mb_left) and mouse_on_bar
	{
		dragging = true
		mouse_xoffset = gui_mx-x
		mouse_yoffset = gui_my-y
	}
	
	if dragging clicking_on_console = true
	if mouse_on mouse_on_console = true
	
	draw_set_font(old_font)
}



draw = function(){
	var dc = o_console.DOCK
	
	var old_color = draw_get_color()
	var old_font = draw_get_font()
	var old_halign = draw_get_halign()
	var old_valign = draw_get_valign()
	draw_set_font(o_console.font)
	draw_set_halign(fa_left)
	draw_set_valign(fa_top)
	
	var cw = string_width(" ")
	var ch = string_height(" ")
	var asp = ch/dc.char_height
	
	var _name_wdist = round(dc.name_wdist*asp)
	var _name_hdist = round(dc.name_hdist*asp)
	
	draw_console_body(left, top, right, bottom)
	
	draw_set_color(o_console.colors.body_real)
	draw_rectangle(left, top, right, top + ch + _name_hdist*2, false)
	
	draw_set_color(o_console.colors.output)
	draw_text(left+_name_wdist, top+_name_hdist+1, name)
	
	draw_set_font(old_font)
	draw_set_halign(old_halign)
	draw_set_valign(old_valign)
	
	for(var i = 0; i <= array_length(elements)-1; i++)
	{	
		if not is_array(elements[i])
		{
			elements[i].draw()
		}
		else
		{
			for(var j = 0; j <= array_length(elements[i])-1; j++)
			{
				elements[@ i, j].draw()
			}
		}
	}
}
}