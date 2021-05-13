
function Console_scrollbar() constructor{

set_pos = function(x1, y1, x2, y2)
{
	self.x1	= min(x1, x2) // Left
	self.y1	= min(y1, y2) // Top
	self.x2	= max(x1, x2) // Right
	self.y2	= max(y1, y2) // Bottom
}

initialize = function(x1, y1, x2, y2, window_width, window_height, page_width, page_height, hbar_align, vbar_align)
{
	self.mw_scroll = true
	self.resize = false
	
	self.scroll_step = o_console.SCROLLBAR.scroll_step
	
	self.set_pos(x1, y1, x2, y2)
	
	self.hbar_align = hbar_align
	self.vbar_align = vbar_align
	
	self.scroll = 0
	self.page_width = page_width
	self.page_height = page_height
	
	self.mouse_on_h = false
	self.mouse_on_v = false
	self.mouse_on_hbar = false
	self.mouse_on_vbar = false
	
	self.mouse_h_offset = 0
	self.mouse_v_offset = 0
}
}




function draw_scrollbar(scrollbar){

static sb = o_console.SCROLLBAR

with scrollbar {

var old_color = draw_get_color()
var old_font = draw_get_font()

draw_set_font(o_console.font)
var ch = string_height(" ")

var mouse_down = mouse_check_button(mb_left)

var asp = ch/sb.char_height
var _width = sb.width*asp
var _min_height = sb.min_height*asp

var mouse_on_window = gui_mouse_between(x1, y1, x2, y2)

if mw_scroll and mouse_on_window scroll += scroll_step * (mouse_wheel_up()-mouse_wheel_down()) + sb.key_scroll_step * (keyboard_check(vk_up)-keyboard_check(vk_down))

var height = clamp( (y2-y1)/page_height*(y2-y1), _min_height, (y2-y1) )

if (y2-y1) >= page_height
{
	height = (y2-y1)
	mouse_down = false
}

var _x1 = ((hbar_align == fa_left) ? x1 : x2 -_width)
var _y1 = y1+1
var _x2 = ((hbar_align == fa_left) ? x1 + _width : x2)
var _y2 = y2-1

scroll = clamp(scroll, 0, max(0, page_height))
var bar_center = y2 - scroll/page_height*-((y1+height/2)-(y2-height/2)) - height/2

var bar_p1 = bar_center + height/2
var bar_p2 = bar_center - height/2

var mouse_on_bar = mouse_on_window and gui_mouse_between(_x1, _y1, _x2, _y2)
if mouse_on_bar and not mouse_on_h and mouse_down and mouse_check_button_pressed(mb_left)
{
	if gui_mouse_between(_x1, bar_p1, _x2, bar_p2)
	{
		mouse_v_offset = bar_center-gui_my
		mouse_on_vbar = true
	}
	
	mouse_on_v = true
}

if (mouse_on_v or mouse_on_h) and not mouse_down
{
	mouse_v_offset = 0
	mouse_on_v = false
	mouse_on_vbar = false
	
	mouse_h_offset = 0
	mouse_on_h = false
	mouse_on_hbar = false
}

if mouse_on_v 
{
	scroll = clamp((-gui_my-mouse_v_offset-height/2+y2)*page_height/-((y1+height/2)-(y2-height/2)), 0, max(0, page_height))
	
	bar_center = y2 - scroll/page_height*-((y1+height/2)-(y2-height/2)) - height/2

	bar_p1 = bar_center + height/2
	bar_p2 = bar_center - height/2
}

draw_set_color(o_console.colors.body_real)
draw_rectangle(_x1, _y1, _x2, _y2, false)

draw_set_color(o_console.colors.output)
draw_rectangle(_x1, bar_p1, _x2, bar_p2, false)

draw_set_color(old_color)
draw_set_font(old_font)
}}