
function help(){

return format_output([
	"Help & info\n",
	{str: "Command list\n", scr: command_help, output: true},
	{str: "GMCL syntax\n", scr: noscript, output: true},
	{str: "Videos\n\n", scr: console_videos, output: true},
	
	"Options\n",
	{str: "General settings\n", scr: console_settings, output: true},
	{str: "Color schemes\n\n", scr: color_scheme_settings, output: true},
	
	"Other stuff\n",
	{str: "Say a nice thing!\n", scr: nice_thing, output: true},
	{str: "Github page", scr: url_open, arg: "https://github.com/Epsiilon2048/gms-script-console"}," [link]\n",
	{str: "Credits\n\n", scr: Epsii, output: true},
	
	{str: "Help menu", col: "embed_hover"}
], true)
}



function command_help(_command){ with o_console {

var elements = []
var text = []

if is_undefined(_command)
{
	var nl = ""
	var cat_name = ""
	
	for(var i = 0; i <= ds_list_size(command_order)-1; i++)
	{	
		var c = command_order[| i].str
		var last = i == ds_list_size(command_order)-1
		
		if command_order[| i].cat or last
		{
			if last or not command_order[| i].hidden or show_hidden_commands 
			{
				if array_length(text)
				{
					var dock = new_console_dock(cat_name, new_embedded_text(text))
					dock.draw_outline = false
					dock.condensed = true
					array_push(elements, dock)
				}
				
				cat_name = c
				text = []
				nl = ""
			}
		}
		else
		{
			var _hidden = variable_struct_exists_get(commands[? c], "hidden", false)
		
			if show_hidden_commands or not _hidden
			{
				array_push(text, {str: nl+"- "+c, scr: command_help, arg: c})
			}
			nl = "\n"
		}
	}
	
	return new element_container(elements, , "Commands")
}
else
{
	var command = commands[? _command]
	
	var has_hidden_args = variable_struct_exists(command, "hiddenargs")
	
	var _hidden		= variable_struct_exists_get(command, "hidden",  false)
	var _args		= variable_struct_exists_get(command, "args",	 [])
	var _optargs	= variable_struct_exists_get(command, "optargs", [])
	var _hiddenargs = show_hidden_args ? variable_struct_exists_get(command, "hiddenargs", []) : []
	var _moreargs	= variable_struct_exists_get(command, "moreargs", false)
	
	var hiddentext	= _hidden ? "{hidden} " : ""
	var argtext = "("

	for(var i = 0; i <= array_length(_args)-1; i++)		  argtext += _args[i]+", "
	for(var i = 0; i <= array_length(_optargs)-1; i++)	  argtext += "["+_optargs[i]   +"], "
	for(var i = 0; i <= array_length(_hiddenargs)-1; i++) argtext += "<"+_hiddenargs[i]+">, "
	
	if _moreargs argtext += "..."
	else if argtext != "(" argtext = string_delete(argtext, string_length(argtext), 1)
	argtext += ")"
	
	text = [
		{str: _command, col: dt_method},{str: argtext+"\n", col: dt_unknown},
		{str: hiddentext, col: dt_tag},command.desc+"\n\n",
	]
	
	if has_hidden_args array_push(text, 
		{cbox: "o_console.show_hidden_args", scr: command_help, arg: _command, output: true}," Show hidden arguments\n\n"
	)
	
	array_push(text, 
		{str: "Help menu", scr: help, output: true}," / ",{str: "Commands", scr: command_help, output: true}," / ",{str: _command, col: "embed_hover"}
	)
}

return format_output(text, true, command_help, "Command list")
}}


function Epsii(){

return format_output([
	"This console was developed by Epsii, with help from the \nGMS community\n\n",
	
	"[links] ",{str: "Twitter",	scr: url_open, arg: "https://twitter.com/pepsiilon"}," - ",{str: "Youtube",	scr: url_open, arg: "https://www.youtube.com/channel/UCA4znMVFR0P0V6ZitJhi2bA"}," - ",{str: "Github",		scr: url_open, arg: "https://github.com/Epsiilon2048"},"\n\n"+

	"With scripts from:\n",
	{str: "GMLscripts.com",	scr: url_open, arg: "https://GMLscripts.com/"}," / Schreib & xot (",{str: "dec_to_hex", scr: url_open, arg: "https://www.gmlscripts.com/script/dec_to_hex"},", ",{str: "hex_to_dec", scr: url_open, arg: "https://www.gmlscripts.com/script/hex_to_dec"},", ",{str: "rgb_to_hex", scr: url_open, arg: "https://www.gmlscripts.com/script/rgb_to_hex"},")\n\n",
	
	"Thank you so much for your interest and support!\n\n",
	
	{str:"Help menu", scr: help, output: true}," / ",{str: "Credits", col: "embed_hover"}
], true, Epsii)
}