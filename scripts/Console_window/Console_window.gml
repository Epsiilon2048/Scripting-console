// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
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
		
		self.text		= []
		self.plaintext  = ""
		self.text_w = 0
		self.text_h = 0
		
		self.enabled			= true
		self.show				= true
		self.mouse_over_sidebar = false
		self.sidebar			= 0
	}
	set = function(_text, _plaintext){
		draw_set_font(o_console.font)
		self.text = _text
		
		if is_undefined(_plaintext) self.plaintext = embedded_text_get_plain(_text)
		else self.plaintext = _plaintext
		
		self.text_w = string_width(plaintext)
		self.text_h = string_height(" ")*(string_count("\n", plaintext)+1)
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
		else if self.side == SIDES.BOTTOM
		{
			self.x = self.starting_x
			self.y = display_get_gui_height() - self.starting_y
		}
	}
	destroy = function(){

	}
}