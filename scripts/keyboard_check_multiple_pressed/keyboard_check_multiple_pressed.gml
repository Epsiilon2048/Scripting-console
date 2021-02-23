// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function keyboard_check_multiple_pressed(){
	
var pressed = false
	
for(var i = 0; i <= argument_count-1; i++)
{
	if keyboard_check(argument[i])
	{
		if keyboard_check_pressed(argument[i])
		{
			pressed = true
		}
	}
	else return false
}
	
return pressed
}