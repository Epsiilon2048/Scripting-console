
//lol this is a pretty shit way of doing this but its good for now

if mouse_check_button_pressed(mb_middle)
{
	if		object_following == o_cursor object_following = noone
	else if object_following == noone object_following = o_cursor
}

spd = 0

if follow_points and point != noone
{
	var targetx = point.x
	var targety = point.y
		
	direction = point_direction(x, y, targetx, targety)
	spd = point_distance(x, y, targetx, targety)*point_spd_mult
	
	x += lengthdir_x(spd, direction)
	y += lengthdir_y(spd, direction)
}
else if instance_exists(object_following)
{
	var targetx = object_following.x
	var targety = object_following.y+offset_y
	var dist = point_distance(x, y, targetx, targety)*(CAM_W/camera_get_view_width(view_camera[0]))
		
	if dist > border
	{
		direction = point_direction(x, y, targetx, targety)
		spd = (point_distance(x, y, targetx, targety)-border)*((dist-border)*spd_mult)
	
		x += lengthdir_x(spd, direction)
		y += lengthdir_y(spd, direction)
	}
}