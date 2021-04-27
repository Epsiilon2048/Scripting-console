
function command_doc_add(name, details){ with o_console {

commands[? name] = details
}}

function command_doc(command){ with o_console {

if ds_map_exists(commands, command)
{
	var _command = commands[? command]
	
	var _hidden		= variable_struct_exists_get(_command, "hidden",  false)
	var _args		= variable_struct_exists_get(_command, "args",	 [])
	var _optargs	= variable_struct_exists_get(_command, "optargs", [])
	var _hiddenargs = show_hidden_args ? variable_struct_exists_get(_command, "hiddenargs", []) : []
	var _moreargs	= variable_struct_exists_get(_command, "moreargs", false)
	
	var argtext = "("

	for(var i = 0; i <= array_length(_args)-1; i++)		  argtext += _args[i]+","
	for(var i = 0; i <= array_length(_optargs)-1; i++)	  argtext += "["+_optargs[i]   +"],"
	for(var i = 0; i <= array_length(_hiddenargs)-1; i++) argtext += "<"+_hiddenargs[i]+">,"
	
	if _moreargs argtext += "..."
	else if argtext != "(" argtext = string_delete(argtext, string_length(argtext), 1)
	argtext += ")"

	return command+argtext
}
else if ds_map_exists(deprecated_commands, command)
{
	var dep = deprecated_commands[? command]
	var str = "Deprecated command"
	
	if variable_struct_exists(dep, "newname")	str += " - it has been replaced with "+dep.newname
	if variable_struct_exists(dep, "note")		str += " - "+dep.note
	if variable_struct_exists(dep, "ver")		str += " - removed in "+dep.ver
	
	return str
}
else
{
	return "Command "+command+" does not exist"
}
}}