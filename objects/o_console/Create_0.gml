

include_niche_virtual_keys = false
console_macros = {}

color_picker_var = ""

keyboard_scope = o_console

initialize_console_macros()

initialize_console_graphics()

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

#macro SCALE_ o_console.draw_scale.mult *

#macro _BOOL_STRING ? "true" : "false"
#macro RGB make_color_rgb

#macro gui_mx device_mouse_x_to_gui(0)
#macro gui_my device_mouse_y_to_gui(0)

#macro dt_real			"real"
#macro dt_string		"string"
#macro dt_asset			"asset"
#macro dt_variable		"variable"
#macro dt_method		"method"
#macro dt_instance		"instance"
#macro dt_room			"room"
#macro dt_tag			"tag"
#macro dt_unknown		"plain"
#macro dt_deprecated	"deprecated"

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

gui_mouse_x = gui_mx
gui_mouse_y = gui_my

color_schemes = {}

console_key = vk_tab

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
force_output_embed_body = false

force_body_solid = false

cs_index = cs_greenbeans

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
command_log = ds_list_create()
error_log = ds_list_create()

command_colors = true

value_boxes = ds_list_create()
value_box_dragging = false
value_box_deleted = false

var greetings = [
	"Hello!! Welcome to the console!",
	"Afternoon! Or morning! Or whenever!",
	"Howsya day going?",
	"Hiya!",
	"Ay how's it goin?",
	"Heloooooo,"
]

O1 = ""
O2 = ""
O3 = ""
O4 = ""
O5 = ""

run_in_embed   = false
run_in_console = false

output_set(greetings[irandom(array_length(greetings)-1)]+" Type \"help\" for a general guide.")
Output.alpha = 0

initialize_color_schemes()
initialize_command_info()
console_startup()