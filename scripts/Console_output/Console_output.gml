
function console_output_inputs(){ with o_console {
	
var ot = OUTPUT
	
if ot.docked and not ot.run_in_dock return undefined

//if output_as_window
//{
	ot.dock.draw_name = true
//}
//else
//{
//	ot.dock.draw_name = false
//	ot.dock.x = 0
//	ot.dock.y = 0
//}

ot.dock.get_input()

with OUTPUT
{
	left = ot.dock.left
	top = ot.dock.top
	right = ot.dock.right
	bottom = ot.dock.bottom
}
}}
	
	
	
function draw_console_output(){ with o_console {

var ot = OUTPUT

if ot.docked and not ot.run_in_dock return undefined

if not ot.dock.dragging ot.dock.draw()
}}