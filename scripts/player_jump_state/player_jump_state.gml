
function player_jump_state(){

	player_get_input()
	player_calc_movement()
	
	if on_ground() {
		if mvsp > max_fall_spd {
			scale_x = fast_fall_scale_max
			scale_y = fast_fall_scale_min
		} else {
			scale_x = scale_max
			scale_y = scale_min
		}
		was_on_wall = false
		if jump_key_last < jump_grace_frames mvsp = jump_spd
		else if mhsp + ext_hsp != 0 state = states.WALK else state = states.IDLE
	}
	
	image_xscale = facing
	
	if on_wall() and not was_on_wall {
		was_on_wall = true
		mvsp = wall_hang_start_spd
	}
	
	if mvsp < 0 and !jump_held mvsp = max(mvsp, jump_spd/jump_dampner)
	
	dash_test()
	
	player_apply_movement()
	player_animation()	
	
}