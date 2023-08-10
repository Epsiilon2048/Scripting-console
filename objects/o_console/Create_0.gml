
birdcheck()

if instance_number(o_console) > 1
{
	show_debug_message("Attempted to create another console object when one already existed!")
	instance_destroy(id, false)
	exit
}

console_exists = true

run_in_console = false
clicking_on_console = false
mouse_on_console = false

element_dock = {set: noscript}

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
		var width = gui_width
		size = 1 + (width >= 512) + (width >= 1280) + (width > 1920) + (width > 2560)
	}

	set_font(fonts[ clamp(size-1, 0, array_length(fonts)-1) ])
}

set_font = function(font) {
	self.font = font
	prev_font = font
	consistent_spacing = font_is_monospace(font)
}

prev_font = -1

run_in_embed = false
char_pos_arg = {}

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
SLIDER = {}
SEPARATOR = {}
CD_BUTTON = {}
DOC_STRIP = {}
DISPLAY = {}

keyboard_scope = noone

color_schemes = {}
cs_index = cs_greenbeans
step = 0
ge = bird_mode_

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

tags = {} with tags {
	add			= {color: gmcl_string_color, autofill: gmcl_autofill_new, func: function(command){add_console_element(gmcl_exec(command))}}
	include		= {color: /*console_include_tag_color*/gmcl_string_color, autofill: noscript, func: console_include}
}

birdcheck()

variables = {}
console_key = vk_tilde

commands = -1

show_hidden_commands = false
show_hidden_args = false

tag_sep = " "

autofill_from_float = false

force_body_solid = false

prev_exception = {longMessage: "No errors yet! Yay!!"}

console_string = ""

object = noone  //object in scope

input_log = ds_create(ds_type_list, "input_log")
input_log_limit = 20
input_log_index = -1
input_log_save = ""

log = ds_create(ds_type_list, "log")

j = bird_mode_

command_log = ds_create(ds_type_list, "command_log")
error_log = ds_create(ds_type_list, "error_log")

cs_template = cs_greenbeans
executing = false

command_order = -1

startup = -1 + gmcl_initialize_on_startup
initialized = false
soft_init = true
can_run = false
enabled = true

auto_scale = true
prev_gui_size = gui_width*gui_height
variable_scope_list = []
variable_scope = noone

if gmcl_initialize_on_startup event_perform(ev_step, ev_step_end)