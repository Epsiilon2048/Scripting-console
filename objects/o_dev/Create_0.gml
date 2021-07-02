
init = true

f=[0]


tb = new Text_box()
tb.initialize() with tb{
	x = other.x
	y = other.y
	//format_scrubber()
	set_value(1234)
}

w=150
h=150
//scr=new Console_scrollbar()
//scr.initialize(x, y, x+w, y+h, w, h, sprite_get_width(s_scrollbar_tester), sprite_get_height(s_scrollbar_tester), fa_left, fa_bottom)