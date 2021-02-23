
function x_to_gui(x){

///grab the width and height of view
var cw = camera_get_view_width(view_camera)

///set some variables to hold the value and div that by width and height
display_scalex = display_get_gui_width()/cw

///get camera coords
var cx = camera_get_view_x(view_camera)

///make the adjustment to gui
return (x-cx)*display_scalex;

}