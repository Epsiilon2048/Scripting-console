
#macro console_enabled o_console.enabled
#macro mouse_on_console o_console.mouse_on
#macro clicking_on_console o_console.clicking_on

clicking_on_console = false
mouse_on_console = false

rainbowify = function(list){
for(var i = 0; i <= array_length(list)-1; i++){
	colors[$ list[@ i]] = color_add_hue(colors[$ list[@ i]], rainbow) 
}
}

e = {}

update_steps = 10

colors = {}

fonts = [
	fnt_debug1x,
	fnt_debug2x,
	fnt_debug3x,
	fnt_debug4x,
	fnt_debug5x,
	fnt_debug6x,
]

scale = function(size){ with o_console {
	
	font = fonts[ clamp(size-1, 0, array_length(fonts)-1) ]
}}

run_in_embed = false
char_pos_arg = {}

include_builtin_functions = true

ds_types = ds_map_create() // if this is indexed, it has to be done after, using the already existing ind
ds_names = {}
ds_names[$ ds_type_grid]		= []
ds_names[$ ds_type_list]		= []
ds_names[$ ds_type_map]			= []
ds_names[$ ds_type_priority]	= []
ds_names[$ ds_type_queue]		= []
ds_names[$ ds_type_stack]		= []

refresh_sep = " ./;,=()[]:@?#$|"

bird_mode = false

builtin_excluded = [
	//"string",
	//"array",
	//"ds_list",
	//"ds_map",
	"ds_grid_",
	"ds_priority_",
	"ds_queue_",
	"ds_stack_",
	"ads_",
	"layer_",
	"gesture_",
	"keyboard_",
	"font_",
	"part_",			// Particles
	"steam_",	
	"xboxone_",	 
	"xboxlive_",	 
	"switch_",		// Of the nintendo variety
	"psn_",		
	"winphone_",	 
	"win8_",		 
	"vertex_",		 
	"uwp_",		
	"iap_",
	"sprite_",		 
	"skeleton_",	 
	"sequence_",	  
	"physics_",	 
	"path_",		 
	"matchmaking_", 
	"gpu_",
	"file_",
	"draw_",		 
	"display_",	 
	"date_",		 
	"camera_",		 
	"buffer_",		 
	"audio_",		 
	"achievement_", 

	// These are all odd builtin GML functions which aren't allowed in the studio, but are picked up when
	// indexing all the builtin functions. All of them are either useless or have GML counterparts.
	"ds_list_set_",		//ds_list_set_pre & ds_list_set_post 
	"ds_map_set_",		//ds_map_set_pre & ds_map_set_post 
	"ds_grid_set_p",	//ds_grid_set_pre & ds_grid_set_post
	"array_set_",		//array_set_pre, array_set_post, array_set_2D_pre, array_set_2D_post, & array_set_2D
	"@@",
	"yyAsm",
	"YoYo_",
	"$",				//$PRINT, $FAIL, $ERROR
	"sleep",
	"testFailed",
]

mouse_char_pos = false

elements = ds_create(ds_type_list, "elements")

macro_list = ds_create(ds_type_list, "macro_list")
method_list = ds_create(ds_type_list, "method_list")
asset_list = ds_create(ds_type_list, "asset_list")
instance_variables = []
scope_variables = []
lite_suggestions = ds_create(ds_type_list, "lite_suggestions")
suggestions = ds_create(ds_type_list, "suggestions")

autofill = {}; with autofill {
	macros = -1
	methods = -1
	assets = -1
	instance = -1
	scope = -1
	lite_suggestions = -1
	suggestions = -1
}

console_macros = {}

subchar_pos1 = 0
subchar_pos2 = 0

DOCK = {}
TEXT_BOX = {}
BAR = {}
OUTPUT = {}
AUTOFILL = {}
CHECKBOX = {}
WINDOW = {}
COLOR_PICKER = {}
CTX_MENU = {}
CTX_STRIP = {}
SLIDER = {}
SEPARATOR = {}
CD_BUTTON = {}

keyboard_scope = noone

do_autofill = false

index_functions()
index_assets()
initialize_console_macros()
initialize_console_graphics()

identifiers = {
	r: dt_real,
	s: dt_string,
	a: dt_asset,
	v: dt_variable,
	m: dt_method,
	i: dt_instance,
	c: dt_color,
}

draw_order = ds_create(ds_type_list, "draw_order")

#macro script_exists better_script_exists

#macro failedColor ""
#macro failedComplier ""
#macro failedRunner ""
#macro failedBind ""
#macro failedEmbed ""

#macro exceptionUnknown "Whoops! We're not sure what went wrong."
#macro exceptionNoValue "No value for arg"
#macro exceptionNoIndex "No value for index"

