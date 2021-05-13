
include_builtin_functions = true

builtin_exclude = [

//	"string",
//	"array",
//	"ds_list",
//	"ds_map",
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
]

macro_list = ds_list_create()
method_list = ds_list_create()
instance_variables = []
scope_variables = []
suggestions = ds_list_create()

autofill = {}; with autofill {
	macros = -1
	methods = -1
	instance = -1
	scope = -1
	suggestions = -1
}

console_macros = {}

keyboard_scope = o_console

index_functions()
initialize_console_macros()
initialize_console_graphics( undefined )

bar_x = undefined
bar_y = undefined
bar_width = undefined

identifiers = {
	r: dt_real,
	s: dt_string,
	a: dt_asset,
	v: dt_variable,
	m: dt_method,
	i: dt_instance,
	c: dt_color,
}

enum SIDES { TOP = 0, RIGHT = 90, BOTTOM = 180, LEFT = 270, }

#macro script_exists better_script_exists

#macro vk_tilde 192

#macro SCALE_ o_console.draw_scale.mult *

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
#macro dt_room			"room"
#macro dt_color			"color"	// Only used for identifiers
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
ctx.set([
	{str: "Clear output",			output: true},
	{str: "Copy output",			scr: function(){ clipboard_set_text(o_console.O1) }},
	{str: "Set window to output",	scr: window_set_output				},
	{str: "Always Show output",		checkbox: "o_console.force_output"	},
	ctx_separator,
	{str: "Room instances",		scr: roomobj,			output: true},
	{str: "Instance variables",	scr: objvar,			output: true},
	ctx_separator,
	{str: "Help",			scr: help,					output: true},
	{str: "Commands",		scr: command_help,			output: true},
	{str: "Settings",		scr: console_settings,		output: true},
	{str: "Color schemes",	scr: color_scheme_settings,	output: true},
	{str: "Nice thing",		scr: nice_thing,			output: true},
])
gui_mouse_x = gui_mx
gui_mouse_y = gui_my

color_schemes = {}

console_key = vk_tilde

old_obj_identifier = "o_"

show_hidden_commands = false
show_hidden_args = false

embed_text = true
window_embed_text = true
collapse_windows = true

display_show_objects = false
display_update = 1

output_set_window = true

output_as_window = false
force_output = false
force_output_body = false //this sounds pretty yikesy thinking of it now
force_output_embed_body = true

force_body_solid = false

cs_index = cs_greenbeans

console_color_interval = 300
console_color_time = 0

right_mb = false

keybinds = []

//these are just for the help command
is_this_the_display = "it sure is!"
checkboxes_like_this_one = false

prev_exception = {longMessage: "No errors yet! Yay!!"}

var old_font = draw_get_font()
draw_set_font(font)

step = 0

win_w = display_get_gui_width()
win_h = display_get_gui_height()

console_toggle = false	//where the user inputs commands

console_left	= 50
console_right	= win_w-50
console_top		= win_h-90
console_bottom	= win_h-50
console_text_x	= console_left + 18
console_text_y	= console_bottom + (console_top-console_bottom)/2
console_object_x = console_right - 18

console_string = ""
char_width	= string_width(" ") //the width of a single character -- MUST HAVE CONSISTENT KERNING
char_height = string_height(" ")
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

input_log = ds_list_create()
input_log_limit = 20
input_log_index = -1

display_list = ds_list_create()

x2 = 0
y2 = 0
mouse_click_range = 1
rainbow = false

Display = new Console_window()
Display.initialize("Display", 23, 23, SIDES.LEFT)

Window = new Console_window()
Window.initialize("Window", 23, 23, SIDES.RIGHT)

Output = {}; with Output {
	console_x	= o_console.console_text_x
	console_y	= o_console.console_top - SCALE_ 15
	noconsole_x	= o_console.console_text_x
	noconsole_y	= o_console.console_text_y
	
	x = console_x
	y = noconsole_y
	
	border_w = 11
	border_h = 7
	
	text			= new Embedded_text()
	plaintext		= ""
	text_embedding	= false
	
	time			 = 6*60
	fade_time		 = 0
	alpha			 = 0
	alpha_dec		 = .04
	mouse_over		 = false
	mouse_over_embed = false
	
	tag = -1
	tag_prev = -1
	tag_prev_menu = -1

	tag_set = function(_tag){
		
		if tag != -1 tag_prev_menu = tag
		tag_prev = tag
		tag = _tag
	}
}
Output_window = new Console_window()
Output_window.initialize("Output", SCALE_ 23, SCALE_ 300, SIDES.LEFT)

log = ds_list_create()

inst_select = false
inst_selecting = noone
inst_selecting_name = ""

instance_cursor = false

color_string = []
command_log = ds_list_create()
error_log = ds_list_create()

command_colors = true

value_boxes = ds_list_create()
value_box_dragging = false
value_box_deleted = false

O1 = ""
O2 = ""
O3 = ""
O4 = ""
O5 = ""

run_in_embed   = false
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

output_set( greetings[ round( current_time mod array_length(greetings) ) ] )

initialize_color_schemes()
initialize_console_docs()

startup = true