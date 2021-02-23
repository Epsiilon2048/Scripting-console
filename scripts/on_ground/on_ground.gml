// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function on_ground(){

var side = bbox_bottom
var t1 = tilemap_get_at_pixel(global.col, bbox_left, side + 1)
var t2 = tilemap_get_at_pixel(global.col, bbox_right - (bbox_right - bbox_left)/2, side+1)
var t3 = tilemap_get_at_pixel(global.col, bbox_right, side + 1)

var p1 = tilemap_get_at_pixel(global.col, bbox_left, bbox_bottom)
var p2 = tilemap_get_at_pixel(global.col, bbox_right - (bbox_right - bbox_left)/2, bbox_bottom)
var p3 = tilemap_get_at_pixel(global.col, bbox_right, bbox_bottom)

if	((t1 == SOLID or t1 == PLATFORM) and (p1 != SOLID and p1 != PLATFORM) or (t1 == SOLID and p1 == PLATFORM) or
	 (t2 == SOLID or t2 == PLATFORM) and (p2 != SOLID and p2 != PLATFORM) or (t2 == SOLID and p2 == PLATFORM) or
	 (t3 == SOLID or t3 == PLATFORM) and (p3 != SOLID and p3 != PLATFORM) or (t3 == SOLID and p3 == PLATFORM))
	return true else return false
}