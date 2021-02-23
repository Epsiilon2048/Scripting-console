
function on_wall(){

if !on_ground() and sign(mvsp) == 1 and ((left and facing == -1) or (right and facing == 1))
{
var side
if facing == -1 side = bbox_left-1 else side = bbox_right+1

//var t1 = tilemap_get_at_pixel(global.col, side, bbox_top)
var t2 = tilemap_get_at_pixel(global.col, side, bbox_bottom - (bbox_bottom - bbox_top)/2)
var t3 = tilemap_get_at_pixel(global.col, side, bbox_bottom)
	
if (t2 == SOLID or t3 = SOLID) return true else return false

} else return false
}