
function event_command_add(event, command){
	
array_push(o_console.event_commands[$ event], gmcl_compile(command))
return "Added command to "+event+" event"
}