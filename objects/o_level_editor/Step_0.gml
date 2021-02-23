
if editing
{
if tile_placing != VOID
{
	if mouse_check_button(mb_left)  tilemap_set_at_pixel(global.col, tile_placing, mouse_x, mouse_y)
	if mouse_check_button(mb_right) tilemap_set_at_pixel(global.col, VOID,  mouse_x, mouse_y)
}
}