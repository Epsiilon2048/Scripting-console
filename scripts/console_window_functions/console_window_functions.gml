
function Console_window() constructor{
	// str, scr, args, col, scrcol

	initialize = function(_name, _x, _y, _side){
		self.name		= _name
		self.x			= _x
		self.y			= _y
		self.starting_x = _x
		self.starting_y = _y
		self.side		= _side
		
		self.width	= o_console.WINDOW.width
		self.height	= o_console.WINDOW.height
		
		self.text = new Embedded_text()
		self.plaintext  = ""
		self.text_w = 0
		self.text_h = 0
		
		self.enabled			= true
		self.show				= true
		self.mouse_over_sidebar = false
		self.sidebar			= 0
	}
	set = function(_text){
		
		if is_struct(_text) and asset_get_index( instanceof(_text) ) == Embedded_text
		{
			self.text = struct_copy(_text)
		}
		else
		{
			self.text.set(_text)
		}
		
		self.plaintext = text.plaintext
		
		self.text_w = text.width*string_width(" ")
		self.text_h = text.height*string_height(" ")
	}
	reset_pos = function(){
		if self.side == SIDES.LEFT
		{
			self.x = self.starting_x
			self.y = self.starting_y
		}
		else if self.side == SIDES.RIGHT
		{
			self.x = display_get_gui_width() - self.starting_x
			self.y = self.starting_y
		}
	}
	destroy = function(){

	}
}
	
	
	

function window_embed(text){ with o_console {

Window.set(text)
Window.enabled = true
Window.show = true

window_reset_pos()

return "Set window text"
}}