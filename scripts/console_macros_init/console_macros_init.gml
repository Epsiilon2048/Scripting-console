
function initialize_console_macros(){

#region Shortcuts

console_macro_add("con",				dt_instance, o_console)

console_macro_add("var",				dt_method, create_variable)
			
//console_macro_add("@",					dt_method, dealwith_array)
//console_macro_add("$",					dt_method, dealwith_struct)
//console_macro_add("|",					dt_method, dealwith_ds_list)
//console_macro_add("?",					dt_method, dealwith_ds_map)
//console_macro_add("#",					dt_method, dealwith_ds_grid)

console_macro_add("O1",					dt_variable, "o_console.O1")
console_macro_add("O2",					dt_variable, "o_console.O2")
console_macro_add("O3",					dt_variable, "o_console.O3")
console_macro_add("O4",					dt_variable, "o_console.O4")
console_macro_add("O5",					dt_variable, "o_console.O5")

console_macro_add("mouse_x",			dt_variable, "global.mouse_x")
console_macro_add("mouse_y",			dt_variable, "global.mouse_y")
										
console_macro_add("fps",				dt_variable, "global.fps")
console_macro_add("fps_real",			dt_variable, "global.fps_real")
										
console_macro_add("gui_mx",				dt_variable, "o_console.gui_mouse_x")
console_macro_add("gui_my",				dt_variable, "o_console.gui_mouse_y")
#endregion
										
#region Console datatypes				
console_macro_add("dt_real",			dt_string, dt_real)
console_macro_add("dt_string",			dt_string, dt_string)
console_macro_add("dt_asset",			dt_string, dt_asset)
console_macro_add("dt_variable",		dt_string, dt_variable)
console_macro_add("dt_method",			dt_string, dt_method)
console_macro_add("dt_instance",		dt_string, dt_instance)
console_macro_add("dt_room",			dt_string, dt_room)
console_macro_add("dt_unknown",			dt_string, dt_unknown)
console_macro_add("dt_tag",				dt_string, dt_tag)
console_macro_add("dt_deprecated",		dt_string, dt_deprecated)
console_macro_add("dt_color",			dt_string, dt_color)
#endregion								

#region Builtin color schemes
console_macro_add("cs_drowned",			dt_string, cs_drowned)
console_macro_add("cs_greenbeans",		dt_string, cs_greenbeans)
console_macro_add("cs_helios",			dt_string, cs_helios)
console_macro_add("cs_humanrights",		dt_string, cs_humanrights)
console_macro_add("cs_rainbowsoup",		dt_string, cs_rainbowsoup)
console_macro_add("cs_royal",			dt_string, cs_royal)
#endregion

#region Value box types					
console_macro_add("vb_bool",			dt_string, vb_bool)
console_macro_add("vb_color",			dt_string, vb_color)
console_macro_add("vb_scrubber",		dt_string, vb_scrubber)
console_macro_add("vb_static",			dt_string, vb_static)
#endregion

#region Boolean
console_macro_add("true",				dt_real, true)
console_macro_add("false",				dt_real, false)
#endregion								
										
#region Instance constants				
console_macro_add("global",				dt_instance, global)
console_macro_add("noone",				dt_instance, noone)
console_macro_add("all",				dt_instance, all)
#endregion

#region Colors
console_macro_add("c_white",			dt_color, c_white)
console_macro_add("c_black",			dt_color, c_black)
console_macro_add("c_red",				dt_color, c_red)
console_macro_add("c_blue",				dt_color, c_blue)
console_macro_add("c_yellow",			dt_color, c_yellow)
console_macro_add("c_green",			dt_color, c_green)
#endregion

#region Blendmodes
console_macro_add("bm_add",				dt_real, bm_add)
console_macro_add("bm_dest_alpha",		dt_real, bm_dest_alpha)
console_macro_add("bm_dest_color",		dt_real, bm_dest_color)
console_macro_add("bm_inv_dest_alpha",	dt_real, bm_inv_dest_alpha)
console_macro_add("bm_inv_dest_color",	dt_real, bm_inv_dest_color)
console_macro_add("bm_inv_src_alpha",	dt_real, bm_inv_src_alpha)
console_macro_add("bm_inv_src_color",	dt_real, bm_inv_src_color)
console_macro_add("bm_max",				dt_real, bm_max)
console_macro_add("bm_normal",			dt_real, bm_normal)
console_macro_add("bm_one",				dt_real, bm_one)
console_macro_add("bm_src_alpha",		dt_real, bm_src_alpha)
console_macro_add("bm_src_alpha_sat",	dt_real, bm_src_alpha_sat)
console_macro_add("bm_src_color",		dt_real, bm_src_color)
console_macro_add("bm_subtract",		dt_real, bm_subtract)
console_macro_add("bm_zero",			dt_real, bm_zero)
#endregion

#region Text alignments
console_macro_add("fa_top",				dt_real, fa_top)
console_macro_add("fa_bottom",			dt_real, fa_bottom)
console_macro_add("fa_middle",			dt_real, fa_middle)
console_macro_add("fa_left",			dt_real, fa_left)
console_macro_add("fa_right",			dt_real, fa_right)
console_macro_add("fa_center",			dt_real, fa_center)
#endregion

#region Ds types
console_macro_add("ds_type_grid",		dt_real, ds_type_grid)
console_macro_add("ds_type_list",		dt_real, ds_type_list)
console_macro_add("ds_type_map",		dt_real, ds_type_map)
console_macro_add("ds_type_priority",	dt_real, ds_type_priority)
console_macro_add("ds_type_queue",		dt_real, ds_type_queue)
console_macro_add("ds_type_stack",		dt_real, ds_type_stack)
#endregion

#region Virtual keys
console_macro_add("vk_anykey",			dt_real, vk_anykey)
console_macro_add("vk_nokey",			dt_real, vk_nokey)
																					
console_macro_add("vk_left",			dt_real, vk_left)
console_macro_add("vk_up",				dt_real, vk_up)
console_macro_add("vk_down",			dt_real, vk_down)
console_macro_add("vk_right",			dt_real, vk_right)
										
console_macro_add("vk_space",			dt_real, vk_space)
console_macro_add("vk_backspace",		dt_real, vk_backspace)
console_macro_add("vk_enter",			dt_real, vk_enter)
console_macro_add("vk_escape",			dt_real, vk_escape)
console_macro_add("vk_tab",				dt_real, vk_tab)
										
console_macro_add("vk_shift",			dt_real, vk_shift)
console_macro_add("vk_control",			dt_real, vk_control)
console_macro_add("vk_alt",				dt_real, vk_alt)

console_macro_add("vk_tilde",			dt_real, vk_tilde)

console_macro_add("vk_add",				dt_real, vk_add)
console_macro_add("vk_decimal",			dt_real, vk_decimal)
console_macro_add("vk_delete",			dt_real, vk_delete)
console_macro_add("vk_divide",			dt_real, vk_divide)
console_macro_add("vk_end",				dt_real, vk_end)
console_macro_add("vk_f1",				dt_real, vk_f1)
console_macro_add("vk_f2",				dt_real, vk_f2)
console_macro_add("vk_f3",				dt_real, vk_f3)
console_macro_add("vk_f4",				dt_real, vk_f4)
console_macro_add("vk_f5",				dt_real, vk_f5)
console_macro_add("vk_f6",				dt_real, vk_f6)
console_macro_add("vk_f7",				dt_real, vk_f7)
console_macro_add("vk_f8",				dt_real, vk_f8)
console_macro_add("vk_f9",				dt_real, vk_f9)
console_macro_add("vk_f10",				dt_real, vk_f10)
console_macro_add("vk_f11",				dt_real, vk_f11)
console_macro_add("vk_f12",				dt_real, vk_f12)
console_macro_add("vk_home",			dt_real, vk_home)
console_macro_add("vk_insert",			dt_real, vk_insert)
console_macro_add("vk_lalt",			dt_real, vk_lalt)
console_macro_add("vk_lcontrol",		dt_real, vk_lcontrol)
console_macro_add("vk_lshift",			dt_real, vk_lshift)
console_macro_add("vk_multiply",		dt_real, vk_multiply)
console_macro_add("vk_numpad0",			dt_real, vk_numpad0)
console_macro_add("vk_numpad1",			dt_real, vk_numpad1)
console_macro_add("vk_numpad2",			dt_real, vk_numpad2)
console_macro_add("vk_numpad3",			dt_real, vk_numpad3)
console_macro_add("vk_numpad4",			dt_real, vk_numpad4)
console_macro_add("vk_numpad5",			dt_real, vk_numpad5)
console_macro_add("vk_numpad6",			dt_real, vk_numpad6)
console_macro_add("vk_numpad7",			dt_real, vk_numpad7)
console_macro_add("vk_numpad8",			dt_real, vk_numpad8)
console_macro_add("vk_numpad9",			dt_real, vk_numpad9)
console_macro_add("vk_pagedown",		dt_real, vk_pagedown)
console_macro_add("vk_pageup",			dt_real, vk_pageup)
console_macro_add("vk_pause",			dt_real, vk_pause)
console_macro_add("vk_printscreen",		dt_real, vk_printscreen)
console_macro_add("vk_ralt",			dt_real, vk_ralt)
console_macro_add("vk_rcontrol",		dt_real, vk_rcontrol)
console_macro_add("vk_return",			dt_real, vk_return)
console_macro_add("vk_rshift",			dt_real, vk_rshift)
console_macro_add("vk_subtract",		dt_real, vk_subtract)
#endregion

if include_builtin_functions console_macro_add_builtin()
}