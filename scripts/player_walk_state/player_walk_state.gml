// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function player_walk_state(){

	player_get_input()
	player_calc_movement()
	
	if mhsp + ext_hsp == 0 state = states.IDLE
	
	if jump {
		state = states.JUMP
		mvsp = jump_spd
		scale_x = scale_min
		scale_y = scale_max
		mvsp_decimal = 0
	}
	
	image_xscale = facing
	
	dash_test()
	
	if not on_ground() state = states.JUMP  // Currently allows for 1 frame of coyote time; expand later
	
	player_apply_movement()
	player_animation()
	
}