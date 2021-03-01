
function command_help(_command){ with o_console {
	
var text = []

if is_undefined(_command)
{
	for(var i = 0; i <= array_length(commands)-1; i++)
	{
		var _hidden = variable_struct_exists_get(commands[i], "hidden", false)
		
		if show_hidden_commands or not _hidden
		{
			var len = array_length(text)
		
			text[len] = "- "
			text[len+1] = {str: commands[i].scr, scr: command_help, arg: commands[i].scr, output: true}
			text[len+2] = "\n"
		}
	}
	text[len+3] = "\nClick on a command for usage!"
}
else
{
	var index = -1
	
	for(var i = 0; i <= array_length(commands)-1; i++)
	{
		if commands[i].scr == _command
		{
			index = i
			break
		}
	}
	
	var command = commands[index]
	
	var _hidden		= variable_struct_exists_get(command, "hidden", false)
	var _args		= variable_struct_exists_get(command, "args",		[])
	var _optargs	= variable_struct_exists_get(command, "optargs",	[])
	var _hiddenargs = show_hidden_args ? variable_struct_exists_get(command, "hiddenargs", []) : []
	
	var hiddentext	= _hidden ? " {hidden} " : " "
	var argtext = ""
	
	for(var i = 0; i <= array_length(_args)-1; i++)		  argtext += "<"+_args[i]      +"> "
	for(var i = 0; i <= array_length(_optargs)-1; i++)	  argtext += "["+_optargs[i]   +"] "
	for(var i = 0; i <= array_length(_hiddenargs)-1; i++) argtext += "("+_hiddenargs[i]+") "
	
	text = {__embedded__: true, o: [
		{str:"[COMMAND]", scr: command_help, output:true},{str:" "+command.scr, col:colors.script},hiddentext+argtext+"- "+command.desc
	]}
}

return text
}}