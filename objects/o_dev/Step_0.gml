
if init
{
	
	w=sprite_get_width(s_scrollbar_tester)
	h=150
	scr=new Console_scrollbar()
	scr.initialize(x, y, x+w+o_console.SCROLLBAR.width, y+h, w, h, sprite_get_width(s_scrollbar_tester), sprite_get_height(s_scrollbar_tester), fa_right, fa_bottom)
	
	dev_console_init()
	init = false
}