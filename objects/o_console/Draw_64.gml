
for(var i = ds_list_size(elements)-1; i >= 0; i--)
{
	var el = elements[| i]
	if element_dragging != el el.draw()
}

if element_dragging != noone element_dragging.draw()

COLOR_PICKER.draw()
draw_autofill_list()
draw_console_measurer()

event_commands_exec(event_commands.gui)