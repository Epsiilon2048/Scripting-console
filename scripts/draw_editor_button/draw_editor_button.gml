// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function draw_editor_button(button){

//dont read this. please. it's going to give you brain cancer.

var xx = button.x*global.win_sc
var yy = button.y*global.win_sc

var w = sprite_get_width(s_editor_button)*5
var mouse = gui_mouse_between(xx, yy, xx+w, yy+w)

if mouse and mouse_check_button(mb_left) 
{
	clicked = true
}
else if not mouse 
{
	clicked = false
}

if mouse and button.clicking and mouse_check_button_released(mb_left)
{
	mode = button.id
}

if mouse and mouse_check_button_pressed(mb_left) 
{
	button.clicking = true
}
else if mouse_check_button_released(mb_left) 
{
	button.clicking = false
}

if mode == button.id 
{
	draw_sprite_ext(s_editor_button_outline, 0, xx, yy, 5, 5, 0, o_console.colors.output, 1)
}

var down = (button.clicking or mode == button.id)

gpu_set_blendmode(o_console.colors.body_bm)
draw_sprite_ext(s_editor_button, 0, xx, yy, 5, 5, 0, o_console.colors.body, 1)
gpu_set_blendmode(bm_normal)

if not down 
{
	draw_sprite_ext(button.icon, 0, xx, yy, 5, 5, 0, -o_console.colors.body, 1)
}

draw_sprite_ext(button.icon, 0, xx, yy-global.win_sc*(not down), 5, 5, 0, o_console.colors.output, 1)

var w = sprite_get_width(s_editor_button)*5
}