// Script assets have changed for v2.3.0 see
// https] =//help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function initialize_console_macros(){

if ds_exists(console_macros, ds_type_map) ds_map_clear(console_macros)
else console_macros = ds_map_create()

console_macros[? "instance_destroy"] =  instance_destroy

console_macros[? "true" ] = true
console_macros[? "false"] =	false

console_macros[? "global"] = global
console_macros[? "noone" ] = noone
console_macros[? "all"   ] = all

#region Colors
console_macros[? "c_white" ] = c_white
console_macros[? "c_black" ] = c_black
console_macros[? "c_red"   ] = c_red
console_macros[? "c_blue"  ] = c_blue
console_macros[? "c_yellow"] = c_yellow
console_macros[? "c_green" ] = c_green
#endregion

#region Blendmodes
console_macros[? "bm_normal"  ] = bm_normal
console_macros[? "bm_add"     ] = bm_add
console_macros[? "bm_subtract"] = bm_subtract
console_macros[? "bm_max"     ] = bm_max
#endregion

#region Text alignments
console_macros[? "fa_top"   ] =	fa_top
console_macros[? "fa_bottom"] =	fa_bottom
console_macros[? "fa_middle"] =	fa_middle
console_macros[? "fa_left"  ] =	fa_left
console_macros[? "fa_right" ] =	fa_right
console_macros[? "fa_center"] =	fa_center
#endregion

#region Virtual keys
console_macros[? "vk_add"	     ] = vk_add
console_macros[? "vk_alt"	     ] = vk_alt
console_macros[? "vk_anykey"     ] = vk_anykey
console_macros[? "vk_backspace"  ] = vk_backspace
console_macros[? "vk_control"    ] = vk_control
console_macros[? "vk_decimal"    ] = vk_decimal
console_macros[? "vk_delete"     ] = vk_delete
console_macros[? "vk_divide"     ] = vk_divide
console_macros[? "vk_down"	     ] = vk_down
console_macros[? "vk_end"	     ] = vk_end
console_macros[? "vk_enter"	     ] = vk_enter
console_macros[? "vk_escape"     ] = vk_escape
console_macros[? "vk_f1"	     ] = vk_f1
console_macros[? "vk_f2"	     ] = vk_f2
console_macros[? "vk_f3"	     ] = vk_f3
console_macros[? "vk_f4"	     ] = vk_f4
console_macros[? "vk_f5"	     ] = vk_f5
console_macros[? "vk_f6"	     ] = vk_f6
console_macros[? "vk_f7"	     ] = vk_f7
console_macros[? "vk_f8"	     ] = vk_f8
console_macros[? "vk_f9"	     ] = vk_f9
console_macros[? "vk_f10"	     ] = vk_f10
console_macros[? "vk_f11"	     ] = vk_f11
console_macros[? "vk_f12"	     ] = vk_f12
console_macros[? "vk_home"	     ] = vk_home
console_macros[? "vk_insert"     ] = vk_insert
console_macros[? "vk_lalt"	     ] = vk_lalt
console_macros[? "vk_lcontrol"   ] = vk_lcontrol
console_macros[? "vk_left"	     ] = vk_left
console_macros[? "vk_lshift"     ] = vk_lshift
console_macros[? "vk_multiply"   ] = vk_multiply
console_macros[? "vk_nokey"      ] = vk_nokey
console_macros[? "vk_numpad0"    ] = vk_numpad0
console_macros[? "vk_numpad1"    ] = vk_numpad1
console_macros[? "vk_numpad2"    ] = vk_numpad2
console_macros[? "vk_numpad3"    ] = vk_numpad3
console_macros[? "vk_numpad4"    ] = vk_numpad4
console_macros[? "vk_numpad5"    ] = vk_numpad5
console_macros[? "vk_numpad6"    ] = vk_numpad6
console_macros[? "vk_numpad7"    ] = vk_numpad7
console_macros[? "vk_numpad8"    ] = vk_numpad8
console_macros[? "vk_numpad9"    ] = vk_numpad9
console_macros[? "vk_pagedown"   ] = vk_pagedown
console_macros[? "vk_pageup"     ] = vk_pageup
console_macros[? "vk_pause"      ] = vk_pause
console_macros[? "vk_printscreen"] = vk_printscreen
console_macros[? "vk_ralt"		 ] = vk_ralt
console_macros[? "vk_rcontrol"   ] = vk_rcontrol
console_macros[? "vk_return"	 ] = vk_return
console_macros[? "vk_right"		 ] = vk_right
console_macros[? "vk_rshift"	 ] = vk_rshift
console_macros[? "vk_shift"		 ] = vk_shift
console_macros[? "vk_space"		 ] = vk_space
console_macros[? "vk_subtract"	 ] = vk_subtract
console_macros[? "vk_tab"		 ] = vk_tab
console_macros[? "vk_up"		 ] = vk_up
#endregion
}