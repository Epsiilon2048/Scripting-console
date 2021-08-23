
function Console_window() constructor{

set = function(_text){
		
	var old_font = draw_get_font()
	draw_set_font(o_console.font)
		
	if is_struct(_text) and asset_get_index( instanceof(_text) ) == Embedded_text
	{
		self.has_embed = true
		struct_replace(self.text, _text)
	}
	else
	{
		self.has_embed = false
		self.text.set(_text)
	}
		
	self.plain = text.plain
		
	self.text_w = text.width*string_width(" ")
	self.text_h = text.height*string_height(" ")
		
	draw_set_font(old_font)
}
	
reset_pos = function(){
		
	x = init_x
	y = init_y
}

initialize = function(x, y, sidebar_side){
		
	self.name = ""
		
	self.x = x
	self.y = y
	self.init_x = x
	self.init_y = y
		
	self.width = o_console.WINDOW.width
	self.height = o_console.WINDOW.height
		
	self.left = x
	self.top = y
	self.right = x
	self.bottom = y
		
	self.sidebar_x = x
		
	self.sidebar_side = sidebar_side
	self.valign = fa_top
		
	self.mouse_on = false
	self.mouse_on_sidebar = false
	
	self.dragging = false
	self.mouse_offsetx = 0
	self.mouse_offsety = 0
		
	self.right_mb = false
		
	self.text = new Embedded_text()
	self.text.set()
	
	self.ctx = new Ctx_menu()
	self.ctx.scope = noone
	self.ctx.set([
		{str: "Copy",			scr: function(scope){ clipboard_set_text(scope.text.plain) }, arg: self},
		{str: "Clear",			output: true},
		{str: "Set window",		scr: window_set_output},
	])
		
	self.scrollbar = new Console_scrollbar()
	self.scrollbar.initialize(x, y, x+self.width, y+self.width, 0, 0, 0, 0, 0, 0, 0)
		
	self.has_embed = false
		
	self.enabled = true
	self.show = true
		
	self.sidebar = 0
		
	self.set()
}


get_input = function(){
	console_window_inputs(self)
}


draw = function(){
	draw_console_window(self)
}
}