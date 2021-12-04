
function initialize_bar_and_output(){ with o_console {

with BAR {
	
	enabled = false
	
	char_height = 23
	
	outline_width = 1.4
	docked_width = 1000
	
	x = undefined	// These are for placing the bar somewhere else
	y = undefined
	width = undefined	

	left = 0
	top	= 0
	right = 0
	bottom = 0
	
	bar_right = 0
	sidetext_left = 0
	sidetext_string = "noone"

	height = 17
	sep = 2.7
	win_dist = 50
	
	text_dist = 18
	sidebar_width = 3
	
	sidebar_circle = false
	sidebar_animation = 0
	sidebar_lerp = .48
	sidebar_overshoot_mult = .13
	sidebar_overshot = false
	sidebar_overshoot_lerp = sidebar_lerp*.7
	sidebar_height_dampner = .6
	sidebar_surface = -1
	
	mouse_on = false

	text_box = new Console_text_box() with text_box
	{
		initialize()
		variable = "o_console.console_string"
		value = ""
		draw_name = false
		att.draw_box = false
		color_method = gmcl_string_color
		autofill_method = gmcl_autofill_old
		att.exit_with_enter = false
		att.set_variable_on_input = true
		att.allow_scoped_exinput = true
	}
	
	get_input = console_bar_inputs
	draw = draw_console_bar
}

with OUTPUT {
	
	docked = false
	
	text = new Embedded_text()
	text.set()
	
	dock = new Console_dock()
	dock.initialize()
	dock.set(text)
	dock.name = "Console output"
	dock.draw_name_bar = false

	fade_time = 6 //seconds
	fade_step = 0
	alpha = 0
	alpha_dec = .04
	
	mouse_on = false
	has_embed = false
	body = false
	
	get_input = console_output_inputs
	draw = draw_console_output
	
	dock.get_ctx_elements = function(){
		return [
			new_ctx_text("Forward to new window", function(){
				add_console_element(new_console_dock("Dock", dock))
				output_set("Forwarded output to new window")
			})
		]
	}
}

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

add_console_element(bar_dock)
add_console_element(BAR)
add_console_element(OUTPUT)

BAR.text_box.enabled = not soft_init
OUTPUT.dock.enabled = not soft_init

var greetings = [
	"I hope you're having a wonderful day!",
	"Afternoon! Or morning! Or whenever!",
	"Howsya day going?",
	"Hiya!",
	"Ay how's it goin?",
	"Remember to take breaks from time to time!",
	"yooooooo sup",
]

output_set(format_output( greetings[ round( current_time mod array_length(greetings) ) ] ))
}}