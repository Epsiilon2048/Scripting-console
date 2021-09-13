
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
	
	name = vesg(self, "name", instanceof(self))
	if name == "struct" name = "element"
	
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



function element_container(elements) constructor{
	
self.elements = elements
}



function new_console_dock(name, elements){

var d = new Console_dock()
d.initialize()
d.name = name
d.set(elements)
return d
}



function Console_dock() constructor{

initialize = function(){
	
	docked = false
	dock_valign = fa_top
	
	enabled = true
	
	name = ""
	association = self
	
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
	
	allow_element_dragging = true
	
	is_front = false
	
	elements = []
	e = {}
	afterscript = ds_list_create()
}



update_elements = function(y){
	
	for(var i = y; i <= array_length(elements)-1; i++)
	for(var j = 0; j <= array_length(elements[i])-1; j++)
	{
		var el = elements[@ i, j]
		
		el.dock_element_x = j
		el.dock_element_y = i
	}
}



set_element = function(x, y, element){
	
	if not is_struct(element) element = new_cd_text(string(element), "output")

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
	
	add_element(element)
	
	if variable_struct_exists(element, "after_dock") ds_list_add(afterscript, element)
}



remove_element = function(element){
	
	var xx = element.dock_element_x
	var yy = element.dock_element_y
	
	variable_struct_remove(e, element.id)
	array_delete(elements[yy], xx, 1)
	ds_list_delete(afterscript, ds_list_find_index(afterscript, element))
	
	if elements[yy] = [] array_delete(elements, yy, 1)
	
	update_elements(yy)
}



destroy_element = function(element){
	
	remove_element(element)
	if variable_struct_exists(element, "destroy") element.destroy()
}



insert_horizontal = function(x, y, element){
	
	y = max(y, array_length(elements))
	if y == array_length(elements) array_push(elements, [])
	y = max(x, array_length(elements[y]))

	array_insert(elements[y], x, undefined)
	set_element(x, y, element)
	update_elements(y)
}



insert_vertical = function(y, element){
	
	y = max(y, array_length(elements))
	
	array_insert(elements, y, [])
	set_element(0, y, element)
	update_elements(y+1)
}



set = function(elements){
	
	clear()
	
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
	
	get_input()
}



get_printout = function(){
	
	var printout = ""
	
	for(var i = 0; i <= array_length(elements)-1; i++)
	for(var j = 0; j <= array_length(elements[i])-1; j++)
	{
		var el = elements[@ i, j]
		if variable_struct_exists(el, "get_printout")
		{
			var print = el.get_printout()
			if not is_undefined(print) printout += string(print)+"\n"
		}
	}
	
	return (docked ? "\n" : "") + printout
}



after_dock = function(){ 
	is_front = dock.is_front
	if not dragging and dock_element_x == (array_length(dock.elements[dock_element_y])-1)
	{
		var old_font = draw_get_font()
		draw_set_font(o_console.font)
	
		var asp = string_height(" ")/o_console.DOCK.char_height
	
		var _element_wdist = round(o_console.DOCK.element_wdist*asp)
		
		right = dock.right-_element_wdist
		get_dropdown_input()
		
		draw_set_font(old_font)
	}
}



get_dropdown_input = function(){
	
	var dc = o_console.DOCK
	
	var old_font = draw_get_font()
	draw_set_font(o_console.font)
	
	var ch = string_height(" ")
	var asp = ch/dc.char_height

	var _outline_width = round(dc.name_outline_width*asp)
	var _name_hdist = round(dc.name_hdist*asp)+_outline_width
	var _dropdown_base = round(dc.dropdown_base*asp)
	var _dropdown_wdist = round(dc.dropdown_wdist*asp)+_outline_width
	
	var bar_height = ch + _name_hdist*2
	
	var dropdown_x1 = right-_dropdown_wdist*2-_dropdown_base
	var dropdown_y1 = top
	var dropdown_x2 = right
	var dropdown_y2 = top+bar_height
		
	mouse_on_dropdown = gui_mouse_between(dropdown_x1, dropdown_y1, dropdown_x2, dropdown_y2)
	
	if mouse_on_dropdown
	{
		mouse_on_console = true
		if mouse_check_button_pressed(mb_left)
		{
			show_next = true
		}
	}
	draw_set_font(old_font)
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
	
	var _outline_width = round(dc.name_outline_width*asp)
	var _name_wdist = round(dc.name_wdist*asp)+_outline_width
	var _name_hdist = round(dc.name_hdist*asp)+_outline_width
	var _element_wdist = round(dc.element_wdist*asp)
	var _element_hdist = round(dc.element_hdist*asp)
	var _element_wsep = round(dc.element_wsep*asp)
	var _element_hsep = round(dc.element_hsep*asp)
	var _dropdown_base = round(dc.dropdown_base*asp)
	var _dropdown_wdist = round(dc.dropdown_wdist*asp)+_outline_width
	var _dragging_radius = round(dc.dragging_radius*asp)
	
	var element_active = false
	var was_clicking_on_console = clicking_on_console
	
	if docked association = dock.association
	
	if dragging
	{
		if not mouse_check_button(mb_left) dragging = false
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

	var dragging_radius_met = true

	var el = o_console.element_dragging
	if allow_element_dragging and dragging_radius_met and el != noone and el.docked and el.dock == self
	{
		dragging_radius_met = _dragging_radius <= point_distance(mouse_xoffset, mouse_yoffset, gui_mx, gui_my)
		el.get_input()
		
		if not el.dragging and not mouse_on
		{
			if variable_struct_exists(el, "undock") el.undock()
			remove_element(el)
			is_front = false
			el.dock = undefined
			el.docked = false
			add_console_element(el)
		}
	}
	
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
				
				_xx = floor(_xx)
				_yy = floor(_yy)

				if not allow_element_dragging or not el.dragging or not dragging_radius_met
				{
					var was_dragging = el.dragging
					
					el.x = _xx
					el.y = _yy
					el.run_in_dock = true
					el.get_input()
					el.run_in_dock = false
					el.x = _xx
					el.y = _yy
					
					if el.dragging
					{
						if not was_dragging and allow_element_dragging
						{
							mouse_xoffset = gui_mx
							mouse_yoffset = gui_my
						}
						else if not allow_element_dragging
						{
							el.dragging = false
							if o_console.element_dragging == el o_console.element_dragging = noone
						}
					}
				}
				
				var el_width = (el.right-el.left)
				var el_height = (el.bottom-el.top)
				
				if el_width or el_height
				{
					// Initially it just used the right/bottom of the element to determine
					// the position of the next, but once dragging was introduced it had
					// to instead use the width/height - this works for elements that
					// aren't being dragged, but for the sake of consistency I'm keeping
					// it as it was for elements which aren't being dragged.
					
					if el.dragging
					{
						right = max(right, xx+el_width)
						bottom = max(bottom, yy+el_height)
						xx = max(xx, xx+el_width+_element_wsep)
					}
					else
					{
						right = max(right, el.right)
						bottom = max(bottom, el.bottom)
						xx = max(xx, el.right+_element_wsep)
					}
					
					sized_element = true
				}
			}
	
			if not was_clicking_on_console and clicking_on_console element_active = true
	
			xx = left + _element_wdist
			yy = bottom + (_element_hsep*(sized_element or i != 0))
		}
		right += _element_wdist
		bottom += _element_hdist
		_width = right-left
	}
	
	if not is_undefined(width) right = max(right, left+width)
	if not is_undefined(height) bottom = max(top, top+height)
	
	mouse_on = not was_clicking_on_console and gui_mouse_between(left, top, right, bottom)
	mouse_on_bar = mouse_on and show_name and gui_mouse_between(left, top, right, top + ch + _name_hdist*2)
	
	if not docked get_dropdown_input()
	
	if not mouse_on_dropdown and not clicking_on_console and mouse_check_button_pressed(mb_left) and mouse_on_bar
	{
		dragging = true
		mouse_xoffset = gui_mx-x
		mouse_yoffset = gui_my-y
		
		o_console.element_dragging = self
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



draw = function(){
	
	if right == x and bottom == y return undefined
	
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

	if docked and not dragging
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
	
	if show for(var i = 0; i <= array_length(elements)-1; i++) for(var j = 0; j <= array_length(elements[i])-1; j++)
	{	
		var el = elements[@ i, j]
					
		if not el.dragging
		{
			el.run_in_dock = true
			el.draw()
			el.run_in_dock = false
		}
	}
	
	draw_set_color(old_color)
	draw_set_font(old_font)
	draw_set_halign(old_halign)
	draw_set_valign(old_valign)
}



clear = function(){
	
	for(var i = 0; i <= array_length(elements)-1; i++) for(var j = 0; j <= array_length(elements[i])-1; j++)
	{	
		if variable_struct_exists(elements[@ i, j], "destroy") elements[@ i, j].destroy()
	}
	
	elements = []
	e = {}
}



destroy = function(){
	
	clear()
	ds_list_destroy(afterscript)
	afterscript = -1
	enabled = false
}
}