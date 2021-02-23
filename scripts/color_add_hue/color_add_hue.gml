// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function color_add_hue(col, add){

return make_color_hsv(
	color_get_hue(col)+add, 
	color_get_saturation(col),
	color_get_value(col)
)
}