
var xx = snap(mouse_x)
var yy = snap(mouse_y)

if not surface_exists(grid_surface)
{
	grid_surface = surface_create(1, 1)
}

if	surface_get_width(grid_surface)  != room_width *global.win_sc or
	surface_get_height(grid_surface) != room_height*global.win_sc
{
	output_set("Reset grid surface")
	surface_resize(grid_surface, room_width*global.win_sc, room_height*global.win_sc)
	surface_set_target(grid_surface)
	draw_clear_alpha(c_black, 0);
	for(var i = 0; i <= max(room_width, room_height)/tile_size; i++)
	{
		draw_line(0, i*tile_size, room_width,  i*tile_size)
		draw_line(i*tile_size, 0, i*tile_size, room_height)
	}
	surface_reset_target()
}

if instance_exists(o_level_editor)
{
	draw_tilemap(global.col, 0, 0)
	
	if o_level_editor.grid 
	{
		draw_set_color(c_white)
		draw_set_alpha(o_level_editor.grid_alpha)
		draw_surface(grid_surface, 0, 0)
		draw_set_color(c_white)
	}
}
else instance_destroy()