
function generate_satval_square(){

draw_reset_properties()

var c = surface_create(256, 256)
surface_set_target(c)

for(var yy = 0; yy <= 255; yy++)
for(var xx = 0; xx <= 255; xx++)
{
	var _col = make_color_hsv(
		0,
		xx,
		255-yy
	)

	draw_set_color(_col)
	draw_point(xx, yy)
}

var _c = sprite_create_from_surface(c, 0, 0, 256, 256, false, false, 0, 0)

surface_reset_target()
surface_free(c)

return _c
}




function generate_hue_strip(){

draw_reset_properties()

var c = surface_create(1, 256)
surface_set_target(c)

for(var yy = 0; yy <= 255; yy++)
{
	var _col = make_color_hsv(yy, 255, 255)
	draw_set_color(_col)
	draw_point(0, yy)
}
draw_set_color(c_white)

var _c = sprite_create_from_surface(c, 0, 0, 1, 256, false, false, 0, 0)

surface_reset_target()
surface_free(c)

return _c
}