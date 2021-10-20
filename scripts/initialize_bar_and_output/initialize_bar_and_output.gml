
function initialize_bar_and_output(){

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
}