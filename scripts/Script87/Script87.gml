
function call_color_box(variable, x, y){ 
	
	var association = self
	
	with o_console.COLOR_PICKER {
		
	if is_undefined(x) x = gui_mx
	if is_undefined(y) y = gui_my
	
	ignore_input = true
	
	with global_box
	{
		enabled = true
		self.variable = variable
		self.association = association
			
		if x+width > gui_width self.x = x-width-1
		else self.x = x+1
			
		if y-height < 0 self.y = y+1
		else self.y = y-height-1
	}
}
}