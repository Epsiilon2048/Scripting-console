
function initialize_console(){

if not console_object_exists
{
	show_debug_message("Couldn't find console object in assets!")
	return undefined
}

if not instance_exists(o_console) instance_create_depth(0, 0, 0, o_console)
if o_console.startup < 0 o_console.startup = 0
}