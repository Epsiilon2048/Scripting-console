
function Console_dock() constructor{

initialize = function(){
	
	name = ""
	association = noone
	
	x = 0
	y = 0
	
	left = 0
	top = 0
	right = 0
	bottom = 0
	
	dragging = false
	mouse_xoffset = 0
	mouse_yoffset = 0
	
	elements = []
}

get_input = function(){
	
	var dc = o_console.DOCK
	
	var old_font = draw_get_font()
	draw_set_font(o_console.font)
	
	var cw = string_width(" ")
	var ch = string_height(" ")
	var asp = ch/dc.char_height
	
	var _name_wdist = dc.name_wdist*asp
	var _name_hdist = dc.name_hdist*asp
	var _element_wdist = dc.element_wdist*asp
	var _element_hdist = dc.element_hdist*asp
	var _element_wsep = dc.element_wsep*asp
	var _element_hsep = dc.element_hsep*asp
	
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
	bottom = y + ch + _name_hdist*2
	
	var xx
	var yy = y + _element_hdist + ch + _name_hdist*2
	
	for(var i = 0; i <= array_length(elements)-1; i++)
	{
		xx = x + _element_wdist
		
		if not is_array(elements[i])
		{
			if is_string(elements[i])
			{
				var sw = string_width(elements[i])
				var sh = string_height(elements[i])
				
				yy = max(yy, sh+_element_hsep)
				right = max(right, right+sw)
				bottom = max(bottom, bottom+sh)
			}
			else
			{
				var el = elements[i]
				
				el.x = xx
				el.y = yy
				el.get_input()
				el.x = xx
				el.y = yy
				
				yy = max(yy, el.bottom+_element_hsep)
				right = max(right, el.right+_element_wdist)
				bottom = max(bottom, el.bottom)
			}
		}
		else
		{
			for(var j = 0; j <= array_length(elements[i])-1; j++)
			{
				// do same thing
			}
		}
	}
	bottom += _element_hdist
	
	if mouse_check_button_pressed(vk_left) and gui_mouse_between(left, top, right, top + ch + _name_hdist*2)
	{
		dragging = true
	}
	
	draw_set_font(old_font)
}
}