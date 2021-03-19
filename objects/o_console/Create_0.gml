
#macro SCALE_ o_console.draw_scale.mult *

#macro _BOOL_STRING ? "true" : "false"
#macro _PLURAL == 1 ? "" : "s"
#macro RGB make_color_rgb

#macro gui_mx device_mouse_x_to_gui(0)
#macro gui_my device_mouse_y_to_gui(0)

include_niche_virtual_keys = false
console_macros = {}

color_picker_var = ""

initialize_console_macros()

initialize_console_graphics()

space_sep = ds_list_create()
ds_list_add(space_sep,
	",",
	"(",
	")",
	"="
)

identifiers = {
	r: dt_real,
	s: dt_string,
	a: dt_asset,
	v: dt_variable,
	m: dt_method,
	i: dt_instance,
	n: dt_room,
}

enum SIDES { TOP = 0, RIGHT = 90, BOTTOM = 180, LEFT = 270, }

#macro dt_real		"real"
#macro dt_string	"string"
#macro dt_asset		"asset"
#macro dt_variable	"variable"
#macro dt_method	"method"
#macro dt_instance	"instance"
#macro dt_room		"room"
#macro dt_tag		"tag"
#macro dt_unknown	"plain"

#macro vb_static	"static"
#macro vb_scrubber	"scrubber"
//#macro vb_counter	"counter"
#macro vb_bool		"bool"
//#macro vb_string	"string"
//#macro vb_list		"list"		//arrays and ds lists
//#macro vb_map		"map"		//structs and ds maps
//#macro vb_grid		"grid"		//2d arrays and ds grids
#macro vb_color		"color"

event_commands = {
	step:	  [],
	step_end: [],
	draw:	  [],
	gui:	  [],
}

gui_mouse_x = gui_mx
gui_mouse_y = gui_my

color_schemes = {}

console_key = vk_tab

old_obj_identifier = "o_"

show_hidden_commands = false
show_hidden_args = false

updown_enables_console = false

embed_text = true
window_embed_text = true
collapse_windows = true

display_show_objects = false
display_update = 1

output_set_window = true

output_as_window = false
force_output = false
force_output_body = false //this sounds pretty yikesy thinking of it now
force_output_embed_body = false

force_body_solid = false

cs_index = "greenbeans"

console_color_interval = 300
console_color_time = 0

keybinds = []

//these are just for the help command
is_this_the_display = "it sure is!"
checkboxes_like_this_one = false

prev_exception = {longMessage: "No errors yet! Yay!!"}

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

object = noone  //object in scope
mouse_over_object = false

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
	console_y	= o_console.console_top - SCALE_ 12
	noconsole_x	= o_console.console_text_x
	noconsole_y	= o_console.console_text_y
	
	x = console_x
	y = noconsole_y
	
	border_w = SCALE_ 6
	border_h = SCALE_ 5
	
	text			= []
	plaintext		= ""
	text_embedding	= false
	
	time			 = 3*60
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

to_mouse_x_object = noone
to_mouse_y_object = noone
to_mouse_x = ""
to_mouse_y = ""
to_mouse_gui = false

to_var		= ""
from_var	= ""
to_object	= noone
from_object = noone

inst_select = false
inst_selecting = noone
inst_selecting_name = ""

instance_cursor = false

color_string = []

console_colors = true

