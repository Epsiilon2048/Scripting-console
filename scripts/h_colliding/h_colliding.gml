// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function h_colliding(side, divisions){
	
var point

for(var i = 0; i <= divisions+1; i++)
{
	point = tilemap_get_at_pixel(
		global.col, 
		side + hsp, 
		bbox_bottom - (bbox_bottom - bbox_top)/(divisions+1)*i
	)
	
	if point != VOID and point != PLATFORM
	{
		return true
	}
}
}