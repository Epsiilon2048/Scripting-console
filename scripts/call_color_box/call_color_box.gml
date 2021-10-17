
function call_color_box(variable, x, y){

call_color_box_ext(variable, x, y, self, o_console.object)
}



function call_color_box_ext(variable, x, y, scope, association){ with o_console.COLOR_PICKER {
		
if is_undefined(x) x = gui_mx
if is_undefined(y) y = gui_my
	
ignore_input = true
	
with global_color_picker
{
	enabled = true
	self.variable = variable
	self.association = association
	self.scope = scope
			
	if x+width > gui_width self.x = x-width-5
	else self.x = x+5
			
	if y-height < 0 self.y = y+5
	else self.y = y-height-5
		
	hue = color_get_hue(color)
	update_variable()
}
}}