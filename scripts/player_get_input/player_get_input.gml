
function player_get_input(){
if o_console.console_toggle == true
{
	left = false
	right = false
	down = false
	jump = false
	jump_held = false
}
else
{
left		= keyboard_check(ord("A"))			or gamepad_button_check(controller, gp_padl)
right		= keyboard_check(ord("D"))			or gamepad_button_check(controller, gp_padr)
down		= keyboard_check(ord("S"))			or gamepad_button_check(controller, gp_padd)
jump		= keyboard_check_pressed(vk_space) or mouse_wheel_down() or mouse_wheel_up()	or gamepad_button_check_pressed(controller, gp_face1)
jump_held	= keyboard_check(vk_space)			or gamepad_button_check(controller, gp_face1)
}

if jump jump_key_last = 0
else jump_key_last ++
}