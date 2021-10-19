
if instance_number(o_console) > 1
{
	show_debug_message("Attempted to create another GMCL IDE object when one already existed!")
	instance_destroy()
	exit
}

#macro console_enabled o_console.enabled
#macro mouse_on_console o_console.mouse_on
#macro clicking_on_console o_console.clicking_on
#macro console_typing (o_console.keyboard_scope != noone)

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
	"switch_",			// Of the nintendo variety
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

keyboard_scope = noone

do_autofill = false

color_schemes = {}
cs_index = cs_greenbeans
embed_text = true
step = 0

index_functions()
index_assets()
initialize_console_macros()
initialize_color_schemes()
initialize_console_docs()
initialize_console_graphics(undefined)

identifiers = {
	r: dt_real,
	s: dt_string,
	a: dt_asset,
	v: dt_variable,
	m: dt_method,
	i: dt_instance,
	c: dt_color,
}

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

#macro gui_mx device_mouse_x_to_gui(0)
#macro gui_my device_mouse_y_to_gui(0)

#macro win_width  window_get_width()
#macro win_height window_get_height()

#macro gui_width  display_get_gui_width()
#macro gui_height display_get_gui_height()

#macro dt_real			"real"
#macro dt_string		"string"
#macro dt_undefined		"undefined"
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
#macro cs_gms2			"gms2"

#macro ctx_separator	"separator"

event_commands = {
	step:	  [],
	step_end: [],
	draw:	  [],
	gui:	  [],
}

gui_mouse_x = gui_mx
gui_mouse_y = gui_my

console_key = vk_tilde

show_hidden_commands = false
show_hidden_args = false

text_outline = 8

output_as_window = false
force_output = false
force_output_body = false //this sounds pretty yikesy thinking of it now
force_output_embed_body = true

autofill_from_float = false

force_body_solid = false

right_mb = false

//these are just for the help command
is_this_the_display = "it sure is!"
checkboxes_like_this_one = false

prev_exception = {longMessage: "No errors yet! Yay!!"}

var old_font = draw_get_font()
draw_set_font(font)

win_w = display_get_gui_width()
win_h = display_get_gui_height()

console_string = ""

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

startup = true
tb = ""
sc = 0


