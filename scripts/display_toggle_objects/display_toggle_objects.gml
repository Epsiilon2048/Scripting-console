// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function display_toggle_objects(toggle){ with o_console {

if is_undefined(toggle) = not display_show_objects 

display_show_objects = toggle

return "Toggled display objects"
}}