
function call_color_box(variable, x=gui_mx, y=gui_my, scope=self, association=o_console.object){ with o_console.COLOR_PICKER {
	
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