/*
var element_adjusting = new_console_dock("Element adjusting", [
	new_console_dock("Dock", [
		[new_scrubber("Outline", "con.DOCK.name_outline_width", .1)],
		["Border", new_scrubber("W", "con.DOCK.name_wdist", 1), new_scrubber("H", "con.DOCK.name_hdist", 1)],
		new_separator(),
		["Border", new_scrubber("W", "con.DOCK.element_wdist", 1),  new_scrubber("H", "con.DOCK.element_hdist", 1)],
		["Separation", new_scrubber("W", "con.DOCK.element_wsep", 1), new_scrubber("H", "con.DOCK.element_hsep", 1)],
		new_separator(),
		[new_scrubber("Base", "con.DOCK.dropdown_base", 1), new_scrubber("Hypotenuse", "con.DOCK.dropdown_hypotenuse", 1)],
		[new_scrubber("Border", "con.DOCK.dropdown_wdist", 1)],
	]),
	new_console_dock("Color picker", [
		new_scrubber("Outline", "con.COLOR_PICKER.outline", .1),
		new_scrubber("Border distance", "con.COLOR_PICKER.dist", 1),
		new_scrubber("Separation", "con.COLOR_PICKER.sep", 1),
		new_separator(),
		"Saturation/value square",
		new_scrubber("Square length", "con.COLOR_PICKER.svsquare_length", 1),
		new_scrubber("Dropper radius", "con.COLOR_PICKER.dropper_radius", 1),
		new_separator(),
		"Hue bar",
		new_scrubber("Bar width", "con.COLOR_PICKER.hstrip_width", 1),
		new_scrubber("Picker height", "con.COLOR_PICKER.hpicker_height", 1),
		new_separator(),
		"Color strip",
		new_scrubber("Strip height", "con.COLOR_PICKER.colorbar_height", 1),
	]),
	new_cd_button("Reset all", initialize_console_graphics)
])

*/
var bar_dock = new Console_dock() with bar_dock
{
	initialize()
	name = "Command line"
	allow_element_dragging = false
	set([
		other.BAR
	])
}
bar_dock.enabled = false
/*


var id_box = new_display_box("id", "id", false)
id_box.allow_printing = false
id_box.att.select_all_on_click = true

var index_box = new_display_box("Object", "object_index", false)
index_box.allow_printing = false
index_box.att = id_box.att

var x_scrubber = new_scrubber("x", "x", 1)
var y_scrubber = new_scrubber("y", "y", 1)
x_scrubber.att.scrubber_pixels_per_step = 1
y_scrubber.att.scrubber_pixels_per_step = 1

var var_name_text_box = new_text_box("Name", "__variable_add_name__")
var var_add_button = new_cd_button("+", noscript)
var var_explanation = new_cd_text("Enter a variable name to add!", undefined)

var var_name_text_box = new_text_box("Name", "__variable_add_name__")
with var_name_text_box
{
	association = var_name_text_box
	button = var_add_button
	draw_name = false
	initial_ghost_text = "Enter variable"
	allow_printing = false
	att.exit_with_enter = false
	att.length_min = string_length(initial_ghost_text)+5
	att.scoped_color = dt_variable
	
	__variable_add_name__ = ""

	color_method = function(text){
		var exists = variable_instance_exists(dock.association, text)
		button.can_click = exists
		return {text: text, colors: [{pos: string_length(text)+1, col: (exists ? dt_variable : "plain")}]}
	}
	
	enter_func = function(){
		button.released_script()
	}
}

with var_add_button
{
	text_box = var_name_text_box
	explanation_text = var_explanation
	can_click = false
	released_script = function(){
		
		explanation_text.enabled = false
		if variable_instance_exists(dock.association, text_box.text)
		{
			dock.insert_vertical(0, new_text_box(text_box.text, text_box.text))
			text_box.__variable_add_name__ = ""
		}
	}
}

var image_dock = new_console_dock("Image", [
	[new_scrubber("frame speed", "image_speed", .01)],
	[new_scrubber("frame", "image_index", 1)],
	new_separator(),
	[new_scrubber("x scale", "image_xscale", .1), new_scrubber("y scale", "image_yscale", .1)],
	[new_scrubber("angle", "image_angle", 1)],
	new_separator(),
	[new_color_box("color blend", "image_blend")],
	[new_scrubber("alpha", "image_alpha", .01)],
])
var movement_dock = new_console_dock("Movement", [
	[new_scrubber("speed", "speed", .1)], 
	[new_scrubber("direction", "direction", 1)], 
	[new_scrubber("friction", "friction", .1)], 
	[new_scrubber("hspeed", "hspeed", .1), new_scrubber("vspeed", "vspeed", .1)],
	new_separator(),
	[new_scrubber("gravity", "gravity", 1)],
	[new_scrubber("gravity direction", "gravity_direction", 1)],
])
var variable_dock = new_console_dock("Variables", [
	[var_add_button, var_name_text_box],
	new_separator(),
	[var_explanation],
])

image_dock.show = false
movement_dock.show = false
variable_dock.show = false

object_editor = new_console_dock("cool_thing", [
	[index_box, id_box],
	[x_scrubber, y_scrubber],
	[image_dock],
	[movement_dock],
	[variable_dock],
])
object_editor.association = cool_thing
object_editor.hide_all()
*/


var var_name_text_box = new_text_box("Name", "__variable_add_name__")
var var_add_button = new_cd_button("+", noscript)
var var_explanation = new_cd_text("Enter a variable name to add!", undefined)

