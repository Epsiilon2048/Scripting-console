// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function gui_mouse_between(x1, y1, x2, y2){

var mx = device_mouse_x_to_gui(0)
var my = device_mouse_y_to_gui(0)

return	(min(x1, x2) <= mx and mx <= max(x1, x2) and 
		min(y1, y2) <= my and my <= max(y1, y2))
}