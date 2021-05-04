
/*
str
scr
arg
args
func
checkbox
shortcut
variable
*/

function Ctx_menu() constructor{

scope = noone

set = function(_items){
	
	items = _items
	if not is_array(items) items = [items]
	
	item_count = 0
	sep_count = 0
	
	longest_item = 0
	longest_item_count = 0
	
	for(var i = 0; i <= array_length(items)-1; i++)
	{
		if is_struct(items[i])
		{
			item_count ++
			if string_length(items[i].str) > longest_item 
			{
				longest_item = string_length(items[i].str)
				longest_item_count = 1
			}
			else if string_length(items[i].str) == longest_item
			{
				longest_item_count ++
			}
		}
		else 
		{
			if items[i] == ctx_separator sep_count ++
		}
	}
}

set_item = function(index, item){
	
	if index == item_count+1
	{
		item_count ++
		array_push(items, {str: ""})
	}
	
	var oldlen = string_length(items[index].str)
	var newlen = string_length(item.str)
	
	items[index] = item
	
	if oldlen == longest_item
	{
		if newlen < longest_item
		{
			longest_item_count --
			
			if longest_item_count <= 0
			{
				set(items) //lmao this is lazy
			}
		}
		else if newlen > longest_item
		{
			longest_item = newlen
			longest_item_count = 1
		}
	}
	else if newlen == longest_item
	{
		longest_item_count ++
	}
}
}




function ctx_menu_inputs(){ with o_console.CTX_MENU { if not is_undefined(ctx) {

if not enabled
{
	enabled = true
		
	x = device_mouse_x_to_gui(0)+1
	y = device_mouse_y_to_gui(0)+1
}

if enabled
{
	var mouse_on = gui_mouse_between(left, top, right, bottom)
	
	if mouse_check_button_pressed(mb_any)
	{
		if mouse_on clicking_on = true
	}
	
	else if mouse_check_button(mb_any)
	{	
		if not mouse_on and not clicking_on enabled = false
	}
	
	else clicking_on = false
}

if enabled
{
	var cw = string_width(" ")
	var ch = string_height(" ")
	ch += (ch + spacing) mod 2

	left	= x
	right	= x + ctx.longest_item*cw + border_l + border_r
	top		= y
	bottom	= y + ctx.item_count*(ch + spacing) + ctx.sep_count*sep_spacing

	inputs = true

	mouse_item = -1

	var yy = top

	if mouse_on for(var i = 0; i <= array_length(ctx.items)-1; i++)
	{
		if is_struct(ctx.items[i])
		{
			if gui_mouse_between(left, yy, right, yy + ch + spacing)
			{	
				if mouse_check_button_released(mb_any)
				{	
					var item = ctx.items[i]
					
					var _scr		= variable_struct_exists_get(item, "scr",		noscript)
					var _variable	= variable_struct_exists_get(item, "variable",	"")
					var _arg		= variable_struct_exists_get(item, "arg",		undefined)
					var _args		= variable_struct_exists_get(item, "args",		[])
					var _func		= variable_struct_exists_get(item, "func",		noscript)
					var _checkbox	= variable_struct_exists_get(item, "checkbox",	"")
					var _output		= variable_struct_exists_get(item, "output", false)
					
					var _o = []
					
					var _scope = ctx.scope
					var _use_scope = is_struct(_scope) or (is_numeric(_scope) and instance_exists(_scope))
					
					if is_struct(_scope) and not is_undefined(_scope[$ _variable]) 
					{
						_scope[$ _variable] = _arg
					}
					else if _use_scope
					{
						variable_instance_set(_scope, _variable, _arg)
					}
					else if is_string(_variable)
					{
						variable_string_set(_variable, _arg)
					}
					
					if _scr != noscript
					{
						if array_length(_args) > 0
						{
							if _use_scope	with _scope array_push(_o, script_execute_ext(_scr, _args))
							else			array_push(_o, script_execute_ext(_scr, _args))
						}
						else
						{
							if _use_scope	with _scope array_push(_o, _scr(_arg))
							else			array_push(_o, _scr(_arg))
						}
					}
					
					if _func != noscript
					{
						if _use_scope	with _scope array_push(_o, _func())
						else			array_push(_o, _func())
					}
					
					if _checkbox != "" and variable_string_exists(_checkbox)
					{
						variable_string_set(_checkbox, not variable_string_get(_checkbox))
					}
					
					if _output output_set_lines(_o)
					
					enabled = variable_struct_exists_get(item, "stay", variable_struct_exists(item, "checkbox"))
				}
				
				mouse_item = i
				break
			}
		
			yy += ch + spacing
		}
		else if ctx.items[i] == ctx_separator
		{
			yy += sep_spacing
		}
	}
}

if not enabled ctx = undefined
}}}




