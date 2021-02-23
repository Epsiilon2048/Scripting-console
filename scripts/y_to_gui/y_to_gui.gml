
function y_to_gui(y){

///grab the width and height of view
var ch = camera_get_view_height(view_camera)

///set some variables to hold the value and div that by width and height
display_scaley = display_get_gui_height()/ch

///get camera coords
var cy = camera_get_view_y(view_camera)

///make the adjustment to gui
return (y-cy)*display_scaley

}