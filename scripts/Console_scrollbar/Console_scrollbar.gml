function Console_scrollbar() constructor{

initialize = function(){
	
	enabled = true
	show = true
	
	page_left = 0
	page_top = 0
	page_right = 0
	page_bottom = 0
	
	wbar_bottom = 0
	hbar_right = 0
	
	page_width = 0
	page_height = 0
	
	scroll_x = 0
	scroll_y = 0
	
	condensed = false
	wresize = false
	hresize = false
	
	wbar_length = 0
	hbar_length = 0
	
	wbar_min = 0
	wbar_max = 0
	hbar_min = 0
	hbar_max = 0
	
	wbar_center = 0
	hbar_center = 0
	
	mouse_on = false
	mouse_on_wbar = false
	mouse_on_hbar = false
	wscrolling = false
	hscrolling = false
	wresizing = false
	hresizing = false
}



set_page_boundaries = function(page_width, page_height){
	
	var old_font = draw_get_font()
	draw_set_font(o_console.font)
	var ch = string_height("W")
	var sc = o_console.SCROLLBAR
	var asp = ch/sc.char_height
	var _bar_width = round((condensed ? sc.bar_width_condensed : sc.bar_width)*asp)
	
	self.page_width = page_width
	self.page_height = page_height
	
	wbar_length = clamp((page_right-page_left)/self.page_width, 0, self.page_width)
	hbar_length = clamp((page_bottom-page_top)/self.page_height, 0, self.page_height)
	
	wbar_min = page_right+hbar_length/2
	wbar_min = page_left-hbar_length/2
	
	hbar_min = page_top+wbar_length/2
	hbar_min = page_bottom-wbar_length/2
	
	wbar_bottom = page_top+_bar_width
	hbar_right = page_right+_bar_width
	
	set_scroll(scroll_x, scroll_y)

	draw_set_font(old_font)
}



set_boundaries = function(page_width, page_height, page_left, page_top, page_right, page_bottom){

	self.page_left = page_left
	self.page_top = page_top
	self.page_right = page_right
	self.page_bottom = page_bottom
	
	set_page_boundaries(page_width, page_height)
}



set_scroll = function(scroll_x, scroll_y)
{
	var scroll_x_max = page_width-(page_right-page_left)
	var scroll_y_max = page_height-(page_bottom-page_top)
	
	self.scroll_x = clamp(scroll_x, 0, scroll_x_max)
	self.scroll_y = clamp(scroll_y, 0, scroll_y_max)
	wbar_center = wbar_min + (wbar_max-wbar_min)*(self.scroll_x/scroll_x_max)
	hbar_center = hbar_min + (hbar_max-hbar_min)*(self.scroll_y/scroll_y_max)
}



get_input = function(){
	
	var sc = o_console.SCROLLBAR
	
	var mouse_left_pressed = mouse_check_button_pressed(mb_left)
	var mouse_left = mouse_check_button(mb_left)
	
	if not wscrolling and not hscrolling
	{
		if not mouse_on_console and not clicking_on_console
		{
			mouse_on_wbar = gui_mouse_between(page_right, page_bottom, page_left, wbar_bottom)
			mouse_on_hbar = not mouse_on_wbar and gui_mouse_between(page_right, page_top, hbar_right, page_bottom)
			mouse_on_console = true
		}
	
		if mouse_left_pressed
		{
			if mouse_on_wbar
			{
				wscrolling = true
				sc.mouse_offset = mouse_x-wbar_center
				clicking_on_console = true
			}
			if mouse_on_hbar
			{
				hscrolling = true
				sc.mouse_offset = mouse_y-hbar_center
				clicking_on_console = true
			}
		}
	}
	else if not mouse_left
	{
		wscrolling = false
		hscrolling = false
	}
	else if wscrolling
	{
		var scroll_x_max = page_width-(page_right-page_left)
		
		wbar_center = clamp(gui_mx-sc.mouse_offset, wbar_min, wbar_max)
		scroll_x = scroll_x_max*((wbar_center-wbar_min)/(wbar_max-wbar_min))
		clicking_on_console = true
		
	}
	else if hscrolling
	{
		var scroll_y_max = page_height-(page_bottom-page_top)
		
		hbar_center = clamp(gui_my-sc.mouse_offset, hbar_min, hbar_max)
		scroll_y = scroll_y_max*((hbar_center-hbar_min)/(hbar_max-hbar_min))
		clicking_on_console = true
	}
}



draw = function(){
	
	var old_color = draw_get_color()
	
	var wbar_x1 = wbar_center - wbar_length/2
	var wbar_x2 = wbar_center + wbar_length/2
	var hbar_y1 = hbar_center - hbar_length/2
	var hbar_y2 = hbar_center + hbar_length/2
	
	//draw_console_body(page_left, page_bottom, hbar_right, wbar_bottom)
	draw_console_body(page_right, page_top, hbar_right, page_bottom)
	draw_set_color(o_console.colors.output)
	//draw_rectangle(wbar_x1, page_bottom, wbar_x2, wbar_bottom, false)
	draw_rectangle(page_right, hbar_y1, hbar_right, hbar_y2, false)
	
	draw_set_color(old_color)
}
}