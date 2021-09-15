
function color_picker_inputs(picker){ with picker {

var old_font = draw_get_font()

draw_set_font(o_console.font)

var co = o_console.COLOR_PICKER
var ch = string_height(" ")
var asp = (ch/co.char_height)*size
var _dist = round(co.dist*asp)
var _sep = round(co.sep*asp)
var _outline = round(co.outline*asp)
var _svsquare_length = round(co.svsquare_length*asp)
var _hstrip_width = round(co.hstrip_width*asp)
var _colorbar_height = round(co.colorbar_height*asp)

left = x
top = y
right = left+_dist*2+_outline*4+_svsquare_length+_sep+_hstrip_width
bottom = top+_dist*2+_outline*4+_svsquare_length+_sep+_colorbar_height

in_left = left+_dist
in_right = right-dist
in_top = top+dist
in_bottom = bottom-dist

svsquare_right = in_left+_svsquare_length
svsquare_bottom = in_top+_svsquare_length
hstrip_left = in_right-_hstrip_width
colorbar_top = in_bottom-_colorbar_height

if not mouse_on_console and not clicking_on_console
{
	mouse_on = gui_mouse_between(left, top, right, bottom)
	mouse_on_svsquare = mouse_on and gui_mouse_between(in_left, in_top, svsquare_right, svsquare_bottom)
	mouse_on_hstrip = mouse_on and gui_mouse_between(hstrip_left, in_top, in_right, svsquare_bottom)
	mouse_on_colorbar = mouse_on and gui_mouse_between(in_left, colorbar_top, in_right, in_bottom)
}
else
{
	mouse_on = false
	mouse_on_svsquare = false
	mouse_on_hstrip = false
	mouse_on_colorbar = false
}

var _hsv = hsv_255 ? 255 : 100

dropper_x = (sat/_hsv)*_svsquare_length
dropper_y = (val/_hsv)*_svsquare_length

draw_set_font(old_font)
}}



function draw_color_picker(picker){ with picker {

var old_color = draw_get_color()
var old_font = draw_get_font()

draw_set_font(o_console.font)

var co = o_console.COLOR_PICKER
var ch = string_height(" ")
var asp = ch/co.char_height
var _outline = round(co.outline*asp)
var _svsquare_dist = round(co.svsquare_dist*asp)

if not docked draw_console_body(left, top, right, bottom)
draw_set_color(o_console.colors.body_accent)
draw_hollowrect(left, top, right, bottom, 1)

draw_sprite_stretched(co.svsquare, 0, in_left, in_top, svsquare_right, svsquare_bottom)
draw_sprite_stretched(co.hstrip, 0, hstrip_left, in_top, in_right, svsquare_bottom)

draw_set_color(color)
draw_rectangle(in_left, colorbar_top, in_right, in_bottom)

draw_set_font(old_color)
draw_set_font(old_font)
}}