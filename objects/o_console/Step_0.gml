
if not enabled or not initialized exit

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

event_commands_exec(event_commands.step)