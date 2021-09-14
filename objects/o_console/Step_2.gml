
mouse_on_console = false
clicking_on_console = false

run_in_console = false
run_in_embed   = false

gui_mouse_x = gui_mx
gui_mouse_y = gui_my

#region Get inputs for UI elements
var was_clicking = clicking_on_console
var front = -1
for(var i = 0; i <= ds_list_size(elements)-1; i++)
{
	elements[| i].get_input()
	if not was_clicking and clicking_on_console 
	{
		front = i
		was_clicking = true
	}
}
if front != -1
{
	var el = elements[| front]
	ds_list_delete(elements, front)
	ds_list_insert(elements, 0, el)
}

if not mouse_check_button(mb_left) element_dragging = noone
#endregion

#region Silly theming stuff
if rainbow rainbowify([
	"output", "ex_output", "plain", "body", "selection", "embed", 
	"embed_hover", dt_real, dt_string, dt_asset, dt_variable, dt_method, 
	dt_instance, dt_builtinvar, dt_tag, dt_unknown, dt_deprecated
])

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
#endregion

console_measurer_inputs()

event_commands_exec(event_commands.step_end)
step ++