var var_text_box = new_text_box("Variable", "__variable_add_var__") with var_text_box
{
	association = var_text_box
	button = var_add_button
	explanation_text = var_explanation
	draw_name = false
	initial_ghost_text = "variable"
	allow_printing = false
	att.exit_with_enter = false
	att.set_variable_on_input = false
	att.allow_scoped_exinput = false
	att.exit_with_enter = true
	att.length_min = string_length(initial_ghost_text)+12
	att.scoped_color = dt_variable

	__variable_add_var__ = ""

	color_method = function(text){
		var info = variable_string_info(text)
		button.can_click = info.exists and not (is_struct(info.value) and not (is_undefined(instanceof(info.value)) or instanceof(info.value) == "" or instanceof(info.value) == "weakref"))
		return gmcl_string_color(text, undefined)
	}
	
	autofill_method = function(command, char_pos){
		return gmcl_autofill_old(command, char_pos, {instance: true, assets: true, scope: true})
	}
	
	enter_func = function(){
		if text == "" return undefined
		__variable_add_var__ = ""
		var v = button.released_script()
		var constructor_object = v.exists and (is_struct(v.value) and not (is_undefined(instanceof(v.value)) or instanceof(v.value) == "" or instanceof(v.value) == "weakref")) 
		if not v.exists or constructor_object
		{
			explanation_text.enabled = true
			if constructor_object explanation_text.set("Cannot display; potential\nstack overflow")
			else explanation_text.set("Variable does not exist")
			explanation_text.color = dt_real
		}
	}
}

var type_text_box = new_text_box("Variable type", )

var scrubber_inc_text_box = new_value_box("Scrubber inc", )

with var_add_button
{
	var_box = var_text_box
	type_box = type_text_box
	scrubber_inc_box = scrubber_inc_text_box
	explanation_text = var_explanation
	can_click = false
	released_script = function(){
		explanation_text.enabled = false
		var variable = variable_string_info(var_box.text)
		if variable.exists and not (is_struct(variable.value) and not (is_undefined(instanceof(variable.value)) or instanceof(variable.value) == "" or instanceof(variable.value) == "weakref"))
		{
			var el
			
			switch asset_get_index(type_box.text)
			{
			default:
				if is_numeric(variable.value)		
				{
					var p = float_count_places(variable.value, 4)
					if p == 0 p = 1
					else p = 1/(10*float_count_places(variable.value, 4))
					el = new_scrubber(var_box.text, var_box.text, p)
				}
				else if is_string(variable.value)	el = new_text_box(var_box.text, var_box.text)
				else								el = new_display_box(var_box.text, var_box.text, true)
			break
			case new_text_box:
				el = new_text_box(var_box.text, var_box.text)
			break
			case new_scrubber:
				el = new_scrubber(var_box.text, var_box.text, scrubber_inc_box.value)
			break
			case new_display_box:
				el = new_display_box(var_box.text, var_box.text, true)
			break
			}
			
			dock.insert_vertical(0, el)
			var_box.__variable_add_name__ = ""
		}
		var_box.update_variable()
		
		return variable
	}
}

f = 0

color_thing = new Console_color_dock()
color_thing.initialize("o_bg.color", true, true, true, true, true)

