
function generate_satval_square(){

var c = surface_create(1, 1)
surface_set_target(c)

draw_point(1, 1)

surface_reset_target()
o_console.COLOR_PICKER.svsquare = sprite_create_from_surface(c, 0, 0, surface_get_width(c), surface_get_height(c), false, false, 0, 0)
}




function generate_hue_strip(){

var old_color = draw_get_color()

var c = surface_create(1, 256)
surface_set_target(c)

for(var yy = 0; yy <= 255; yy++)
{
	var _col = make_color_hsv(yy, 255, 255)
	draw_set_color(_col)
	draw_point(0, yy)
}
draw_set_color(old_color)
surface_reset_target()
o_console.COLOR_PICKER.hstrip = sprite_create_from_surface(c, 0, 0, surface_get_width(c), surface_get_height(c), false, false, 0, 0)
}