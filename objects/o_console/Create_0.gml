
birdcheck()

if instance_number(o_console) > 1
{
	show_debug_message("Attempted to create another console object when one already existed!")
	instance_destroy()
	exit
}

run_in_console = false
clicking_on_console = false
mouse_on_console = false

rainbowify = function(list){
	for(var i = 0; i <= array_length(list)-1; i++){
		colors[$ list[@ i]] = color_add_hue(colors[$ list[@ i]], rainbow) 
	}
}

element_dragging = noone

e = {}

consistent_spacing = false

update_steps = 10

colors = {}

fonts = []
var i = 1
var asset = fnt_debug1x
while font_exists(asset)
{
	array_push(fonts, asset)
	asset = asset_get_index(stitch("fnt_debug",++i,"x"))
}

scale = function(size){

	if is_undefined(size)
	{
		var display_width = display_get_width()/display_get_dpi_x()
		size = 2 + (display_width >= 14) + (display_width >= 23) + (display_width >= 28) + (display_width >= 31)
	
		// Scales based on display size:
		// 14in		2x
		// 23in		3x
		// 28in		4x
		// 31in		5x
		// Above	6x
	}

	set_font(fonts[ clamp(size-1, 0, array_length(fonts)-1) ])
}

set_font = function(font) {
	self.font = font
	prev_font = font
	consistent_spacing = font_has_consistent_kerning(font)
}

prev_font = -1

run_in_embed = false
char_pos_arg = {}

include_builtin_functions = true
include_console_functions = false

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

_col = 0

mouse_char_pos = false

elements = ds_create(ds_type_list, "elements")

macro_list = -1
method_list = -1
asset_list = -1
instance_variables = []
scope_variables = []
lite_suggestions = -1
suggestions = -1

console_macros = {}

builtin_excluded = []
autofill = {}

DOCK = {}
TEXT_BOX = {}
BAR = {}
OUTPUT = {}
SCROLLBAR = {}
AUTOFILL = {}
CHECKBOX = {}
WINDOW = {}
COLOR_PICKER = {}
CTX_MENU = {}
CTX_STRIP = {}
SLIDER = {}
SEPARATOR = {}
CD_BUTTON = {}
MEASURER = {}
DOC_STRIP = {}

keyboard_scope = noone

color_schemes = {}
cs_index = cs_greenbeans
step = 0

identifiers = {
	r: dt_real,
	s: dt_string,
	a: dt_asset,
	v: dt_variable,
	m: dt_method,
	i: dt_instance,
	o: dt_instance,
	c: dt_color,
}

event_commands = {
	step:	  [],
	step_end: [],
	draw:	  [],
	gui:	  [],
}

tags = {} with tags {
	add			= {color: gmcl_string_color, autofill: gmcl_autofill_old, func: function(command){add_console_element(gmcl_exec(command))}}
	include		= {color: console_include_tag_color, autofill: noscript, func: console_include}
	
	step		= {color: gmcl_string_color, autofill: gmcl_autofill_old, func: function(command){event_command_add("step", command)}}
	step_end	= {color: gmcl_string_color, autofill: gmcl_autofill_old, func: function(command){event_command_add("step_end", command)}}
	draw		= {color: gmcl_string_color, autofill: gmcl_autofill_old, func: function(command){event_command_add("draw", command)}}
	gui			= {color: gmcl_string_color, autofill: gmcl_autofill_old, func: function(command){event_command_add("gui", command)}}
}

gui_mouse_x = gui_mx
gui_mouse_y = gui_my

birdcheck()

variables = {}
console_key = vk_tilde

commands = -1

show_hidden_commands = false
show_hidden_args = false

text_outline = 8

tag_sep = " "

autofill_from_float = false

force_body_solid = false

right_mb = false

//these are just for the help command
is_this_the_display = "it sure is!"
checkboxes_like_this_one = false

prev_exception = {longMessage: "No errors yet! Yay!!"}

console_string = ""

object = noone  //object in scope

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

j = bird_mode_

color_string = []
command_log = ds_create(ds_type_list, "command_log")
error_log = ds_create(ds_type_list, "error_log")

command_colors = true

O1 = ""
O2 = ""
O3 = ""
O4 = ""
O5 = ""

cs_template = cs_greenbeans
executing = false

command_order = -1

startup = -1 + gmcl_initialize_on_startup
initialized = false
can_run = false
enabled = true

scale()
DISPLAY = {}

if gmcl_initialize_on_startup event_perform(ev_step, ev_step_end)