
function initialize_bar_and_output(){ with o_console {

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
}}