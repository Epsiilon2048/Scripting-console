
function new_scrollbar(width=400, height=600){
	var sc = new Console_scrollbar()
	sc.initialize()
	sc.set_page_boundaries(width, height)
	sc.wbar_enabled = false
	sc.hbar_enabled = true
	return sc
}

function new_scrollbar_side(width=400, height=600){
	var sc = new_scrollbar(width, height)
	sc.wbar_enabled = true
	return sc
}


function Console_scrollbar() constructor{

initialize = function(){
	enabled = true
	show = true
	
	wbar_enabled = true
	hbar_enabled = true

	condensed = false
	//wresize = false
	//hresize = false

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
	mouse_on_wbutton = false
	mouse_on_hbutton = false
	
	wscrolling = false
	hscrolling = false
	wresizing = false
	hresizing = false
	
	_bar_width = 0
}



set_page_boundaries = function(page_width, page_height){
	
	self.page_width = page_width
	self.page_height = page_height
	
	var w = (page_right-page_left)
	var h = (page_bottom-page_top)
	
	wbar_length = min(w, floor(clamp((page_right-page_left-1)/self.page_width, 0, self.page_width)*(page_right-page_left)))
	hbar_length = min(h, floor(clamp((page_bottom-page_top-1)/self.page_height, 0, self.page_height)*(page_bottom-page_top)))
	
	wbar_min = floor(page_left+wbar_length/2)
	wbar_max = floor(page_right-wbar_length/2)
	if wbar_min != wbar_max wbar_max --
	
	hbar_min = floor(page_top+hbar_length/2)
	hbar_max = floor(page_bottom-hbar_length/2)
	if hbar_min != hbar_max hbar_max --
	
	set_scroll(scroll_x, scroll_y)
}



set_boundaries = function(page_width, page_height, page_left, page_top, page_right, page_bottom){

	self.page_left = page_left
	self.page_top = page_top
	self.page_right = page_right
	self.page_bottom = page_bottom
	
	set_page_boundaries(page_width, page_height)
}



set_scroll_x = function(scroll_x){
	
	var scroll_x_max = max(0, page_width-(page_right-page_left))
		
	self.scroll_x = clamp(scroll_x, 0, scroll_x_max)
	
	if scroll_x_max == 0 wbar_center = wbar_min
	else wbar_center = wbar_min + (wbar_max-wbar_min)*(self.scroll_x/scroll_x_max)
}



set_scroll_y = function(scroll_y){
	var scroll_y_max = max(0, page_height-(page_bottom-page_top))
	
	self.scroll_y = clamp(scroll_y, 0, scroll_y_max)
	
	if scroll_y_max == 0 hbar_center = hbar_min
	else hbar_center = hbar_min + (hbar_max-hbar_min)*(self.scroll_y/scroll_y_max)
}



set_scroll = function(scroll_x, scroll_y){
	set_scroll_x(scroll_x)
	set_scroll_y(scroll_y)
}



get_input = function(){
	
	var sc = o_console.SCROLLBAR
	
	draw_set_font(o_console.font)
	var cw = string_width("W")
	var ch = string_height("W")
	var asp = ch/sc.char_height
	_bar_width = round((condensed ? sc.bar_width_condensed : sc.bar_width)*asp)
	
	wbar_bottom = page_bottom+_bar_width
	hbar_right = page_right+_bar_width
	
	var mouse_left_pressed = mouse_check_button_pressed(mb_left)
	var mouse_left = mouse_check_button(mb_left)
	
	if not wscrolling and not hscrolling
	{
		if not mouse_on_console and not clicking_on_console
		{
			mouse_on = gui_mouse_between(page_left, page_top, hbar_right, wbar_bottom)
			mouse_on_wbar = gui_mouse_between(page_right, page_bottom, page_left, wbar_bottom)
			mouse_on_wbutton = false
			mouse_on_hbar = not mouse_on_wbar and gui_mouse_between(page_right, page_top, hbar_right, page_bottom)
			mouse_on_hbutton = false
			
			var scrollwheel = mouse_wheel_down()-mouse_wheel_up()
			if mouse_on and scrollwheel != 0
			{
				if hbar_enabled
				{
					set_scroll_y(scroll_y + scrollwheel*sc.scrollwheel_lines*ch)
				}
				else if wbar_enabled
				{
					set_scroll_x(scroll_x - scrollwheel*sc.scrollwheel_lines*cw*2)
				}
			}
			
			if mouse_on_wbar
			{
				var wbar_x1 = floor(wbar_center - wbar_length/2)
				var wbar_x2 = floor(wbar_center + wbar_length/2)
				mouse_on_wbutton = gui_mouse_between(wbar_x1, page_bottom, wbar_x2, wbar_bottom)
			}
			else if mouse_on_hbar
			{
				var hbar_y1 = floor(hbar_center - hbar_length/2)
				var hbar_y2 = floor(hbar_center + hbar_length/2)
				mouse_on_hbutton = gui_mouse_between(page_right, hbar_y1, hbar_right, hbar_y2)
			}
			//mouse_on_console = true
		}
	
		if mouse_left_pressed
		{
			if mouse_on_wbar
			{
				wscrolling = true
				clicking_on_console = true
				
				if not mouse_on_wbutton sc.mouse_offset = 0
				else sc.mouse_offset = gui_mx-wbar_center
			}
			if mouse_on_hbar
			{
				hscrolling = true
				clicking_on_console = true
				
				if not mouse_on_hbutton sc.mouse_offset = 0
				else sc.mouse_offset = gui_my-hbar_center
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
		var scroll_x_max = max(0, page_width-(page_right-page_left))
		
		wbar_center = clamp(gui_mx-sc.mouse_offset, wbar_min, wbar_max)
		
		if wbar_max == wbar_min scroll_x = 0
		else scroll_x = floor(scroll_x_max*((wbar_center-wbar_min)/(wbar_max-wbar_min)))
		clicking_on_console = true
		
	}
	else if hscrolling
	{
		var scroll_y_max = max(0, page_height-(page_bottom-page_top))
		
		hbar_center = clamp(gui_my-sc.mouse_offset, hbar_min, hbar_max)
		
		if hbar_max == hbar_min scroll_y = 0
		else scroll_y = floor(scroll_y_max*((hbar_center-hbar_min)/(hbar_max-hbar_min)))
		clicking_on_console = true
	}
}



draw = function(){
	
	var old_color = draw_get_color()
	
	var wbar_x1 = floor(wbar_center - wbar_length/2)
	var wbar_x2 = floor(wbar_center + wbar_length/2)
	var hbar_y1 = floor(hbar_center - hbar_length/2)
	var hbar_y2 = floor(hbar_center + hbar_length/2)
	
	
	if wbar_enabled and hbar_enabled draw_console_body(page_left, page_bottom, hbar_right, wbar_bottom)
	else if wbar_enabled draw_console_body(page_left, page_bottom, page_right-1, wbar_bottom)
	
	if hbar_enabled draw_console_body(page_right, page_top, hbar_right, page_bottom-1)
	
	draw_set_color(o_console.colors.output)
	if wbar_enabled and wbar_length > 0 draw_rectangle(wbar_x1, page_bottom, wbar_x2, wbar_bottom, false)
	if hbar_enabled and hbar_length > 0 draw_rectangle(page_right, hbar_y1+1, hbar_right, hbar_y2+1, false)
	
	draw_set_color(old_color)
}
}