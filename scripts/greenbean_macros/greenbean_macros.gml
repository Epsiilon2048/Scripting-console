
#macro console_object_exists	global.__console_object_exists
#macro console_exists			global.__console_exists
#macro console_initialized		o_console.initialized
#macro console_enabled			o_console.enabled
#macro mouse_on_console			o_console.mouse_on
#macro clicking_on_console		o_console.clicking_on
#macro console_typing			(o_console.keyboard_scope != noone)
#macro chatterbox_is_ready gmcl_work_with_chatterbox and global.__chatterbox_exists and variable_global_exists("chatterboxVariablesMap")

console_object_exists = object_exists(asset_get_index("o_console"))

// Were for embedded text but mostly unused now
#macro cbox_true  "[x]"
#macro cbox_false "[ ]"
#macro cbox_NaN	  "[/]"


#region Virtual key fixes
#macro vk_rcommand 91
#macro vk_lcommand 92
#macro vk_super global.__super_key
#macro vk_tilde global.__tilde_key

vk_super = (os_type == os_macosx or os_type == os_ios) ? vk_lcommand : vk_control
vk_tilde = (os_type == os_macosx or os_type == os_ios) ? 50 : 192
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


#region Exceptions
#macro exceptionUnknown "Awfully sorry about this! The console encountered a runtime error with an unknown cause."

#macro exceptionNoValue "No value for arg"
#macro exceptionNoIndex "No value for index"

#macro exceptionMissingScope "Missing scope"
#macro exceptionVariableNotExists "Variable does not exist"
#macro exceptionInstanceNotExists "Instance does not exist"
#macro exceptionAssetNotExists "Asset does not exist"
#macro exceptionObjectNotExists "Object does not exist"
#macro exceptionScriptNotExists "Script does not exist"
#macro exceptionDsNotExists "Intended ds at index does not exist"

#macro exceptionExpectingNumeric "Expecting numeric value"
#macro exceptionExpectingDsIndex "Expecting ds index (numeric)"
#macro exceptionExpectingString "Expecting string"
#macro exceptionExpectingStruct "Expecting struct"
#macro exceptionExpectingArray "Expecting array"

#macro exceptionBadIdentifier "Identifier does not accept this datatype"

#macro exceptionIndexBelowZero "Expecting non-negative index"
#macro exceptionIndexExceedsBounds "Index out of range"
#macro exceptionUnrecognized "Unrecognized term"
#macro exceptionHurtFeelings "User has hurt feelings of console"
#macro exceptionMissingBird "put the bird back please"

#macro exceptionBadScope "Unsupported datatype for scope"
#macro exceptionBadIndex "Unsupported datatype for index"
#macro exceptionFailedAccess "Value cannot be accessed with brackets"
#macro exceptionMissingAccessor "Missing ds accessor"
#macro exceptionBadAccessor "Variable cannot be accessed in this way"
#macro exceptionGridExpectingComma "ds grids require x and y indexes for access"

#macro exceptionBotchedString "Invalid string syntax"
#macro exceptionBotchedInstance "Invalid instance syntax"
#macro exceptionBotchedAsset "Invalid asset syntax"
#macro exceptionBotchedMethod "Invalid method syntax"
#macro exceptionBotchedReal "Invalid real syntax"
#macro exceptionBotchedVariable "Invalid variable syntax"
#macro exceptionBotchedColor "Invalid color syntax"

#macro exceptionNoChatterbox "This feature is exclusive to chatterbox, which doesn't exist in this project!"
#macro exceptionChatterboxNotReady "Chatterbox has not initialized variable map!"
#macro exceptionChatterboxVariableNotExists "Chatterbox variable does not exist"
#endregion