
var sep = 88*5/global.win_sc

for(var i = 0; i <= array_length(buttons)-1; i++)
{
	draw_editor_button(buttons[i])
	/*if	(buttons[i].hovering > o_console.context_time or buttons[i].nothovering < o_console.context_time) and 
		not buttons[i].clicked
	{
		draw_context_strip(
			buttons[i].context_x, 
			buttons[i].context_y, 
			buttons[i].context, 
			buttons[i].hovering + (o_console.context_time*2 - buttons[i].nothovering)*sign(buttons[i].nothovering)
		)
	}*/
}