
return [
	"help",
	"command_help",
	"syntax_help",
	"console_window_help",
	"embedded_text_help",
	"console_settings",
	"color_scheme_settings",
	"Epsiilon",
	"console_videos",
	"nice_thing",
]

function help(){

return format_output([
	"Help & info\n",
	{str: "Basic syntax & usage", scr: syntax_help, output: true},
	{str: "\nCommand list", scr: command_help, output: true},
	{str: "\nConsole windows", scr: console_window_help, output: true},
	{str: "\nEmbedded text", scr: embedded_text_help, output: true},
	{str: "\nVideos", scr: console_videos, output: true},
	
	"\n\nOptions\n",
	{str: "General settings", scr: console_settings, output: true},
	{str: "\nColor schemes", scr: color_scheme_settings, output: true},
	
	"\n\nOther stuff\n",
	{str: "Instances in room", scr: roomobj, output: true},
	{str: "\nSay a nice thing!", scr: nice_thing, output: true},
	{str: "\nGithub page", scr: url_open, arg: "https://github.com/Epsiilon2048/gms-script-console"}," [link]",
	{str: "\nCreator info", scr: Epsiilon, output: true},
	
	"\n\nNote, you can press [shift+console_key]\n"+
	"to quickely return to this menu!"
], true, help)
}




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
	
	text = [
		{str:"[COMMAND]", scr: command_help, output:true},{str:" "+command.scr, col:colors.method},hiddentext+argtext+"- "+command.desc
	]
}

return format_output(text, true, command_help)
}}




function syntax_help(){ with o_console {
	
return format_output([ //note that this only takes the colors from the current color scheme; doesn't change with it
	"Basic GMCL syntax\n\n"+
	
	"Setting scope:     ",{str:"instance",col:colors.instance},"\n"+
	"Getting variables: ",{str:"instance",col:colors.instance},{str:".",col:colors.plain},{str:"variable",col:colors.variable},"\n"+
	"Setting variables: ",{str:"instance",col:colors.instance},{str:".",col:colors.plain},{str:"variable",col:colors.variable},{str:" value",col:colors.plain},"\n"+
	"Running methods:   ",{str:"method",col:colors.method},{str:" argument0",col:colors.plain},{str:" argument1 (...)",col:colors.plain},"\n"+
	"Changing room:     ",{str:"room",col:colors[$ dt_room]},"\n\n"+
	
	"Notes\n"+
	"- Multiple commands can be run in a single line when separated by semi-colons (;)\n"+
	"- While custom methods are automatically detected, builtin gml functions have to be\n"+
	"  manually added to the console_macros list\n"+
	"- If a method asks for a variable as an argument, it's likely intended to be a string\n\n"+
	
	{str: "Advanced syntax & naming conflicts", scr: adv_syntax_help, output: true},
], true, syntax_help)
}}


function adv_syntax_help(){ with o_console {
	
//var o = [
//	"Advanced GMCL syntax\n\n"+
//	
//	"Datatype identifiers are useful primarily for avoiding naming conflicts.\n"+
//	"\n"
//])
}}



function console_window_help(){ with o_console {

return format_output([
	"The Window\n"+
	"- Shows static strings.\n"+
	"- If it's enabled in settings, you can click on the output to quickly set the window to it.\n"+
	"- Can be very helpful for keeping notes or navigating menus.\n"+
	"Syntax: ",{str:"window ",col:colors.method},{str:"value",col:colors.plain},"\n"+
	"Commands: ",{str:"window",col:colors.method},", ",{str:"window_reset_pos",col:colors.method},"\n\n"+

	"The Display\n"+
	"- Displays variables and their values.\n"+
	"- Remember, though the argument references a variable, make sure the variable name is a string.\n"+
	"Syntax: ",{str:"display ",col:colors.method},{str:"\"object.variable\"",col:colors.string},"\n"+
	"Commands: ",{str:"display",col:colors.method},", ",{str:"displayds",col:colors.method},", ",{str:"display_clear",col:colors.method},", ",{str:"display_reset_pos",col:colors.method},", ",{str:"display_all",col:colors.method},", ",{str:"display_toggle_objects",col:colors.method},"\n\n"+
	
	"You can drag windows from their sidebar, and collapse them by clicking it.\n\n"+
	
	"Click to show ",{str: "Window", scr: window, arg: "This is the Window!"}, " - ",{str: "Display", scr: display, arg: "o_console.is_this_the_display"},
], true, console_window_help)
}}




function embedded_text_help(){ with o_console {

return format_output([
	"Text embedding is used everywhere for menus and interactive elements.\n\n"+
	
	"It's used to change the color of or bind scripts to text, and it also\n"+
	"supports checkboxes ",{checkbox:"o_console.checkboxes_like_this_one", str: " like this one"}," which can manipulate boolean variables.\n\n"+
	
	"However it is quite costly, and all settings can be manually edited\n"+
	"from the console.\n\n"+
	
	"As it stands, when embedding is disabled, all these menus are unchanged\n"+
	"in content, making them very difficult to navigate.\n"+
	"This will be fixed soon hopefully.\n\n"+
	
	"Note that the console input colors are not embeds.\n\n"+

	"Embeds can be disabled in ",{str: "general settings", scr: console_settings, output: true},"."
], true, embedded_text_help)
}}




