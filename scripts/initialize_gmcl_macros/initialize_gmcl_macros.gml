
#macro vk_rcommand 91
#macro vk_lcommand 92
global.super_key = (os_type == os_macosx or os_type == os_ios) ? vk_lcommand : vk_control
global.tilde_key = (os_type == os_macosx or os_type == os_ios) ? 50 : 192
#macro vk_super global.super_key
#macro vk_tilde global.tilde_key



function index_virtualkeys(){

static am = function(name, type, value){ console_macro_add_ext(name, type, value, false) }

am("vk_add",			dt_real, vk_add)
am("vk_decimal",		dt_real, vk_decimal)
am("vk_delete",			dt_real, vk_delete)
am("vk_divide",			dt_real, vk_divide)
am("vk_end",			dt_real, vk_end)
am("vk_f1",				dt_real, vk_f1)
am("vk_f2",				dt_real, vk_f2)
am("vk_f3",				dt_real, vk_f3)
am("vk_f4",				dt_real, vk_f4)
am("vk_f5",				dt_real, vk_f5)
am("vk_f6",				dt_real, vk_f6)
am("vk_f7",				dt_real, vk_f7)
am("vk_f8",				dt_real, vk_f8)
am("vk_f9",				dt_real, vk_f9)
am("vk_f10",			dt_real, vk_f10)
am("vk_f11",			dt_real, vk_f11)
am("vk_f12",			dt_real, vk_f12)
am("vk_home",			dt_real, vk_home)
am("vk_insert",			dt_real, vk_insert)
am("vk_lalt",			dt_real, vk_lalt)
am("vk_lcontrol",		dt_real, vk_lcontrol)
am("vk_lshift",			dt_real, vk_lshift)
am("vk_multiply",		dt_real, vk_multiply)
am("vk_numpad0",		dt_real, vk_numpad0)
am("vk_numpad1",		dt_real, vk_numpad1)
am("vk_numpad2",		dt_real, vk_numpad2)
am("vk_numpad3",		dt_real, vk_numpad3)
am("vk_numpad4",		dt_real, vk_numpad4)
am("vk_numpad5",		dt_real, vk_numpad5)
am("vk_numpad6",		dt_real, vk_numpad6)
am("vk_numpad7",		dt_real, vk_numpad7)
am("vk_numpad8",		dt_real, vk_numpad8)
am("vk_numpad9",		dt_real, vk_numpad9)
am("vk_pagedown",		dt_real, vk_pagedown)
am("vk_pageup",			dt_real, vk_pageup)
am("vk_pause",			dt_real, vk_pause)
am("vk_printscreen",	dt_real, vk_printscreen)
am("vk_ralt",			dt_real, vk_ralt)
am("vk_rcontrol",		dt_real, vk_rcontrol)
am("vk_return",			dt_real, vk_return)
am("vk_rshift",			dt_real, vk_rshift)
am("vk_subtract",		dt_real, vk_subtract)
}

