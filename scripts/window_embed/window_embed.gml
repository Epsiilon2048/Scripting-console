// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function window_embed(text){ with o_console {

Window.set(text)
Window.enabled = true
Window.show = true

window_reset_pos()

return "Set window text"
}}