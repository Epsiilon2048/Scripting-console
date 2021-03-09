
f = [
	{pos: 1},
	{pos: 12},
	{pos: 231},
	{pos: 13},
	{pos: 123},
	{pos: 1},
	{pos: 231},
	{pos: 1},
	{pos: 51},
	{pos: 231},
	{pos: 1555},
	{pos: 1},
	{pos: 123},
	{pos: 1},
	{pos: 1523},
]

include_niche_virtual_keys = false
console_macros = {}
initialize_console_macros()

scale_mult = array_create(3)
scale_font = array_create(3)

scale_mult[1] = 11/15
scale_font[1] = fnt_debug1x

scale_mult[2] = 1
scale_font[2] = fnt_debug2x

draw_scale = 2

var display_size = display_get_width()*display_get_height()

if display_size >= 2560*1440 draw_scale = 2
else						 draw_scale = 1

font = scale_font[draw_scale]

#macro SCALE_ o_console.scale_mult[o_console.draw_scale] *

#macro _BOOL_STRING ? "true" : "false"
#macro _PLURAL == 1 ? "" : "s"

WINDOW = {}; with WINDOW {
	
	width = 400
	height = 300
}

COLOR_PICKER = {}; with COLOR_PICKER {
	
	var c = surface_create(256, 256)
	surface_set_target(c)

	for(var yy = 0; yy <= 255; yy++)
	for(var xx = 0; xx <= 255; xx++)
	{
		var _col = make_color_hsv(
			0,
			xx,
			255-yy
		)

		draw_point_color(xx, yy, _col)
	}
	draw_set_alpha(1)

	sv_square = sprite_create_from_surface(c, 0, 0, 256, 256, false, false, 0, 0)

	surface_reset_target()
	surface_resize(c, 1, 256)
	surface_set_target(c)

	draw_clear_alpha(c_black, 1)

	for(var yy = 0; yy <= 255; yy++)
	{
		var _col = make_color_hsv(yy, 255, 255)
		draw_point_color(0, yy, _col)
	}
	draw_set_color(c_white)

	h_strip = sprite_create_from_surface(c, 0, 0, 1, 256, false, false, 0, 0)

	surface_reset_target()
	surface_free(c)
	
	border_width = 1
	border_alpha = .2
	
	sv_square_dropper_radius = 11
	
	h_strip_width	   = 50
	h_strip_dist	   = 20
	h_strip_bar_height = 18
	
	color_bar_dist	 = 20
	color_bar_height = 53
	
	hue = 0
	sat = 255
	val = 255
	
	color = make_color_hsv(hue, sat, val)
	size = 100
}

CTX_MENU = {}; with CTX_MENU {
	
	SEPARATOR = "separator"
	
	enabled = false
	
	x = 50
	y = 50
	
	border_l = 36
	border_r = 10
	
	mouse_item = -1
	
	clicking_on = false
	
	inputs = false
	
	left   = 0
	right  = 0
	top	   = 0
	bottom = 0
	
	roundrect_radius = 5
	
	spacing = 8
	sep_spacing = 10
	
	font = o_console.font
}

CTX_STRIP = {}; with CTX_STRIP {
	
	dist   = 7
	border = 5
	
	line_width = 1
	
	time = 20
	alpha_spd = .3
	
	font = o_console.font
}

SLIDER = {}; with SLIDER {
	
	height			 = SCALE_ 39
	height_condensed = SCALE_ 15
	text_offset		 = SCALE_ 10
	
	update_every_frame	  = true
	lock_value_to_step	  = true
	correct_not_real	  = true
	text_fill_places	  = true
	
	font = o_console.font
	marker_font = -1 //set later
	
	divider_width = 2
}


space_sep = ds_list_create()
ds_list_add(space_sep,
	",",
	"(",
	")",
	"="
)

identifiers = {}
identifiers[$ "a"] = DT.ASSET
identifiers[$ "v"] = DT.VARIABLE
identifiers[$ "s"] = DT.STRING

#macro RGB make_color_rgb

enum SIDES
{
	TOP		= 0,
	RIGHT	= 90,
	BOTTOM	= 180,
	LEFT	= 270,
}

enum DT //data types
{
	NUMBER,
	STRING,
	ASSET,
	VARIABLE,
	SCRIPT,
	OBJECT,
	MACRO,
	ROOM,
}

color_schemes = {}

dt_string[DT.NUMBER  ] = "number"
dt_string[DT.STRING  ] = "string"
dt_string[DT.ASSET   ] = "asset"
dt_string[DT.VARIABLE] = "variable"
dt_string[DT.SCRIPT  ] = "script"
dt_string[DT.OBJECT  ] = "object"
dt_string[DT.MACRO   ] = "macro"
dt_string[DT.ROOM	 ] = "room"

console_key = vk_tab

old_obj_identifier = "o_"

show_hidden_commands = false
show_hidden_args = false

updown_enables_console = false

body_blur_quality = .4

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

window_blur = false

cs_index = "greenbeans"

console_color_interval = 300
console_color_time = 0

keybinds = []

//these are just for the help command
is_this_the_display = "it sure is!"
checkboxes_like_this_one = false

global.gui_mx = 0
global.gui_my = 0

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

separators = "not gonna do this yet, il;l add it later"

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
	console_x	= other.console_text_x
	console_y	= other.console_top - SCALE_ 12
	noconsole_x	= other.console_text_x
	noconsole_y	= other.console_text_y
	
	x = other.console_text_x
	y = other.console_text_y
	
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
	{name: "color",					newname: "color_make",	ver: "Early 1.2"},
	{name: "obj_reset",				newname: "reset_obj",	ver: "Early 1.2"},
	{name: "window_toggle",			newname: "window",		ver: "Early 1.2"},
	{name: "display_all_variables", newname: "display_all", ver: "Early 1.2"},
	{name: "select",				newname: "select_obj",	ver: "Unreleased 1.0"},
	{name: "objects_in_room",		newname: "roomobj",		ver: "Unreleased 1.0"},
	{name: "variables_in_object",	newname: "objvar",		ver: "Unreleased 1.0"},
	{name: "var_to_mouse_x",		newname: "vt_mx",		ver: "Unreleased 1.0"},
	{name: "var_to_mouse_y",		newname: "vt_my",		ver: "Unreleased 1.0"},
	{name: "var_to_var",			newname: "vtv",			ver: "Unreleased 1.0"},
	{name: "create_camera_point",	note: "Was project specific", ver: "Unreleased 1.0"},
]

greetings = [
	"Hello!! Welcome to the console!",
	"Afternoon! Or morning! Or whenever!",
	"Howsya day going?",
	"Hiya!",
	"Ay how's it goin?",
	"Heloooooo,"
]

run_in_embed   = false
run_in_console = false

output_set({__embedded__: true, o: [greetings[irandom(array_length(greetings)-1)]+" Click ",{str: "here", scr: help, output: true}," for a commands, info, and settings (or just type \"help\")!"]})
Output.alpha = 0

initialize_color_schemes()
console_startup()
