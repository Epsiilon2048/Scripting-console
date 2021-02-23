
angle_wave += angle_wave_spd

draw_sprite_ext(
	sprite_index, 
	sprite_index, 
	x, 
	y, 
	image_xscale*scale_x, 
	image_yscale*scale_y, 
	image_angle+6*facing+lerp(0, max_image_angle+sin(angle_wave)/angle_wave_div, mhsp/max_mhsp), 
	c_white, 
	1
)