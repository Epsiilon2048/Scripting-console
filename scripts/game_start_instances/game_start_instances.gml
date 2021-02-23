// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function game_start_instances(){

var start_instances = [
	o_cursor,
	o_console,
	o_gui,
]

for(var i = 0; i <= array_length(start_instances)-1; i++)
{
	instance_create_layer(x, y, "Game_objects", start_instances[i])
}
}