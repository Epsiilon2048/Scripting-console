// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function display_clear(){
	
ds_list_clear(display_list)
display_reset_pos()
display_toggle = false
return "Cleared display"
}