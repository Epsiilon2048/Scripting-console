
function keyboard_check_multiple_pressed(){ //checks if all the given keys are down, and at least one is pressed
	
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
	
	
	
	
function x_to_gui(x){ //converts an x pos to a gui x pos
///grab the width and height of view
var cw = camera_get_view_width(view_camera)

///set some variables to hold the value and div that by width and height
var display_scalex = display_get_gui_width()/cw

///get camera coords
var cx = camera_get_view_x(view_camera)

///make the adjustment to gui
return (x-cx)*display_scalex;
}




function y_to_gui(y){ //converts a y pos to a gui y pos
///grab the width and height of view
var ch = camera_get_view_height(view_camera)

///set some variables to hold the value and div that by width and height
var display_scaley = display_get_gui_height()/ch

///get camera coords
var cy = camera_get_view_y(view_camera)

///make the adjustment to gui
return (y-cy)*display_scaley
}
	
	
	
	
function gui_mouse_between(x1, y1, x2, y2){ //checks if the mouse is between the given coords on the gui

return	(min(x1, x2) <= gui_mx and gui_mx <= max(x1, x2) and 
		 min(y1, y2) <= gui_my and gui_my <= max(y1, y2))
}