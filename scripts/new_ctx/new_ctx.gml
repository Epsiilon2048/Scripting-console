
function new_draw_ctx_menu(){ with o_console.CTX_MENU {

if not is_array(items) return undefined
if is_undefined(longest_item)
{
	longest_item = 0
	var width = 0
	var height = border_h
	
	for(var i = 0; i <= array_length(items)-1; i++)
	{
		if items[i] == ctx_separator height += sep_width + sep_dist*2 - text_dist
		else if is_struct(items[i]) height += ch + text_dist
		longest_item = max(longest_item, string_length(variable_struct_exists_get(items[i], "str", "")))
	}
	
	height = longest_item*cw
	
	left = x
	top = y
	right = left + width
	bottom = top + height
	
	/*
	if gui_mx+width > gui_width
	if gui_my+height > gui_height
	*/
}



draw_set_color(o_console.colors.body_real)
draw_rectangle(left, top, right, bottom, false)

var text_x
var text_y

for(var i = 0; i <= array_length(items)-1; i++)
{
	
}


var old_color = draw_get_color()
var old_font = draw_get_font()
var old_halign = draw_get_halign()
var old_valign = draw_get_valign()

draw_set_font(o_console.font)

var cw = string_height(" ")
var ch = string_width(" ")

var asp = ch/char_height



for(var i = 0; i <= array_length(items)-1; i++)
{
	
}


draw_set_color(old_color)
draw_set_font(old_font)
draw_set_halign(old_halign)
draw_set_valign(old_valign)
}}