function draw_ctx_menu(){ with o_console.CTX_MENU { if enabled and not is_undefined(ctx) {

draw_set_font(font)
draw_set_halign(fa_left)
draw_set_valign(fa_middle)
var cw = string_width(" ")
var ch = string_height(" ")

ch += (ch + spacing) mod 2

if not inputs
{
	left	= x
	right	= x + ctx.longest_item*cw + border_l + border_r
	top		= y
	bottom	= y + ctx.item_count*(ch + spacing) + ctx.sep_count*sep_spacing
}

inputs = false

draw_set_color(o_console.colors.body_real)
draw_roundrect_ext(
	left,
	top,
	right,
	bottom,
	roundrect_radius,
	roundrect_radius,
	false
)

draw_set_color(o_console.colors.output)

var yy = top

for(var i = 0; i <= array_length(ctx.items)-1; i++)
{	
	if is_struct(ctx.items[i])
	{
		draw_set_color(o_console.colors.output)
		
		if mouse_item == i
		{
			var _top	= yy
			var _bottom = yy + ch + spacing
			
			draw_rectangle(left+1, _top+1, right, _bottom, false)
			draw_set_color(o_console.colors.body_real)
		}
		
		yy += (ch + spacing)/2
		
		draw_text(
			left + border_l,
			yy,
			ctx.items[i].str
		)
		
		var _checkbox = variable_struct_exists_get(ctx.items[i], "checkbox", "")
		
		if _checkbox != ""
		{
			var _var = variable_string_get(_checkbox)
			
			if is_numeric(_var)
			{
				draw_checkbox(left, yy-floor(o_console.CHECKBOX.width/2), _var, mouse_item == i)
			}
			else
			{
				
			}
		}
		
		yy += (ch + spacing)/2
	}
	else if ctx.items[i] == ctx_separator
	{
		draw_set_color(o_console.colors.body_accent)
		
		yy += sep_spacing/2
		draw_line(
			left,
			yy,
			right,
			yy,
		)
		yy += sep_spacing/2
	}
}

draw_reset_properties()
}}}




function draw_ctx_strip(x, y, string){ with o_console.CTX_STRIP {

if is_string(string) and string != ""
{
draw_set_font(font)
draw_set_halign(fa_left)
draw_set_valign(fa_top)

var w = string_width (string)
var h = string_height(string)

x += dist*2
y += dist

var x1 = x - border*2	 
var y1 = y - border	 
var x2 = x+w+border*2
var y2 = y+h+border	 

if x2 > display_get_gui_width()-w
{
	x  = x  - w - dist*4
	x1 = x1 - w - dist*4
	x2 = x2 - w - dist*4
}
if y2 > display_get_gui_height()-h
{
	y  = y  - h - dist*2
	y1 = y1 - h - dist*2
	y2 = y2 - h - dist*2
}

draw_set_color(o_console.colors.body_real)

draw_rectangle(x1, y1, x2, y2, false)

draw_set_color(o_console.colors.output)
draw_text(x, y+1, string)

draw_line_width(x1, y2+line_width/2, x1, y1-1, line_width)
draw_line_width(x1, y2, x2, y2, line_width)

draw_reset_properties()
}
}}