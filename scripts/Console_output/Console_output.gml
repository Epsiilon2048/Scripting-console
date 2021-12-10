
function console_output_inputs(){ with o_console.OUTPUT {

docked = o_console.BAR.dock.enabled
if docked and not run_in_dock return undefined

dock.get_input()

left = dock.left
top = dock.top
right = dock.right
bottom = dock.bottom
}}
	
	
	
function draw_console_output(){ with o_console {

var ot = OUTPUT

if ot.docked and not ot.run_in_dock return undefined

if not ot.dock.dragging ot.dock.draw()
}}