// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function window_reset_pos(){ with o_console {

Window.reset_pos()
Window.enabled = true
Window.show = true

return "Window position reset"
}}