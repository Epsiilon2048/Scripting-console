

function format_for_ctx_menu(scope){

var vesg = variable_struct_exists_get
var _menu

if is_undefined(scope) 
{
	scope = self
	_menu = undefined
}
else _menu = self
with scope
{
	formatted_for_ctx_menu = true
	
	ctx_menu	= _menu
	in_ctx_menu	= not is_undefined(ctx_menu)
	run_in_ctx_menu = false
	ctx_mouse_on = false
	ctx_clicking = false
	
	ctx_element_y = undefined

	x				= vesg(self, "x", 0)
	y				= vesg(self, "y", 0)
	left			= vesg(self, "left", 0)
	top				= vesg(self, "top", 0)
	right			= vesg(self, "right", 0)
	bottom			= vesg(self, "bottom", 0)
	ctx_func		= vesg(self, "ctx_func", noscript)
	ctx_close		= vesg(self, "ctx_close", false)
	ctx_add_dist	= vesg(self, "ctx_add_dist", true)
}
}



function Ctx_container() constructor{


}



function new_ctx_text(text, func){

var t = new Ctx_text()
t.initialize(text, func)
return t
}



function Ctx_text() constructor{

initialize = function(text, func)
{
	self.text = text
	
	ctx_func = func
	ctx_close = true
	ctx_add_dist = false
	ctx_mouse_on = false
	ctx_clicking = false
	
	x = 0
	y = 0
	
	left = 0
	top = 0
	right = 0
	bottom = 0
	
	color = "output"

	var old_font = draw_get_font()
	draw_set_font(o_console.font)

	width = string_width(text)/string_width(" ")
	height = string_height(text)/string_height(" ")
	
	draw_set_font(old_font)
}


get_input = function(){
	
	draw_set_font(o_console.font)
	
	left = x
	top = y
	right = x+width*string_width(" ")
	bottom = y+height*string_height(" ")
}


draw = function(){
	
	draw_set_color(is_numeric(color) ? color : o_console.colors[$ color])
	draw_set_font(o_console.font)
	draw_set_halign(fa_left)
	draw_set_valign(fa_top)
	
	draw_text(left, top-1, text)
}
}





function ctx_menu_set_ext(elements, x, y){ with o_console.CTX_MENU {

enabled = true
init = true
self.x = x+1
self.y = y+1
self.elements = elements

for(var i = 0; i <= array_length(self.elements)-1; i++)
{
	var el = self.elements[i]
	format_for_ctx_menu(el)
	el.ctx_element_y = i
}
}}



function ctx_menu_set(elements){
	
ctx_menu_set_ext(elements, gui_mx, gui_my)
}



function ctx_menu_get_input(){ with o_console.CTX_MENU {

left = x
top = y
right = x
bottom = y

if not enabled or array_length(elements) == 0
{
	prev_right = x
	
	mouse_on = false
	clicking = false
	element_mouse_on = -1
	element_clicking = -1
	
	return undefined
}

draw_set_font(o_console.font)
var ch = string_height(" ")
var asp = ch/char_height

var _wdist = round(wdist*asp)
var _hdist = round(hdist*asp)
var _sep = round(sep*asp)

var released = false
var mouse_can_be_on = gui_mx >= left and gui_my >= top
mouse_on = false

bottom += _sep/2-1
for(var i = 0; i <= array_length(elements)-1; i++)
{
	var el = elements[i]
	
	if i == 0 and el.ctx_add_dist bottom += _sep/2
	
	el.x = left+_wdist
	el.y = bottom
	el.run_in_ctx_menu = true
	el.get_input()
	el.run_in_ctx_menu = false
	el.x = left+_wdist
	el.y = bottom
	
	var y1 = bottom-_sep/2
	
	right = max(right, el.right)
	bottom = max(bottom, el.bottom)
	
	bottom += _sep/2

	var y2 = bottom-_sep/2
	
	mouse_on = mouse_on or gui_mouse_between(left, y1, prev_right, y2)
	
	if mouse_on and mouse_can_be_on
	{
		mouse_on = true
		el.ctx_mouse_on = true
		mouse_on_console = true
		mouse_can_be_on = false
		element_mouse_on = i
		
		moe_y1 = y1+1
		moe_y2 = y2
		
		if mouse_check_button_pressed(mb_any)
		{
			clicking = true
			element_clicking = i
		}
	}
	else el.ctx_mouse_on = false
	
	if clicking and element_clicking == i
	{
		if mouse_check_button(mb_any)
		{
			mce_y1 = y1+1
			mce_y2 = y2
			
			el.ctx_clicking = true
			clicking_on_console = true
		}
		else
		{	
			if element_mouse_on == i
			{
				el.ctx_func()
				if el.ctx_close enabled = false
			}
			else released = el.ctx_close
			
			clicking = false
			element_mouse_on = -1
			element_clicking = -1
		}
	}
	else el.ctx_clicking = false
}

if not mouse_on
{
	element_mouse_on = -1
	
	if not init and (mouse_check_button_pressed(mb_any) or released) enabled = false
}

right += _wdist

if not el.ctx_add_dist bottom += -_sep/2

prev_right = right
init = false

if not enabled
{
	right = left
	bottom = top
}
}}



function draw_ctx_menu(){ with o_console.CTX_MENU {

if right == left or bottom == top return undefined

draw_set_color(o_console.colors.body_real)
draw_rectangle(left, top, right, bottom, false)

for(var i = 0; i <= array_length(elements)-1; i++)
{	
	var el = elements[i]
	el.run_in_ctx_menu = true
	el.draw()
	el.run_in_ctx_menu = false
	
	if (el.ctx_close or el.ctx_func != noscript) and (element_clicking == i or element_mouse_on == i)
	{
		draw_set_color(o_console.colors.plain)
		
		if element_clicking == i 
		{
			draw_set_alpha(clicking_alpha)
			draw_rectangle(left, mce_y1, right, mce_y2, false)
		}
		else 
		{
			draw_set_alpha(mouse_on_alpha)
			draw_rectangle(left, moe_y1, right, moe_y2, false)
		}
		
		draw_set_alpha(1)
	}
}
}}