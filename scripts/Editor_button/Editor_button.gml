// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function Editor_button() constructor{

	initialize = function(e)
	{
		self.id = other.button_id
		other.button_id ++
		
		self.icon	= e.icon
		self.x		= e.x
		self.y		= e.y
		
		self.context = e.context

		self.clicking = false
	}
}