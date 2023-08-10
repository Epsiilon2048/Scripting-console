
if not enabled or not can_run exit

if auto_scale and prev_gui_size != (gui_width*gui_height)
{
	scale()
}

if bird_mode and colors.sprite != bird_mode_
{
	colors.sprite = bird_mode_
	colors.outline_layers += 8
}
else if not bird_mode and colors.sprite == bird_mode_
{
	colors.sprite = -1
	colors.outline_layers -= 8
}