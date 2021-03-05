// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function draw_ctx_menu(ctx){ with CTX_MENU {

draw_set_font(font)
var cw = string_width(" ")
var ch = string_height(" ")

var left	= x
var right	= x + ctx.longest_item*cw + border_l + border_r
var top		= y
var bottom	= y + ctx.items_count*(ch + spacing) - spacing + ctx.sep_count*sep_spacing + border_h*2

draw_set_color(o_console.colors.body_real)
draw_rectangle(
	left,
	top,
	right,
	bottom,
	false
)

draw_set_color(o_console.colors.output)

var yy = top + border_h

for(var i = 0; i <= array_length(ctx.items)-1; i++)
{
	if is_struct(ctx.items[i])
	{
		draw_text(
			left + border_l,
			yy,//y + border_h + (ch + spacing)*i,
			ctx.items[i].str
		)
		
		yy += ch+spacing
	}
	else if ctx.items[i] == SEPARATOR
	{
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
}}