function console_settings(){ with o_console {
	
return format_output([
	{str: "", checkbox: "o_console.collapse_windows"}, " Collapse windows by clicking sidebar\n\n",
	{str: "", checkbox: "o_console.embed_text"}, " Text embedding - WILL MAKE THIS WINDOW UNUSABLE IF DISABLED\n",
	{str: "", checkbox: "o_console.window_embed_text"}, " Window text embedding\n\n",
	{str: "", checkbox: "o_console.output_as_window", func: function(){o_console.Output_window.reset_pos()}}, " Output as window\n\n",
	{str: "", checkbox: "o_console.output_set_window"}, " Click output to set window\n",
	{str: "", checkbox: "o_console.force_output"}, " Always show output\n",
	{str: "", checkbox: "o_console.force_output_body"}, " Always show output background\n",
	{str: "", checkbox: "o_console.force_output_embed_body"}, " Show output background when it displays embedded text\n\n",
	
	{str: "", checkbox: "o_console.show_hidden_commands"}, " Show hidden commands in command help menu\n",
	{str: "", checkbox: "o_console.show_hidden_args"}, " Show hidden args in command help menu\n\n",
	
	{str: "Color schemes", scr: color_scheme_settings, output: true},"\n\n",

	{str: "Reset console\n", scr: reset_obj, arg: o_console},
	{str: "Destroy console", scr: destroy_console},
], true, console_settings)
}}
	

	
	
function color_scheme_settings(){ with o_console {

var cs_list		= variable_struct_get_names(color_schemes)
var text		= []
var builtin		= []
var notbuiltin	= []

for(var i = 0; i <= array_length(cs_list)-1; i++)
{
	if variable_struct_exists_get(color_schemes[$ cs_list[i]], "__builtin__", false)
	{
		array_push(builtin, {str: "\n "+cs_list[i], scr: color_scheme, arg: cs_list[i], output: true})
		
		if cs_list[i] == cs_index array_push(builtin, " - current")
	}
	else
	{
		array_push(notbuiltin, {str: "\n "+cs_list[i], scr: color_scheme, arg: cs_list[i], output: true})
		
		if cs_list[i] == cs_index array_push(notbuiltin, " - current")
	}
}

array_push(text, "Default")
array_copy(text, 1, builtin, 0, array_length(builtin))

if array_length(notbuiltin) > 0 
{
	array_push(text, "\n\nOther")
	array_copy(text, array_length(builtin)+2, notbuiltin, 0, array_length(notbuiltin))
}

array_push(text, 
	"\n\n", {str: "", checkbox: "o_console.rainbow"}, " gamer mode"+
	"\n\n",
	{str: "Regenerate color schemes", scr: initialize_color_schemes},
	
	"\n\nClick on a color scheme to try it out!"
)

return format_output(text, true, color_scheme_settings)
}}
	
	
	
	
function Epsiilon(){

return format_output([
	"This scripting console was developed by Epsiilon2048, with help from the \nGMS community\n\n",
	
	"[links] ",
	{str: "Twitter",	scr: url_open, arg: "https://twitter.com/epsiilon2048"}," - ",
	{str: "Youtube",	scr: url_open, arg: "https://www.youtube.com/channel/UCA4znMVFR0P0V6ZitJhi2bA"}," - ",
	{str: "Github",		scr: url_open, arg: "https://github.com/Epsiilon2048"},
	
	"\n\nThank you so much for your interest and support! My only hope is that someone\ncan make some use out of this little project of mine."
], true, Epsiilon)
}
	
	
	
	
function console_videos(){ with o_console {

return format_output([
	"Video explaining the new updates soon (hopefully)!\n\n"+
	"[links]\n",
	{str: "1.0 Demonstration", scr: url_open, arg:"https://www.youtube.com/watch?v=DePksU_vjRY&t=2s"}," (quite old)\n",
	{str: "1.1 Colors", scr: url_open, arg:"https://www.youtube.com/watch?v=rz2lvfYwHyQ"},
	{str: "\n1.2 Color schemes", scr: url_open, arg: "https://youtu.be/QCn5csFYYgA"}
], true, console_videos)
}}




function nice_thing(){

//uhhhh hi person looking into this code, hope you're doing well

static _nice_things = [
	"You're super cool!",
	"Hope you finish whatever you're working on!",
	"You're simply amazin'",
	"I hope you're having a wonderful day!",
	"Drink some water!!",
	"You are a beautiful person!",
	"Remember to take breaks from time to time!",
	"yooooo you're sick as hell",
]

static prev_nice_thing = ""

var _nice_thing = ""

do _nice_thing = _nice_things[irandom(array_length(_nice_things)-1)]
until _nice_thing != prev_nice_thing

prev_nice_thing = _nice_thing

if o_console.run_in_embed and o_console.Output.tag != -1
{
	return format_output([{str: "<back>", scr: previous_menu, output: true}, " "+_nice_thing], true, nice_thing)
}
else
{
	return format_output(_nice_thing, false, nice_thing)
}
}