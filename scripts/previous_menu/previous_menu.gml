
function previous_menu(){

var _output = "No previous menu"

if script_exists(o_console.Output.tag_prev_menu) 
{
	_output = o_console.Output.tag_prev_menu()
	output_set(_output)
}

return _output
}