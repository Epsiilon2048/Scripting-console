// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function dash_test(){

if keyboard_check_pressed(vk_shift) and not o_console.console_toggle {
	ext_hsp = clamp((mouse_x - x)/13, -dash_test_spd, dash_test_spd)
	ext_vsp = clamp((mouse_y - y)/9, -dash_test_spd, dash_test_spd)
	mhsp = 0
	mvsp = 0
}

}