function initialize_gmcl_macros(){ with o_console {

static am = function(name, type, value){ console_macro_add_ext(name, type, value, false) }

#region Shortcuts
am("undefined",			dt_undefined, o_console)
am("null",				dt_undefined, o_console)

am("con",				dt_instance, o_console)

am("var",				dt_method, create_variable)

am("O1",				dt_variable, "o_console.O1")
am("O2",				dt_variable, "o_console.O2")
am("O3",				dt_variable, "o_console.O3")
am("O4",				dt_variable, "o_console.O4")
am("O5",				dt_variable, "o_console.O5")

am("mouse_x",			dt_variable, "global.mouse_x")
am("mouse_y",			dt_variable, "global.mouse_y")
										
am("fps",				dt_variable, "global.fps")
am("fps_real",			dt_variable, "global.fps_real")
										
am("gui_mx",			dt_variable, "o_console.gui_mouse_x")
am("gui_my",			dt_variable, "o_console.gui_mouse_y")
#endregion
										
#region Console datatypes				
am("dt_real",			dt_string, dt_real)
am("dt_string",			dt_string, dt_string)
am("dt_asset",			dt_string, dt_asset)
am("dt_variable",		dt_string, dt_variable)
am("dt_method",			dt_string, dt_method)
am("dt_instance",		dt_string, dt_instance)
am("dt_unknown",		dt_string, dt_unknown)
am("dt_tag",			dt_string, dt_tag)
am("dt_deprecated",		dt_string, dt_deprecated)
am("dt_color",			dt_string, dt_color)
#endregion								

#region Builtin color schemes
am("cs_drowned",		dt_string, cs_drowned)
am("cs_greenbeans",		dt_string, cs_greenbeans)
am("cs_helios",			dt_string, cs_helios)
am("cs_humanrights",	dt_string, cs_humanrights)
am("cs_rainbowsoup",	dt_string, cs_rainbowsoup)
am("cs_royal",			dt_string, cs_royal)
am("cs_sublimate",		dt_string, cs_sublimate)
am("cs_gms2",			dt_string, cs_gms2)
#endregion

#region Boolean
am("true",				dt_real, true)
am("false",				dt_real, false)
#endregion								
										
#region Instance constants				
am("global",			dt_instance, global)
am("noone",				dt_instance, noone)
am("all",				dt_instance, all)
#endregion

#region Colors
am("c_white",			dt_color, c_white)
am("c_black",			dt_color, c_black)
am("c_red",				dt_color, c_red)
am("c_blue",			dt_color, c_blue)
am("c_yellow",			dt_color, c_yellow)
am("c_green",			dt_color, c_green)
#endregion

#region Blendmodes
am("bm_add",			dt_real, bm_add)
am("bm_dest_alpha",		dt_real, bm_dest_alpha)
am("bm_dest_color",		dt_real, bm_dest_color)
am("bm_inv_dest_alpha",	dt_real, bm_inv_dest_alpha)
am("bm_inv_dest_color",	dt_real, bm_inv_dest_color)
am("bm_inv_src_alpha",	dt_real, bm_inv_src_alpha)
am("bm_inv_src_color",	dt_real, bm_inv_src_color)
am("bm_max",			dt_real, bm_max)
am("bm_normal",			dt_real, bm_normal)
am("bm_one",			dt_real, bm_one)
am("bm_src_alpha",		dt_real, bm_src_alpha)
am("bm_src_alpha_sat",	dt_real, bm_src_alpha_sat)
am("bm_src_color",		dt_real, bm_src_color)
am("bm_subtract",		dt_real, bm_subtract)
am("bm_zero",			dt_real, bm_zero)
#endregion

#region Text alignments
am("fa_top",			dt_real, fa_top)
am("fa_bottom",			dt_real, fa_bottom)
am("fa_middle",			dt_real, fa_middle)
am("fa_left",			dt_real, fa_left)
am("fa_right",			dt_real, fa_right)
am("fa_center",			dt_real, fa_center)
#endregion

#region Ds types
am("ds_type_grid",		dt_real, ds_type_grid)
am("ds_type_list",		dt_real, ds_type_list)
am("ds_type_map",		dt_real, ds_type_map)
am("ds_type_priority",	dt_real, ds_type_priority)
am("ds_type_queue",		dt_real, ds_type_queue)
am("ds_type_stack",		dt_real, ds_type_stack)
#endregion

#region Virtual keys
am("vk_anykey",			dt_real, vk_anykey)
am("vk_nokey",			dt_real, vk_nokey)
																					
am("vk_left",			dt_real, vk_left)
am("vk_up",				dt_real, vk_up)
am("vk_down",			dt_real, vk_down)
am("vk_right",			dt_real, vk_right)
										
am("vk_space",			dt_real, vk_space)
am("vk_backspace",		dt_real, vk_backspace)
am("vk_enter",			dt_real, vk_enter)
am("vk_escape",			dt_real, vk_escape)
am("vk_tab",			dt_real, vk_tab)

am("vk_shift",			dt_real, vk_shift)
am("vk_control",		dt_real, vk_control)
am("vk_alt",			dt_real, vk_alt)

am("vk_tilde",			dt_real, vk_tilde)
#endregion

if include_builtin_functions console_macro_add_builtin(undefined)
ds_list_sort(macro_list, true)
}}