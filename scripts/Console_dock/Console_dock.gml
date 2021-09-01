
function element_container(elements) constructor{
	
self.elements = elements
}



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
	formatted_for_dock = true
	
	dock		= _dock
	docked		= not is_undefined(dock)
	run_in_dock = false
	
	dock_element_x = undefined
	dock_element_y = undefined
	
	name		= vesg(self, "name", instanceof(self))
	
	//dock_halign = vesg(self, "dock_halign", fa_left)
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



function new_console_dock(name, elements){

var d = new Console_dock()
d.initialize()
d.name = name
d.set(elements)
return d
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
	
	color_text = undefined
	color = "output"
	color_method = noscript
	
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
			color_text = color_method(newtext)
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
	
	var is_front = true //not docked or (docked and dock.is_front)
	
	draw_set_font(o_console.font)
	draw_set_halign(fa_left)
	draw_set_valign(fa_top)
	
	if not is_front or color_method == noscript
	{
		draw_set_color(is_front ? (is_numeric(color) ? color : o_console.colors[$ color]) : o_console.colors.body_accent)
		draw_text(x, y+1, text)
	}
	else draw_console_text(x, y+1, color_text)
	
	draw_set_color(old_color)
	draw_set_font(old_font)
	draw_set_halign(old_halign)	draw_set_valign(old_valign)
}
}



function new_cd_text(text, color){

var t = new Cd_text()
t.initialize(text)
t.color = color
return t
}



function new_cd_var(variable){
var v = new Cd_text()
v.initialize()
v.variable = variable
return v
}



function new_cd_button(name, func){
var b = new Cd_button()
b.initialize(name, func)
return b
}



function Cd_button() constructor{

set_name = function(name){
	
	var old_font = draw_get_font()
	draw_set_font(o_console.font)
	
	var cw = string_width(" ")
	var ch = string_height(" ")
	
	self.name = name
	name_width = string_width(name)/cw
	name_height = string_height(name)/ch
	
	draw_set_font(old_font)
}

initialize = function(name, func){
	
	format_for_dock()
	
	enabled = true
	
	set_name(name)
	self.func = func
	
	width = undefined
	height = undefined
	
	pressed_script = noscript
	held_script = noscript
	released_script = func
	
	x = 0
	y = 0
	
	left = 0
	top = 0
	right = 0
	bottom = 0
	
	text_x = 0
	text_y = 0
	
	mouse_on = false
	clicking = false
	
	draw_box = true
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
	
	var bt = o_console.CD_BUTTON
	
	var old_font = draw_get_font()
	draw_set_font(o_console.font)
	
	var cw = string_width(" ")
	var ch = string_height(" ")
	
	var asp = ch/bt.char_height
	
	var _wdist = round(bt.wdist*asp)
	var _hdist = round(bt.hdist*asp)
	
	var _name_width = name_width*cw
	var _name_height = name_height*ch
	
	left = x
	top = y
	
	if draw_box
	{
		right = left+_wdist*2+_name_width
		bottom = top+_hdist*2+_name_height
		
		if not is_undefined(width) right = max(right, left+width)
		if not is_undefined(height) bottom = max(bottom, top+height)
		
		text_x = left+(right-left)/2
		text_y = top+(bottom-top)/2+1
	}
	else
	{
		right = left+_name_width
		bottom = top+_name_height
		
		text_x = left+(right-left)/2
		text_y = top+1
	}
	
	mouse_on = not mouse_on_console and not clicking_on_console and gui_mouse_between(left, top, right, bottom)
	if mouse_on 
	{
		if mouse_check_button_pressed(mb_left)
		{
			clicking = true
			pressed_script()
		}
		
		mouse_on_console = true
	}
	
	if clicking and not mouse_check_button(mb_left)
	{
		clicking = false
		released_script()
	}
	
	else if clicking 
	{
		clicking_on_console = true
		held_script()
	}

	draw_set_font(old_font)
}



draw = function(){
	
	if not enabled return undefined
	
	var old_font = draw_get_font()
	var old_halign = draw_get_halign()
	var old_valign = draw_get_valign()
	
	draw_set_font(o_console.font)
	draw_set_halign(fa_center)
	draw_set_valign(fa_middle)
	
	var is_front = not (docked and not dock.is_front)
	
	if mouse_on or clicking
	{
		draw_set_color(clicking ? o_console.colors.embed_hover : o_console.colors.body_real)
		draw_rectangle(left, top, right, bottom, false)
	}
	
	
	
	
	if clicking			draw_set_color(o_console.colors.body_real)
	else if mouse_on	draw_set_color(o_console.colors.embed_hover)
	else if is_front	draw_set_color(o_console.colors.embed)
	else				draw_set_color(o_console.colors.body_accent)
	
	if not clicking draw_hollowrect(left, top, right, bottom, 1)
	
	if not is_front and not clicking and not mouse_on draw_set_color(o_console.colors.embed)
	draw_text(text_x, text_y, name)
	
	draw_set_font(old_font)
	draw_set_halign(old_halign)
	draw_set_valign(old_valign)
}
}



