
#macro console_object_exists	global.__console_object_exists
#macro console_exists			global.__console_exists
#macro console_initialized		o_console.initialized
#macro console_enabled			o_console.enabled
#macro mouse_on_console			o_console.mouse_on
#macro clicking_on_console		o_console.clicking_on
#macro console_typing			(o_console.keyboard_scope != noone)
#macro chatterbox_is_ready true//gmcl_work_with_chatterbox and global.__chatterbox_exists and variable_global_exists("chatterboxVariablesMap")

console_object_exists = object_exists(asset_get_index("o_console"))

// Were for embedded text but mostly unused now
#macro cbox_true  "[x]"
#macro cbox_false "[ ]"
#macro cbox_NaN	  "[/]"


#region Virtual key fixes
var apple = (os_type == os_macosx or os_type == os_ios)

#macro vk_rcommand 91
#macro vk_lcommand 92
#macro vk_super global.__super_key
#macro vk_tilde global.__tilde_key

vk_super = apple ? vk_lcommand : vk_control
vk_tilde = apple ? 50 : 192
#endregion


#region General use shortcuts
#macro gui_mx device_mouse_x_to_gui(0)
#macro gui_my device_mouse_y_to_gui(0)

#macro win_width  window_get_width()
#macro win_height window_get_height()

#macro gui_width  display_get_gui_width()
#macro gui_height display_get_gui_height()

#macro disp_width  display_get_width()
#macro disp_height display_get_height()
#endregion


#region Log entry types
#macro lg_whitespace	"whitespace"
#macro lg_userinput		"user input"
#macro lg_bindinput		"bind input"
#macro lg_output		"output"
#macro lg_embed			"embed"
#macro lg_message		"message"
#endregion


#region Color schemes
#macro cs_greenbeans	"greenbeans"
#macro cs_royal			"royal"
#macro cs_drowned		"drowned"
#macro cs_helios		"helios"
#macro cs_humanrights	"humanrights"
#macro cs_rainbowsoup	"rainbowsoup"
#macro cs_sublimate		"sublimate"
#macro cs_gms2			"gms2"
#endregion


#region GMCL datatypes
#macro dt_real			"real"
#macro dt_string		"string"
#macro dt_undefined		"undefined"
#macro dt_asset			"asset"
#macro dt_variable		"variable"
#macro dt_method		"method"
#macro dt_instance		"instance"
#macro dt_color			"color"
#macro dt_builtinvar	"builtinvar"
#macro dt_tag			"tag"
#macro dt_unknown		"plain"
#macro dt_deprecated	"deprecated"
#endregion