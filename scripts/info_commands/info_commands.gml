


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
	for(var i = 0; i <= ds_list_size(command_order)-1; i++)
	{
		var c = command_order[| i].str
		
		if command_order[| i].cat and (not command_order[| i].hidden or show_hidden_commands)
		{
			array_push(text, c+"\n")
		}
		else
		{
			var _hidden = variable_struct_exists_get(commands[? c], "hidden", false)
		
			if show_hidden_commands or not _hidden
			{
				array_push(text, {str: " "+c+"\n", scr: command_help, arg: c, output: true})
			}
		}
	}
	array_push(text, "\nClick on a command for usage!")
}
else
{
	var command = commands[? _command]
	
	var _hidden		= variable_struct_exists_get(command, "hidden",  false)
	var _args		= variable_struct_exists_get(command, "args",	 [])
	var _optargs	= variable_struct_exists_get(command, "optargs", [])
	var _hiddenargs = show_hidden_args ? variable_struct_exists_get(command, "hiddenargs", []) : []
	
	var hiddentext	= _hidden ? " {hidden} " : " "
	var argtext = ""
	
	for(var i = 0; i <= array_length(_args)-1; i++)		  argtext += "<"+_args[i]      +"> "
	for(var i = 0; i <= array_length(_optargs)-1; i++)	  argtext += "["+_optargs[i]   +"] "
	for(var i = 0; i <= array_length(_hiddenargs)-1; i++) argtext += "("+_hiddenargs[i]+") "
	
	text = [{str:"[COMMAND]", scr: command_help, output:true},{str:" "+_command, col: dt_method},hiddentext+argtext+"- "+command.desc]
}

return format_output(text, true, command_help)
}}




function syntax_help(){ with o_console {
	
return format_output([
	"Basic GMCL syntax\n\n"+
	
	"Setting scope:     ",{str:"instance",col: dt_instance},"\n"+
	"Getting variables: ",{str:"instance",col: dt_instance},{str:".",col: dt_unknown},{str:"variable",col: dt_variable},"\n"+
	"Setting variables: ",{str:"instance",col: dt_instance},{str:".",col: dt_unknown},{str:"variable",col: dt_variable},{str:" value",col: dt_unknown},"\n"+
	"Running methods:   ",{str:"method",col: dt_method},{str:" argument0",col: dt_unknown},{str:" argument1 (...)",col: dt_unknown},"\n"+
	"Changing room:     ",{str:"room",col:"room"},"\n\n"+
	
	"Notes\n"+
	"- Multiple commands can be run in a single line when separated by semi-colons (;)\n"+
	"- While custom methods are automatically detected, builtin gml functions have to be\n"+
	"  manually added to the console_macros list\n"+
	"- Characters such as parenthesis and commas are treated the same as spaces. This means\n"+
	"  GML code is often compatible with GMCL."+
	"- If a method asks for a variable as an argument, it's likely intended to be a string\n\n",
	
	{str:"Help menu", scr: help, output: true}," / ",{str: "Basic syntax", col: "embed_hover"}," / ",{str: "Advanced syntax", scr: adv_syntax_help, output: true}," / ",{str: "Event tags", scr: tag_help, output: true}
], true, syntax_help)
}}



function adv_syntax_help(){
	
return format_output([
	"Advanced GMCL syntax\n\n"+
	
	"Datatype identifiers can be used for avoiding naming conflicts, instructing the compiler\n"+
	"on what to return, or for checking to see if a value works for a datatype.\n\n"+
	
	"Supported identifiers: (",{s:"r",col: dt_real},")eal - (",{s:"s",col: dt_string},")tring - (",{s:"a",col: dt_asset},")sset - (",{s:"v",col: dt_variable},")ariable - (",{s:"m",col: dt_method},")ethod - (",{s:"i",col: dt_instance},")nstance\n\n"+
	
	"(just a couple) use cases:\n"+
	"- Writing a variable as a string, but retaining the text colors to make sure it's correct\n"+
	"  ",{s:"s/",col: dt_string},{s:"instance",col: dt_instance},{s:".",col: dt_string},{s:"variable",col: dt_variable}," -> ",{s:"\"instance.variable\"\n\n",col: dt_string},
	
	"- Checking if an instance of an object or ID exists\n"+
	"  ",{s:"i/",col: dt_instance},{s:"object_with_no_instance",col: dt_unknown}," - ",{s:"i/object_with_instance\n\n",col: dt_instance},
	
	"- Avoiding a naming conflict between a console macro and instance variable\n"+
	"  ",{s:"console_macro",col: dt_instance}," - ",{s:"v/console_macro\n\n",col: dt_variable},
	
	{str:"Help menu", scr: help, output: true}," / ",{str: "Basic syntax", scr: syntax_help, output: true}," / ",{str: "Advanced syntax", col: "embed_hover"}," / ",{str: "Event tags", scr: tag_help, output: true}
], true, adv_syntax_help)
}


function tag_help(){

return format_output([
	"Compiler instructions inform the compiler where to send the command. Currently, these are\n"+
	"only used for event tags.\n\n"+
	
	"Event tags are used to run console commands during events, rather than when it's run.\n\n"+
	
	"An example:\n",
	{s:"#draw ",col: dt_tag},{s:"draw_line ",col: dt_method},{s:"0 0 ",col: dt_real},{s:"mouse_x mouse_y\n\n",col: dt_variable},
	
	"This command would be run in every draw event, drawing a line to the mouse position.\n"+
	"Note you can run multiple commands in these events by using semi-colons (;).\n"+
	
	"Supported events are step, step_end, draw, and draw_gui.\n\n",
	
{str:"Help menu", scr: help, output: true}," / ",{str: "Basic syntax", scr: syntax_help, output: true}," / ",{str: "Advanced syntax", scr: adv_syntax_help, output: true}," / ",{str: "Event tags", col: "embed_hover"}
], true, tag_help)
}


function console_window_help(){

return format_output([
	"The Window\n"+
	"- Shows static strings.\n"+
	"- If it's enabled in settings, you can click on the output to quickly set the window to it.\n"+
	"- Can be very helpful for keeping notes or navigating menus.\n"+
	"Syntax: ",{str:"window ",col: dt_method},{str:"value",col: dt_unknown},"\n"+
	"Commands: ",{str:"window",col: dt_method},", ",{str:"window_reset_pos",col: dt_method},"\n\n"+

	"The Display\n"+
	"- Displays variables and their values.\n"+
	"- Remember, though the argument references a variable, make sure the variable name is a string.\n"+
	"Syntax: ",{str:"display ",col: dt_method},{str:"\"object.variable\"",col: dt_string},"\n"+
	"Commands: ",{str:"display",col: dt_method},", ",{str:"display_clear",col: dt_method},", ",{str:"display_reset_pos",col: dt_method},", ",{str:"display_all",col: dt_method},"\n\n"+
	
	"You can drag windows from their sidebar, and collapse them by clicking it.\n\n"+
	
	"Click to show ",{str: "Window", scr: window, arg: "This is the Window!"}, " - ",{str: "Display", scr: display, arg: "o_console.is_this_the_display"},
], true, console_window_help)
}




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
		array_push(builtin, {str: "\n "+cs_list[i], scr: color_scheme, arg: cs_list[i]})
	}
	else
	{
		array_push(notbuiltin, {str: "\n "+cs_list[i], scr: color_scheme, arg: cs_list[i]})
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