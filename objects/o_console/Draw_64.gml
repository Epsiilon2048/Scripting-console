
var old_color = draw_get_color()
var old_alpha = draw_get_alpha()
var old_font = draw_get_font()
var old_halign = draw_get_halign()
var old_valign = draw_get_valign()
var old_blendmode = gpu_get_blendmode()
var old_shader = shader_current()


for(var i = ds_list_size(elements)-1; i >= 0; i--)
{
	var el = elements[| i]
	if element_dragging != el el.draw()
}

if element_dragging != noone element_dragging.draw()

COLOR_PICKER.draw()
draw_autofill_list()
draw_ctx_menu()
draw_console_measurer()

event_commands_exec(event_commands.gui)


draw_set_color(old_color)
draw_set_alpha(old_alpha)
draw_set_font(old_font)
draw_set_halign(old_halign)
draw_set_valign(old_valign)
gpu_set_blendmode(old_blendmode)

if old_shader == -1 and shader_current() != -1 shader_reset()
else if old_shader != -1 shader_set(old_shader)