#macro exceptionMissingScope "Missing scope"
#macro exceptionVariableNotExists "Variable does not exist"
#macro exceptionInstanceNotExists "Instance does not exist"
#macro exceptionAssetNotExists "Asset does not exist"
#macro exceptionObjectNotExists "Object does not exist"
#macro exceptionScriptNotExists "Script does not exist"
#macro exceptionDsNotExists "Intended ds at index does not exist"

#macro exceptionExpectingNumeric "Expecting numeric"
#macro exceptionExpectingDsIndex "Expecting ds index (numeric)"
#macro exceptionExpectingString "Expecting string"
#macro exceptionExpectingStruct "Expecting struct"
#macro exceptionExpectingArray "Expecting array"

#macro exceptionBadIdentifier "Identifier does not accept this datatype"

#macro exceptionIndexBelowZero "Expecting non-negative index"
#macro exceptionIndexExceedsBounds "Index out of range"
#macro exceptionUnrecognized "Unrecognized term"
#macro exceptionHurtFeelings "User has hurt feelings of console"

#macro exceptionBadScope "Unsupported datatype for scope"
#macro exceptionBadIndex "Unsupported datatype for index"
#macro exceptionFailedAccess "Value cannot be accessed with brackets"
#macro exceptionMissingAccessor "Missing ds accessor"
#macro exceptionBadAccessor "Variable cannot be accessed in this way"
#macro exceptionGridExpectingComma "ds grids require x and y indexes for access"

#macro exceptionBotchedString "Botched string"
#macro exceptionBotchedInstance "Botched instance"
#macro exceptionBotchedAsset "Botched asset"
#macro exceptionBotchedMethod "Botched method"
#macro exceptionBotchedReal "Botched real"
#macro exceptionBotchedVariable "Botched variable"
#macro exceptionBotchedColor "Botched color"

#macro vk_tilde 192

#macro gui_mx device_mouse_x_to_gui(0)
#macro gui_my device_mouse_y_to_gui(0)

#macro win_width  window_get_width()
#macro win_height window_get_height()

#macro gui_width  display_get_gui_width()
#macro gui_height display_get_gui_height()

#macro dt_real			"real"
#macro dt_string		"string"
#macro dt_asset			"asset"
#macro dt_variable		"variable"
#macro dt_method		"method"
#macro dt_instance		"instance"
#macro dt_room			dt_asset //ill get rid of this one later
#macro dt_color			"color"		// Only used for identifiers
#macro dt_builtinvar	"builtinvar"
#macro dt_tag			"tag"
#macro dt_unknown		"plain"
#macro dt_deprecated	"deprecated"

#macro lg_whitespace	"whitespace"
#macro lg_userinput		"user input"
#macro lg_bindinput		"bind input"
#macro lg_output		"output"
#macro lg_embed			"embed"
#macro lg_message		"message"

#macro cs_greenbeans	"greenbeans"
#macro cs_royal			"royal"
#macro cs_drowned		"drowned"
#macro cs_helios		"helios"
#macro cs_humanrights	"humanrights"
#macro cs_rainbowsoup	"rainbowsoup"
#macro cs_sublimate		"sublimate"

#macro vb_static		"static"
#macro vb_scrubber		"scrubber"
#macro vb_bool			"bool"
#macro vb_color			"color"

//unfinished
#macro vb_counter		"counter"
#macro vb_string		"string"
#macro vb_variable		"variable"
#macro vb_asset			"variable"
#macro vb_list			"list"		//arrays and ds lists
#macro vb_map			"map"		//structs and ds maps
#macro vb_grid			"grid"		//2d arrays and ds grids

#macro ctx_separator	"separator"

event_commands = {
	step:	  [],
	step_end: [],
	draw:	  [],
	gui:	  [],
}

ctx = new Ctx_menu()
ctx.scope = o_console
ctx.set([])

gui_mouse_x = gui_mx
gui_mouse_y = gui_my

color_schemes = {}

console_key = vk_tilde

show_hidden_commands = false
show_hidden_args = false

embed_text = true
window_embed_text = true
collapse_windows = true

display_show_objects = false

output_set_window = true

text_outline = 8

output_as_window = false
force_output = false
force_output_body = false //this sounds pretty yikesy thinking of it now
force_output_embed_body = true

autofill_from_float = false

force_body_solid = false

cs_index = cs_greenbeans

right_mb = false

//these are just for the help command
is_this_the_display = "it sure is!"
checkboxes_like_this_one = false

prev_exception = {longMessage: "No errors yet! Yay!!"}

var old_font = draw_get_font()
draw_set_font(font)

