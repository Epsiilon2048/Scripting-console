
function generate_satval_square(){

draw_reset_properties()

var c = surface_create(1, 1)
surface_set_target(c)

draw_point(1, 1)

surface_reset_target()
COLOR_PICKER.svsquare = c
}




function generate_hue_strip(){

var old_color = draw_get_color()

draw_reset_properties()

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
COLOR_PICKER.hstrip = c
}