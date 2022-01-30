
function console_key_pressed(){ with o_console {

var is_weird = console_key == vk_tilde and (os_type == os_macosx or os_type == os_ios)
return keyboard_check_pressed(console_key) and (not is_weird or chr(console_key) != keyboard_lastchar)
}}