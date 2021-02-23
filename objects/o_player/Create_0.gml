
controller = 4

hsp = 0  //just the additive values of mhsp and ext_hsp; for display purposes only
vsp = 0

mhsp = 0  //hsp and vsp from movement - capped by max variables
mvsp = 0
mhsp_jump_mult = 1.25
fast_fall_mult = 1.3
max_mhsp = 3
max_jump_spd = -6
max_fall_spd = 7
max_fast_fall_spd = 13 //if the player holds down while falling
was_on_wall = false //if the player was hanging to a wall on descent
wall_hang_start_spd = 0 //the speed to set the mvsp to when starting to hang on a wall
wall_hang_spd = .1 //hanging onto a wall
max_wall_hang_spd = 1
walk_spd = .7
walk_air_spd = .7  //midair

backward_speed_boost = 0

ext_hsp = 0  //hsp and vsp applied by external forces - no caps
ext_vsp = 0

mhsp_decimal = 0
mvsp_decimal = 0
jump_spd = -7
jump_dampner = 5

mdrag = .12  //movement drag
ext_h_air_drag = .055  //external horizontal mid air drag
ext_hdrag = .18  //external horizontal on ground drag
ext_vdrag = .12  //external vertical drag

//stretching
scale_x = 1
scale_y = 1
scale_min = 0.6
scale_max = 1.4
scale_decay = .2
fast_fall_scale_min = 0.75
fast_fall_scale_max = 1.25
fast_fall_scale_decay = .2

//when vertical collision happens, the external horizontal collision is adjusted based on this 
//(and vice versa)
ext_col_clamp = 7
ext_col_dampner = 2

//facing direction
facing = 1

dash_test_spd = 23

left		= false
right		= false
down		= false
jump		= false
jump_held	= false

jump_key_last = 0 //how many frames since jump was last pressed (not held)
jump_grace_frames = 7

max_image_angle = -10
angle_wave = 0
angle_wave_spd = 1
angle_wave_div = 1

enum states {
	IDLE,
	WALK,
	JUMP,
}

state = states.IDLE

states_array[states.IDLE]	= player_idle_state
states_array[states.WALK]	= player_walk_state
states_array[states.JUMP]	= player_jump_state

states_string[states.IDLE]		= "idle"
states_string[states.WALK]		= "walk"
states_string[states.JUMP]		= "jump"