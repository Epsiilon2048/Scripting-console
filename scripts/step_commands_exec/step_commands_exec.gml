
function event_commands_exec(event){

if array_length(event) > 0
{
	draw_reset_properties()
	
	for(var i = 0; i <= array_length(event)-1; i++)
	{
		gmcl_exec(event[i])
	}
	
	draw_reset_properties()
}
}