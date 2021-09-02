
for(var i = ds_list_size(elements)-1; i >= 0; i--)
{
	elements[| i].draw()
}

event_commands_exec(event_commands.gui)