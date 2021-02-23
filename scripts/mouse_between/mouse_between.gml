// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function mouse_between(x1, y1, x2, y2){

return	(min(x1, x2) <= mouse_x and mouse_x <= max(x1, x2) and 
		min(y1, y2) <= mouse_y and mouse_y <= max(y1, y2))
}