commands = [
	{scr: "help", desc: "Returns console help and info. But surely you already know this command if you're viewing it?"},
	{scr: "command_help", optargs: ["command"], desc: "Returns the usage of a command; if left blank, returns the list of commands"},
	{scr: "syntax_help", optargs: ["command"], desc: "Returns the usage of a command; if left blank, returns the list of commands"},
	{hidden: true, scr: "console_window_help", desc: "Returns an explanation of console windows"},
	{hidden: true, scr: "embedded_text_help", desc: "Returns an explanation of text embedding"},
	
	{scr: "console_settings", desc: "Returns the console settings menu"},
	{scr: "color_scheme", args:["color scheme index"], desc: "Sets the console color scheme to the specified index"},
	{scr: "color_scheme_settings", desc: "Returns the color scheme settings menu"},
	{hidden: true, scr: "console_videos", desc: "Returns a list of videos featuring the console"},
	{hidden: true, scr: "initialize_color_schemes", desc: "Resets the color schemes"},
	
	{hidden: true, scr: "Epsiilon", desc: "Returns info about the creator of the console"},
	{hidden: true, scr: "nice_thing", desc: "Why don't you run it and find out?"},
	{hidden: true, scr: "destroy_console", hiddenargs: ["are you certain?"], desc: "please dont :/"},
	
	{scr: "error_report", desc: "Returns the longMessage of the previous error thrown by a console command"},
	
	{scr: "ar", args: ["array", "index"], optargs: ["value"], desc: "Returns the specified index of an array, or sets the specified index to a value"},
	{scr: "addvar", args: ["variable"], optargs: ["value"], desc: "Adds a value to the specified variable; value defaults to 1"},
	{scr: "togglevar", args: ["variable"], desc: "Toggles a boolean variable"},
	
	{scr: "roomobj", desc: "Returns all the instances in the room"},
	{scr: "objvar", optargs: ["object"], desc: "Returns all the variables in the specified/scoped instance"},
	
	{scr: "select_obj", desc: "After running, click on an instance to set the console's scope"},
	{scr: "reset_obj", optargs: ["object"], desc: "Destroys and recreates the specified/scoped instance"},
	
	{scr: "window", optargs: ["text"], desc: "Sets the Window text; if left blank, toggles the Window"},
	{scr: "window_reset_pos", desc: "Resets the position of the Window"},
	
	{scr: "display", optargs: ["variable"], hiddenargs: ["enable?"], desc: "Puts a specified variable on the Display; if left blank, toggles the Display"},
	{scr: "displayds", optargs: ["DS list"], hiddenargs: ["enable?"], desc: "Puts a specified DS list on the Display"},
	{scr: "display_all", optargs: ["object"], hiddenargs: ["enable all?"], desc: "Puts all variables in the specified/scoped instance on the Display"},
	{scr: "display_clear", desc: "Removes all variables from the Display"},
	{scr: "display_reset_pos", desc: "Resets the position of the Display"},
	
	{scr: "bind",	  args: ["key", "command"], desc: "Binds a key to a command"},
	{scr: "unbind",	  args: ["bind index"], hiddenargs: ["return bindings menu?"], desc: "Removes the binding in the specified index"},
	{scr: "bindings", desc: "Returns the list of bindings"},

	{scr: "vtv", optargs: ["to variable", "from variable"], desc: "Sets the 'to' variable to the 'from' variable every step; if left blank clears the previous vtv"},
	{scr: "vt_mx", optargs: ["variable"], desc: "Sets the specified variable to mouse_x every step; if left blank clears the previous vt_mx"},
	{scr: "vt_my", optargs: ["variable"], desc: "Sets the specified variable to mouse_y every step; if left blank clears the previous vt_my"},
	{scr: "vtm_gui", desc: "Toggles between taking the regular/gui positions of the mouse for the var to mouse commands"},

	{scr: "color_make", args: ["r", "g", "b"], desc: "Returns a color value and sets the scoped instance's _col variable to the return"},
	{scr: "color_get",	optargs: ["color value"], desc: "Returns the RGB of a color value; if left blank returns the RBG of the scoped instance's _col variable"},
]

outdated = [
	{name: "ar",					newname: "@",			ver: "Release 1.2"},
	{name: "color",					newname: "color_make",	ver: "Early 1.2"},
	{name: "obj_reset",				newname: "reset_obj",	ver: "Early 1.2"},
	{name: "window_toggle",			newname: "window",		ver: "Early 1.2"},
	{name: "display_all_variables", newname: "display_all", ver: "Early 1.2"},
	{name: "select",				newname: "select_obj",	ver: "Unreleased 1.0"},
	{name: "objects_in_room",		newname: "roomobj",		ver: "Unreleased 1.0"},
	{name: "variables_in_object",	newname: "objvar",		ver: "Unreleased 1.0"},

	{name: "vtv",					note: "Became obsolete with better parsing", ver: "Release 1.2"},
	{name: "vt_mx",					note: "Became obsolete with better parsing", ver: "Release 1.2"},
	{name: "vt_my",					note: "Became obsolete with better parsing", ver: "Release 1.2"},
	{name: "var_to_mouse_x",		note: "Became obsolete with better parsing", ver: "Unreleased 1.0"},
	{name: "var_to_mouse_y",		note: "Became obsolete with better parsing", ver: "Unreleased 1.0"},
	{name: "var_to_var",			note: "Became obsolete with better parsing", ver: "Unreleased 1.0"},
	{name: "create_camera_point",	note: "Was project specific",				 ver: "Unreleased 1.0"},
]

var greetings = [
	"Hello!! Welcome to the console!",
	"Afternoon! Or morning! Or whenever!",
	"Howsya day going?",
	"Hiya!",
	"Ay how's it goin?",
	"Heloooooo,"
]

run_in_embed   = false
run_in_console = false

output_set(greetings[irandom(array_length(greetings)-1)]+" Type \"help\" for a general guide.")
Output.alpha = 0

initialize_color_schemes()
console_startup()