function Cd_checkbox() constructor{
	
}



function Cd_color_picker() constructor{
	
}



function Console_dock() constructor{

initialize = function(){
	
	format_for_dock(undefined)
	dock_valign = fa_top
	
	enabled = true
	
	name = ""
	association = noone
	
	x = 0
	y = 0
	
	left = 0
	top = 0
	right = 0
	bottom = 0
	
	width = undefined
	height = undefined
	
	_width = 0
	
	mouse_on = false
	mouse_on_bar = false
	mouse_on_dropdown = false
	
	show = true
	show_next = false
	
	show_name = true
	
	dragging = false
	mouse_xoffset = 0
	mouse_yoffset = 0
	
	is_front = false
	
	elements = []
	afterscript = ds_list_create()
}



set_element = function(x, y, element){
	
	if not is_struct(element) element = new_cd_text(element, "output")

	if is_undefined(x) elements[y] = element
	else
	{
		if y > array_length(elements)-1 array_push(elements, array_create(x+1))
		else if not is_array(elements[y]) elements[y] = [elements[y]]
		elements[y][x] = element
	}
	
	format_for_dock(element)
	element.dock_element_x = x
	element.dock_element_y = y
	
	if variable_struct_exists(element, "after_dock") ds_list_add(afterscript, element)
}



set = function(elements){
	
	if instanceof(elements) == "element_container" elements = elements.elements
	if not is_array(elements) elements = [elements]
	
	self.elements = elements
	
	for(var i = 0; i <= array_length(self.elements)-1; i++)
	{
		if not is_array(self.elements[i]) self.elements[i] = [self.elements[i]]
		
		for(var j = 0; j <= array_length(self.elements[i])-1; j++)
		{	
			set_element(j, i, self.elements[i][j])
		}
	}
}



get_input = function(){
	
	if not enabled 
	{
		left = x
		top = y
		right = x
		bottom = y
		
		dragging = false
		
		return undefined
	}
	
	var dc = o_console.DOCK
	
	var old_font = draw_get_font()
	draw_set_font(o_console.font)
	
	var cw = string_width(" ")
	var ch = string_height(" ")
	var asp = ch/dc.char_height
	var asp = ch/dc.char_height
	
	var _outline_width = round(dc.name_outline_width*asp)
	var _name_wdist = round(dc.name_wdist*asp)+_outline_width
	var _name_hdist = round(dc.name_hdist*asp)+_outline_width
	var _element_wdist = round(dc.element_wdist*asp)
	var _element_hdist = round(dc.element_hdist*asp)
	var _element_wsep = round(dc.element_wsep*asp)
	var _element_hsep = round(dc.element_hsep*asp)
	var _dropdown_base = round(dc.dropdown_base*asp)
	var _dropdown_wdist = round(dc.dropdown_wdist*asp)+_outline_width
	
	var bar_height = ch + _name_hdist*2
	
	var element_active = false
	
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
	
	if not docked
	{
		x = round(clamp(x, -(right-left)+cw*2+_dropdown_base+_dropdown_wdist, win_width-cw*3))
		y = round(clamp(y, -ch/2, win_height-ch))
	}
	
	if show_next
	{
		show = not show
		show_next = false
	}
	
	left = x
	top = y
	right = left
	bottom = top
	if show_name bottom += ch + _name_hdist*2
	
	if not show
	{
		right = left + _width
	}
	else
	{		
		if show_name right = left + string_length(name)*cw + _name_wdist*2 + _dropdown_base
		bottom += _element_hdist
		
		var xx = left + _element_wdist
		var yy = bottom
	
		var was_clicking_on_console = clicking_on_console
	
		for(var i = 0; i <= array_length(elements)-1; i++)
		{		
			var _middle
			var _bottom = yy
			
			var sized_element = false
			
			for(var j = 0; j <= array_length(elements[i])-1; j++)
			{
				var el = elements[@ i, j]
				
				if (el.right-el.left) and (el.bottom-el.top) _bottom = max(_bottom, yy+(el.bottom-el.top))
			}
			_middle = _bottom-(_bottom-yy)/2
			
			for(var j = 0; j <= array_length(elements[i])-1; j++)
			{
				var el = elements[@ i, j]
				
				var _xx = xx
				var _yy = yy
				
				if el.dock_valign == fa_middle
				{
					_yy = _middle-(el.bottom-el.top)/2
				}
				else if el.dock_valign == fa_bottom
				{
					_yy = _bottom-(el.bottom-el.top)
				}
				
				el.x = _xx
				el.y = _yy
				el.run_in_dock = true
				el.get_input()
				el.run_in_dock = false
				el.dragging = false
				el.x = _xx
				el.y = _yy
				
				if (el.right-el.left) and (el.bottom-el.top)
				{
					xx = max(xx, el.right+_element_wsep)
					right = max(right, el.right+_element_wdist)
					bottom = max(bottom, el.bottom)
					
					sized_element = true
				}
			}
	
			if not was_clicking_on_console and clicking_on_console element_active = true
	
			xx = left+_element_wdist
			yy = bottom + (_element_hsep*sized_element)
		}
		bottom += _element_hdist
		_width = right-left
	}
	
	if not is_undefined(width) right = max(right, left+width)
	if not is_undefined(height) bottom = max(top, top+height)
	
	mouse_on = not mouse_on_console and gui_mouse_between(left, top, right, bottom)
	mouse_on_bar = mouse_on and show_name and gui_mouse_between(left, top, right, top + ch + _name_hdist*2)
	
	if mouse_on_bar
	{
		var dropdown_x1 = right-_dropdown_wdist*2-_dropdown_base
		var dropdown_y1 = top
		var dropdown_x2 = right
		var dropdown_y2 = top+bar_height
		
		mouse_on_dropdown = gui_mouse_between(dropdown_x1, dropdown_y1, dropdown_x2, dropdown_y2)
	}
	else mouse_on_dropdown = false
	
	if mouse_on_dropdown
	{
		mouse_on_console = true
		if mouse_check_button_pressed(mb_left)
		{
			show_next = true
		}
	}
	
	if not mouse_on_dropdown and not clicking_on_console and mouse_check_button_pressed(mb_left) and mouse_on_bar
	{
		dragging = true
		mouse_xoffset = gui_mx-x
		mouse_yoffset = gui_my-y
	}
	
	if not docked
	{
		if dragging or element_active or (mouse_on and mouse_check_button_pressed(mb_any)) and not mouse_on_dropdown
		{
			is_front = true
		}
		else if clicking_on_console or (mouse_check_button_pressed(mb_any) and not mouse_on_dropdown)
		{
			is_front = false
		}
	}
	
	if dragging or show_next or (mouse_on and mouse_check_button_pressed(mb_any)) clicking_on_console = true
	if mouse_on mouse_on_console = true 
	
	for(var i = 0; i <= ds_list_size(afterscript)-1; i++)
	{
		afterscript[| i].after_dock()
	}
	
	draw_set_font(old_font)
}



after_dock = function(){
	is_front = dock.is_front
}



draw = function(){
	
	if not enabled return undefined
	
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
	
	var _outline_width = round(dc.name_outline_width*asp)
	var _name_wdist = round(dc.name_wdist*asp)+_outline_width
	var _name_hdist = round(dc.name_hdist*asp)+_outline_width
	var _dropdown_base = round(dc.dropdown_base*asp)
	var _dropdown_hypotenuse = round(dc.dropdown_hypotenuse*asp)
	var _dropdown_wdist = round(dc.dropdown_wdist*asp)+_outline_width
	
	var bar_height = ch + _name_hdist*2

	if docked
	{
		if is_front and show_name
		{
			draw_set_color(o_console.colors.body_real)
			draw_rectangle(left, top, right, top + bar_height, false)
		}
		draw_set_color(o_console.colors.body_accent)
		draw_hollowrect(left, top, right, bottom, _outline_width)
		
		if is_front draw_set_color(o_console.colors.output)
	}
	else
	{
		draw_console_body(left, top, right, bottom)
		
		if show_name
		{
			draw_set_color(o_console.colors.body_real)
			draw_rectangle(left, top, right, top + bar_height, false)
			draw_set_color(is_front ? o_console.colors.plain : o_console.colors.body_accent)
		}
	}
	if show_name 
	{
		draw_text(left+_name_wdist, top+_name_hdist+1, name)
	
		draw_set_color(o_console.colors.body_accent)
		draw_hollowrect(left, top, right, top + bar_height, _outline_width)

		if show
		{
			var dropdown_x1 = right-_dropdown_wdist
			var dropdown_y1 = top+bar_height/2-_dropdown_hypotenuse/2
			var dropdown_x2 = dropdown_x1-_dropdown_base
			var dropdown_y2 = dropdown_y1
			var dropdown_x3 = dropdown_x1-_dropdown_base/2
			var dropdown_y3 = dropdown_y1+_dropdown_hypotenuse
		}
		else
		{
			var dropdown_x1 = right-_dropdown_wdist-_dropdown_base/2+_dropdown_hypotenuse/2
			var dropdown_y1 = top+bar_height/2-_dropdown_base/2
			var dropdown_x2 = dropdown_x1
			var dropdown_y2 = dropdown_y1+_dropdown_base
			var dropdown_x3 = dropdown_x1-_dropdown_hypotenuse
			var dropdown_y3 = dropdown_y2-_dropdown_base/2
		}
	
		draw_set_color(o_console.colors.body_accent)
		draw_triangle(dropdown_x1, dropdown_y1, dropdown_x2, dropdown_y2, dropdown_x3, dropdown_y3, false)
	}
	
	draw_set_color(old_color)
	draw_set_font(old_font)
	draw_set_halign(old_halign)
	draw_set_valign(old_valign)
	
	if show
	{
		for(var i = 0; i <= array_length(elements)-1; i++)
		{	
			if not is_array(elements[i])
			{
				var el = elements[i]
				el.run_in_dock = true
				el.draw()
				el.run_in_dock = false
			}
			else
			{
				for(var j = 0; j <= array_length(elements[i])-1; j++)
				{
					var el = elements[@ i, j]
					el.run_in_dock = true
					el.draw()
					el.run_in_dock = false
				}
			}
		}
	}
	
	draw_set_color(old_color)
	draw_set_font(old_font)
	draw_set_halign(old_halign)
	draw_set_valign(old_valign)
}



destroy = function(){
	
	for(var i = 0; i <= array_length(elements)-1; i++)
	{	
		if not is_array(elements[i])
		{
			if variable_struct_exists(elements[i], "destroy") elements[i].destroy()
		}
		else
		{
			for(var j = 0; j <= array_length(elements[i])-1; j++)
			{
				if variable_struct_exists(elements[@ i, j], "destroy") elements[@ i, j].destroy()
			}
		}
	}
	
	elements = []
	ds_list_destroy(afterscript)
	afterscript = -1
}
}