step = 0

win_w = display_get_gui_width()
win_h = display_get_gui_height()

console_string = ""
char_pos1 = 1
char_pos2 = 1
char_pos_dir = 0 //the direction the selection is moving in based on arrow keys

left		= false
right		= false
shift		= false
backspace	= false
del			= false
enter		= false
log_up		= false
log_down	= false
select_all	= false
copy		= false
paste		= false

//i dont remember what f stands for but these are for key repeating
key_repeat  = 30
fleft		= 0
fright		= 0
fbackspace	= 0
fdel		= 0

draw_set_font(old_font)

object = noone  //object in scope

mouse_starting_x = undefined
mouse_starting_y = undefined

input_log = ds_create(ds_type_list, "input_log")
input_log_limit = 20
input_log_index = -1
input_log_save = ""

display_list = ds_create(ds_type_list, "display_list")

x2 = 0
y2 = 0
mouse_click_range = 1
rainbow = false

log = ds_create(ds_type_list, "log")

inst_select = false
inst_selecting = noone
inst_selecting_name = ""

instance_cursor = false

color_string = []
command_log = ds_create(ds_type_list, "command_log")
error_log = ds_create(ds_type_list, "error_log")

command_colors = true

O1 = ""
O2 = ""
O3 = ""
O4 = ""
O5 = ""

run_in_console = false

cs_template = cs_greenbeans

var greetings = [
	"I hope you're having a wonderful day!",
	"Afternoon! Or morning! Or whenever!",
	"Howsya day going?",
	"Hiya!",
	"Ay how's it goin?",
	"Remember to take breaks from time to time!",
	"yooooooo sup",
]
 
mouse_get_char_pos = function(rounding_method){
	
	var old_font = draw_get_font()
	draw_set_font(font)
	var cw = string_width(" ")
	draw_set_font(old_font)
	
	return clamp( rounding_method((gui_mx-BAR.text_x) / cw)+(rounding_method == floor), 1, string_length(console_string)+1 )
}

output_set( greetings[ round( current_time mod array_length(greetings) ) ] )

initialize_color_schemes()
initialize_console_docs()

startup = true


var cd1 = new Console_dock() with cd1
{
	initialize()
	name = "Docks"
	set([
		new_cd_button("Hello world", show_debug_message),
		[new_scrubber("Outline", "con.DOCK.name_outline_width", .1)],
		["Border", new_scrubber("W", "con.DOCK.name_wdist", 1), new_scrubber("H", "con.DOCK.name_hdist", 1)],
		new_separator(),
		["Border", new_scrubber("W", "con.DOCK.element_wdist", 1),  new_scrubber("H", "con.DOCK.element_hdist", 1)],
		["Separation", new_scrubber("W", "con.DOCK.element_wsep", 1), new_scrubber("H", "con.DOCK.element_hsep", 1)],
		new_separator(),
		[new_scrubber("Base", "con.DOCK.dropdown_base", 1), new_scrubber("Hypotenuse", "con.DOCK.dropdown_hypotenuse", 1)],
		[new_scrubber("Border", "con.DOCK.dropdown_wdist", 1)],
	])
}

add_console_element(cd1)

var cd1 = new Console_dock() with cd1
{
	initialize()
	name = "Docks"
	set([
		new_cd_button("Hello world", show_debug_message),
		new_console_dock("Name", [
			[new_scrubber("Outline", "con.DOCK.name_outline_width", .1)],
			["Border", new_scrubber("W", "con.DOCK.name_wdist", 1), new_scrubber("H", "con.DOCK.name_hdist", 1)],
		]),
		new_console_dock("Elements", [
			["Border", new_scrubber("W", "con.DOCK.element_wdist", 1),  new_scrubber("H", "con.DOCK.element_hdist", 1)],
			["Separation", new_scrubber("W", "con.DOCK.element_wsep", 1), new_scrubber("H", "con.DOCK.element_hsep", 1)],
		]),
		new_console_dock("Dropdown triangle", [
			[new_scrubber("Base", "con.DOCK.dropdown_base", 1), new_scrubber("Hypotenuse", "con.DOCK.dropdown_hypotenuse", 1)],
			[new_scrubber("Border", "con.DOCK.dropdown_wdist", 1)],
		]),
	])
}

add_console_element(cd1)

q = ""
cd2 = new Console_dock() with cd2
{
	initialize()
	name = "Command line"
	allow_element_dragging = false
	set([
		other.BAR
	])
}

element_dragging = noone

add_console_element(cd2)
add_console_element(BAR)
add_console_element(OUTPUT)
add_console_element(new_text_box("Q", "o_console.e.Q.mouse_on"))