DISPLAY = new_console_dock("Display",[
	[var_add_button, var_text_box],
	new_separator(),
	[var_explanation],
])
DISPLAY.allow_element_dragging = true
DISPLAY.hide_all()
/*
var bm_box = new_text_box("blendmode", "body_bm")
with bm_box
{
	att.length_min = string_length("subtract")
	att.select_all_on_click = true
	att.set_variable_on_input = false
	att.text_color = dt_real
	att.scoped_color = dt_real
	value_conversion = function(val){
		att.text_color = dt_real
		switch val
		{
			default: 
				att.text_color = "plain"
				return value
			case "normal": return bm_normal
			case "add": return bm_add
			case "subtract": return bm_subtract
		}
		
		set_boundaries()
	}
	
	update_variable = function(){

		var old_text = text
		value = o_console.colors.body_bm
		
		att.text_color = dt_real
		switch value
		{
			default: 
				text = "unknown" 
				att.text_color = "plain"
				break
			case bm_normal: text = "normal" break
			case bm_add: text = "add" break
			case bm_subtract: text = "subtract" break
		}
		
		if string_length(text) != string_length(old_text) set_boundaries()
	}
}

cs_editor = new_console_dock("Color scheme editor", [
	new_cd_checkbox("","0.f"),
	[new_console_dock("IDE colors", [
		new_color_box("Primary", "output"),
		new_separator(),
		[new_color_box("Body     ", "body"), new_color_box("Solid ", "body_real"), new_color_box("Accent", "body_accent")],
		[new_value_box("alpha    ", "body_alpha", true, .01, 4, 4, 0, 1, true, 2), new_value_box("alpha ", "body_real_alpha", true, .01, 1, infinity, 0, 1, true, 2)],
		[bm_box, new_value_box("outline  ", "bevel", true, 1, 1, 2, 0, 30, false, 0)],
		new_separator(),
		[new_color_box("Button", "embed"), new_color_box("Hovering", "embed_hover")],
		new_separator(),
		[new_color_box("Red  ", "red"),		new_color_box("Green", "green"),	new_color_box("Blue ", "blue")],
		[new_color_box("Black", "black"),	new_color_box("White", "white")],
	]),""],
	[new_console_dock("Text colors", [
		[new_color_box("Plain     ", "plain"),		new_color_box("Numeric   ", dt_real),	new_color_box("Asset     ", dt_asset),		new_color_box("Instance  ", dt_instance)],
		[new_color_box("String    ", dt_string),	new_color_box("Color     ", dt_color),	new_color_box("Built-in  ", dt_builtinvar),	new_color_box("Tag       ", dt_tag)],
		[new_color_box("Variable  ", dt_variable),	new_color_box("Script    ", dt_method),	new_color_box("Unknown   ", dt_unknown),	new_color_box("Deprecated", dt_deprecated)],
	])],
])
cs_editor.association = o_console.colors
cs_editor.hide_all()

g = ""
ctb = new_text_box("Tester","0.g")

tb_editor = new_console_dock("Advanced text box editor",[
	[new_display_box("Text", "text", false)],
	[new_display_box("Value", "value", false)],
	[new_display_box("Added float places", "added_float_places", false)],
	
	new_separator(),
	[new_text_box("Name", "name")],
	[new_text_box("Ghost text", "initial_ghost_text")],
	[new_text_box("Variable", "variable")],
	[new_text_box("Ghost text", "initial_ghost_text")],
	["Enabled",new_cd_checkbox(undefined,"enabled")],
	["Show name",new_cd_checkbox(undefined,"draw_name")],
	["Instant update",new_cd_checkbox(undefined,"instant_update")],
	["Include in dock printing",new_cd_checkbox(undefined,"allow_printing")],

	new_console_dock("Shared Attributes", [
		["User input",new_cd_checkbox(undefined,"att.allow_input")],
		["Update with variable",new_cd_checkbox(undefined,"att.allow_exinput")],
		["Update with variable when scoped",new_cd_checkbox(undefined,"att.allow_scoped_exinput")],
		["Allow alpha characters",new_cd_checkbox(undefined,"att.allow_alpha")],
		["Draggable",new_cd_checkbox(undefined,"att.allow_dragging")],
		["Select all on click",new_cd_checkbox(undefined,"att.select_all_on_click")],
		["Set variable on input",new_cd_checkbox(undefined,"att.set_variable_on_input")],
		["Draw box",new_cd_checkbox(undefined,"att.draw_box")],
		["Length between",new_scrubber(undefined,"att.length_min", 1),"and",new_scrubber(undefined,"att.length_max", 1)],
		["Lock text length",new_cd_checkbox(undefined,"att.lock_text_length")],
	
		[new_scrubber("Float places","att.float_places", 1)],
		["Clamp between",new_scrubber(undefined,"att.value_min", 1),"and",new_scrubber(undefined,"att.value_max", 1)],
		[new_scrubber("Arrow key step","att.incrementor_step", .5)],
		["Is scrubber",new_cd_checkbox(undefined, "att.scrubber")],
		[new_scrubber("Scrubber step","att.scrubber_step", .5)],
		[new_scrubber("Scrubber pixels per step","att.scrubber_pixels_per_step", 1)],
	]),
])
tb_editor.association = ctb
*/

//add_console_element(ctb)
//add_console_element(tb_editor)
//add_console_element(object_editor)
//add_console_element(cs_editor)
//add_console_element(element_adjusting)
//add_console_element(bar_dock)
add_console_element(BAR)
add_console_element(OUTPUT)
add_console_element(DISPLAY)
//add_console_element(color_thing)
DISPLAY.enabled = false
BAR.enabled = false