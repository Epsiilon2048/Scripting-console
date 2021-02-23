
function player_apply_movement(){

mhsp += mhsp_decimal
mvsp += mvsp_decimal
	
mhsp_decimal = mhsp - (floor(abs(mhsp)) * sign(mhsp))
mhsp -= mhsp_decimal
mvsp_decimal = mvsp - (floor(abs(mvsp)) * sign(mvsp))
mvsp -= mvsp_decimal

if state = states.JUMP {
	hsp = floor(abs(mhsp*mhsp_jump_mult + ext_hsp)) * sign(mhsp*mhsp_jump_mult + ext_hsp)
} else {
	hsp = floor(abs(mhsp + ext_hsp)) * sign(mhsp + ext_hsp)
}

var side
if hsp > 0 side = bbox_right else side = bbox_left

/*var t1 = tilemap_get_at_pixel(global.col, side + hsp, bbox_top)
var t2 = tilemap_get_at_pixel(global.col, side + hsp, bbox_bottom -  (bbox_bottom - bbox_top)/3)
var t3 = tilemap_get_at_pixel(global.col, side + hsp, bbox_bottom - ((bbox_bottom - bbox_top)/3)*2)
var t4 = tilemap_get_at_pixel(global.col, side + hsp, bbox_bottom)
	
if	((t1 != VOID) and (t1 != PLATFORM)) or 
	((t2 != VOID) and (t2 != PLATFORM)) or
	((t3 != VOID) and (t3 != PLATFORM)) or
	((t4 != VOID) and (t4 != PLATFORM)) {
*/

if h_colliding(side, 4)
{
	if (hsp > 0) 
	{
		x = x - (x mod tile_size) + tile_size - 1 - (side - x)
	}
	else 
	{
		x = x - (x mod tile_size) - (side - x)
	}
	hsp = 0
	mhsp = 0
	ext_hsp = 0
	ext_vsp = clamp(ext_vsp/ext_col_dampner, -ext_col_clamp, ext_col_clamp)
	
}
x += hsp


vsp = floor(abs(mvsp + ext_vsp)) * sign(mvsp + ext_vsp)

var side
if vsp > 0 side = bbox_bottom else side = bbox_top

var t1 = tilemap_get_at_pixel(global.col, bbox_left, side + vsp)
var t2 = tilemap_get_at_pixel(global.col, bbox_right - (bbox_right - bbox_left)/2, side+vsp)
var t3 = tilemap_get_at_pixel(global.col, bbox_right, side + vsp)

//platform check
var p1 = tilemap_get_at_pixel(global.col, bbox_left, bbox_bottom)
var p2 = tilemap_get_at_pixel(global.col, bbox_right - (bbox_right - bbox_left)/2, bbox_bottom)
var p3 = tilemap_get_at_pixel(global.col, bbox_right, bbox_bottom)
	
if	(t1 != VOID and (((vsp > 0 or t1 != PLATFORM)) and p1 != PLATFORM) or (t1 == SOLID and p1 == PLATFORM)) or
	(t2 != VOID and (((vsp > 0 or t2 != PLATFORM)) and p2 != PLATFORM) or (t2 == SOLID and p2 == PLATFORM)) or
	(t3 != VOID and (((vsp > 0 or t3 != PLATFORM)) and p3 != PLATFORM) or (t3 == SOLID and p3 == PLATFORM)) {
	
	if (vsp > 0) y = y - (y mod tile_size) + tile_size - 1 - (side - y)
	else y = y - (y mod tile_size) - (side - y) - tile_size
	vsp = 0
	mvsp = 0
	ext_vsp = 0
	ext_hsp = clamp(ext_hsp, -ext_col_clamp, ext_col_clamp)
}
y += vsp

/*if col {
	ext_hsp = clamp(ext_hsp, -ext_col_clamp, ext_col_clamp)
	ext_vsp = clamp(ext_vsp, -ext_col_clamp, ext_col_clamp)
}*/
}