
function player_calc_movement(){
	
if state = states.JUMP	mhsp += (right - left) * walk_air_spd
else					mhsp += (right - left) * walk_spd

if on_wall()	mvsp += wall_hang_spd
else if down	mvsp += global.grav*fast_fall_mult
else			mvsp += global.grav
	
//drag
mhsp = lerp(mhsp, 0, mdrag)

if on_ground()	ext_hsp = lerp(ext_hsp, 0, ext_hdrag)
else			ext_hsp = lerp(ext_hsp, 0, ext_h_air_drag)

//backwards boost
if on_ground() and facing != image_xscale ext_hsp += backward_speed_boost*facing

ext_vsp = lerp(ext_vsp, 0, ext_vdrag)

//stop
if abs(mhsp) <= 0.1 mhsp = 0
if abs(mvsp) <= 0.1 mvsp = 0

if abs(ext_hsp) <= 0.1 ext_hsp = 0
if abs(ext_vsp) <= 0.1 ext_vsp = 0

//face correct way
if mhsp != 0 facing = sign(mhsp)

//limit speed
mhsp = min(abs(mhsp), max_mhsp) * facing
if on_wall()	mvsp = clamp(mvsp, max_jump_spd, max_wall_hang_spd)
else if down	mvsp = clamp(mvsp, max_jump_spd, max_fast_fall_spd) //not a smooth transition at the moment
else			mvsp = clamp(mvsp, max_jump_spd, max_fall_spd)

//stop stretch
if mvsp > max_fall_spd {
	scale_x = lerp(scale_x, fast_fall_scale_min, fast_fall_scale_decay)
	scale_y = lerp(scale_y, fast_fall_scale_max, fast_fall_scale_decay)
} else {
	scale_x = lerp(scale_x, 1, scale_decay)
	scale_y = lerp(scale_y, 1, scale_decay)
}
}