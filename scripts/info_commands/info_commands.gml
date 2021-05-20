
function help(){

return format_output([
	"Help & info\n",
	{str: "GMCL syntax\n", scr: syntax_help, output: true},
	{str: "Command list\n", scr: command_help, output: true},
	{str: "Shortcuts\n", scr: shortcut_help, output: true},
	{str: "Console windows\n", scr: console_window_help, output: true},
	{str: "Videos\n\n", scr: console_videos, output: true},
	
	"Options\n",
	{str: "General settings\n", scr: console_settings, output: true},
	{str: "Color schemes\n", scr: color_scheme_settings, output: true},
	{str: "Color scheme editor\n\n", scr: color_scheme_editor, output: true},
	
	"Other stuff\n",
	{str: "Say a nice thing!\n", scr: nice_thing, output: true},
	{str: "Github page", scr: url_open, arg: "https://github.com/Epsiilon2048/gms-script-console"}," [link]\n",
	{str: "Credits\n\n", scr: Epsiilon, output: true},
	
	{str: "Help menu", col: "embed_hover"}
], true, help)
}




function command_help(_command){ with o_console {
	
var text = []

if is_undefined(_command)
{
	for(var i = 0; i <= ds_list_size(command_order)-1; i++)
	{
		var c = command_order[| i].str
		
		if command_order[| i].cat
		{
			if not command_order[| i].hidden or show_hidden_commands array_push(text, c+"\n")
		}
		else
		{
			var _hidden = variable_struct_exists_get(commands[? c], "hidden", false)
		
			if show_hidden_commands or not _hidden
			{
				array_push(text, {str: "- "+c+"\n", scr: command_help, arg: c, output: true})
			}
		}
	}
	array_push(text,
		"\n",
		{cbox: "o_console.show_hidden_commands", scr: command_help, output: true}," Show hidden commands\n\n",
		
		{str: "Help menu", scr: help, output: true}," / ",{str: "Commands", col: "embed_hover"}," / ",{str: "Shortcuts", scr: shortcut_help, outp: true}
	)
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

	for(var i = 0; i <= array_length(_args)-1; i++)		  argtext += _args[i]+","
	for(var i = 0; i <= array_length(_optargs)-1; i++)	  argtext += "["+_optargs[i]   +"],"
	for(var i = 0; i <= array_length(_hiddenargs)-1; i++) argtext += "<"+_hiddenargs[i]+">,"
	
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
		{str: "Help menu", scr: help, output: true}," / ",{str: "Commands", scr: command_help, output: true}," / ",{str: "Shortcuts", scr: shortcut_help, outp: true}," / ",{str: _command, col: "embed_hover"}
	)
}

return format_output(text, true, command_help, "Command list")
}}




function syntax_help(){ with o_console {
	
return format_output([
	"Basic GMCL syntax\n\n"+
	
	"Setting scope:     ",{str:"instance",col: dt_instance},"\n"+
	"Getting variables: ",{str:"instance",col: dt_instance},{str:".",col: dt_unknown},{str:"variable",col: dt_variable},"\n"+
	"Setting variables: ",{str:"instance",col: dt_instance},{str:".",col: dt_unknown},{str:"variable",col: dt_variable},{str:" value",col: dt_unknown},"\n"+
	"Running methods:   ",{str:"method",col: dt_method},{str:" argument0",col: dt_unknown},{str:" argument1 (...)",col: dt_unknown},"\n\n"+ 
	
	"Notes\n"+
	"- Multiple commands can be run in a single line when separated by semi-colons (;)\n"+
	"- The scope of the console only changes after every line has been run\n"+
	"- While custom methods are automatically detected, builtin gml functions have to be\n"+
	"  manually added to the console_macros list\n"+
	"- Characters such as parenthesis and commas are treated the same as spaces. This means\n"+
	"  GML code is often compatible with GMCL.\n"+
	"- If a method asks for a variable as an argument, it's likely intended to be a string\n\n",
	
	{str:"Help menu", scr: help, output: true}," / ",{str: "Basic syntax", col: "embed_hover"}," / ",{str: "Advanced syntax", scr: adv_syntax_help, output: true}," / ",{str: "Event tags", scr: tag_help, output: true}
], true, syntax_help, "GMCL syntax documentation")
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
], true, adv_syntax_help, "Advanced GMCL syntax documentation")
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
], true, tag_help, "Compiler instructions documentation")
}



function shortcut_help(){

return format_output([
	"GMCL shortcuts\n\n"+
	
	"Data structure accessors\n"+
	"Many types of data structures have accessors which make them easier to read from or write to.\n\n"+
	"The symbols used are parallel to GML's ds identifiers, and they're functionally just methods with shortcuts.\n\n",
	
	{str: "  @", arg: "@", scr: command_help, outp: true},": arrays\n",
	{str: "  |", arg: "|", scr: command_help, outp: true},": ds lists\n",
	{str: "  $", arg: "$", scr: command_help, outp: true},": structs\n",
	{str: "  ?", arg: "?", scr: command_help, outp: true},": ds maps\n",
	{str: "  #", arg: "#", scr: command_help, outp: true},": ds grids\n\n",

	{str: "Help menu", scr: help, output: true}," / ",{str: "Commands", scr: command_help, output: true}," / ",{str: "Shortcuts", col: "embed_hover"}
], true, shortcut_help, "Shortcut list")
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
	
	"Click to show ",{str: "Window", scr: window, arg: "This is the Window!"}, " - ",{str: "Display\n\n", scr: display, arg: "o_console.is_this_the_display"},
	
	{str: "Help menu", scr: help, output: true}," / ",{str: "Windows", col: "embed_hover"}
], true, console_window_help, "IDE window documentation")
}



function console_settings(){ with o_console {
	
static icg = initialize_console_graphics
	
return format_output([
	"UI scale: ",{str: "1x", scr: icg, arg: 1}," ",{str: "2x", scr: icg, arg: 2}," ",{str: "3x", scr: icg, arg: 3}," ",{str: "4x", scr: icg, arg: 4}," ",{str: "5x", scr: icg, arg: 5},
	"\n\n",
	
	{cbox: "o_console.collapse_windows"}, " Collapse windows by clicking sidebar\n\n",
	{cbox: "o_console.output_as_window", scr: o_console.Output_window.reset_pos}, " Output as window\n\n",
	
	{cbox: "o_console.force_output"}, " Always show output\n",
	{cbox: "o_console.force_output_body"}, " Always show output background\n",
	{cbox: "o_console.force_output_embed_body"}, " Show output background when it displays embedded text\n\n",

	{str: "Reset console\n", scr: reset_obj, arg: o_console},
	{str: "Destroy console\n\n", scr: destroy_console},
	
	{str: "Help menu", scr: help, output: true}," / ",{str: "Settings", col: "embed_hover"}
], true, console_settings, "IDE settings")
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
		if cs_list[i] == cs_index	array_push(builtin, {str: "\n> ", col: dt_unknown})
		else						array_push(builtin, "\n  ")
		
		array_push(builtin, {str: cs_list[i], scr: color_scheme, arg: cs_list[i], outp: true})
	}
	else
	{
		if cs_list[i] == cs_index	array_push(notbuiltin, {str: "\n> ", col: dt_unknown})
		else						array_push(notbuiltin, "\n  ")
		
		array_push(notbuiltin, {str: cs_list[i], scr: color_scheme, arg: cs_list[i], outp: true})
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
	"\n\n",
	{str: "", checkbox: "o_console.rainbow"}, " gamer mode\n\n",

	{str: "New color scheme\n", scr: new_color_scheme, outp: true},
	{str: "Regenerate default color schemes\n\n", scr: initialize_color_schemes},
	
	{str: "Help menu", scr: help, output: true}," / ",{str: "Color schemes", col: "embed_hover"}," / ",{str: "Color scheme editor", scr: color_scheme_editor, output: true},
)

return format_output(text, true, color_scheme_settings)
}}

	
function color_scheme_editor(){ with o_console {

return format_output([
	"IDE colors",
	{str: "\nbody        ",	scr: value_box,	args: ["o_console.colors.body",				vb_color]},"(the color behind text)",
	{str: "\nbody_bm     ",	scr: input_set, args: ["o_console.colors.body_bm ",			true]},
	{str: "\nbody_alpha  ",	scr: value_box,	args: ["o_console.colors.body_alpha",		vb_scrubber]},
	{str: "\nbody_real   ",	scr: value_box,	args: ["o_console.colors.body_real",		vb_color]},"(body color when blendmode/alpha aren't applied)",
	{str: "\nbody_accent ",	scr: value_box,	args: ["o_console.colors.body_accent",		vb_color]},"(the secondary body color)",
	{str: "\noutput      ",	scr: value_box,	args: ["o_console.colors.output",			vb_color]},"(the 'main' color)",
	{str: "\nex_output   ",	scr: value_box,	args: ["o_console.colors.ex_output",		vb_color]},"(output text color when exposed)",
	{str: "\nembed       ",	scr: value_box,	args: ["o_console.colors.embed",			vb_color]},
	{str: "\nembed_hover ",	scr: value_box,	args: ["o_console.colors.embed_hover",		vb_color]},
	{str: "\nselection   ",	scr: value_box,	args: ["o_console.colors.selection",		vb_color]},"\n\n"+
	
	"Text colors",
	{str: "\nplain       ",	scr: value_box,	args: ["o_console.colors.plain",			vb_color]},
	{str: "\nreal        ",	scr: value_box, args: ["o_console.colors."+dt_real,			vb_color]},
	{str: "\nstring      ",	scr: value_box, args: ["o_console.colors."+dt_string,		vb_color]},
	{str: "\nasset       ",	scr: value_box, args: ["o_console.colors."+dt_asset,		vb_color]},
	{str: "\nvariable    ",	scr: value_box, args: ["o_console.colors."+dt_variable,		vb_color]},
	{str: "\nmethod      ",	scr: value_box, args: ["o_console.colors."+dt_method,		vb_color]},
	{str: "\ninstance    ",	scr: value_box, args: ["o_console.colors."+dt_instance,		vb_color]},
	{str: "\nroom        ",	scr: value_box, args: ["o_console.colors."+dt_room,			vb_color]},
	{str: "\ntag         ",	scr: value_box, args: ["o_console.colors."+dt_tag,			vb_color]},"(compiler instructions)",
	{str: "\ndeprecated  ",	scr: value_box, args: ["o_console.colors."+dt_deprecated,	vb_color]},"(commands no longer in use)\n\n",

	"All color scheme variables are stored in o_console.colors\n\n",
	
	{str: "Help menu", scr: help, output: true}," / ",{str: "Color schemes", scr: color_scheme_settings, output: true}," / ",{str: "Color scheme editor", col: "embed_hover"},
	
], true, color_scheme_editor, "Color scheme editor")
}}

	
	
function Epsiilon(){

return format_output([
	"This scripting console was developed by Epsiilon2048, with help from the \nGMS community\n\n",
	
	"[links] ",{str: "Twitter",	scr: url_open, arg: "https://twitter.com/epsiilon2048"}," - ",{str: "Youtube",	scr: url_open, arg: "https://www.youtube.com/channel/UCA4znMVFR0P0V6ZitJhi2bA"}," - ",{str: "Github",		scr: url_open, arg: "https://github.com/Epsiilon2048"},"\n\n"+

	"With scripts from:\n",
	{str: "yellowafterlife", scr: url_open, arg: "https://yal.cc/"}," (",{str: "string_split", scr: url_open, arg: "https://yal.cc/gamemaker-split-string/"},")\n",
	{str: "GMLscripts.com",	scr: url_open, arg: "https://GMLscripts.com/"}," / Schreib & xot (",{str: "dec_to_hex", scr: url_open, arg: "https://www.gmlscripts.com/script/dec_to_hex"},", ",{str: "hex_to_dec", scr: url_open, arg: "https://www.gmlscripts.com/script/hex_to_dec"},", ",{str: "rgb_to_hex", scr: url_open, arg: "https://www.gmlscripts.com/script/rgb_to_hex"},")\n\n",
	
	"Thank you so much for your interest and support!\n\n",
	
	{str:"Help menu", scr: help, output: true}," / ",{str: "Credits", col: "embed_hover"}
], true, Epsiilon)
}
	
	
	
	
function console_videos(){ with o_console {

return format_output([
	"Video explaining the new updates soon (hopefully)!\n\n"+
	"[links]\n",
	{str: "1.0 Demonstration", scr: url_open, arg:"https://www.youtube.com/watch?v=DePksU_vjRY&t=2s"}," (quite old)\n",
	{str: "1.1 Colors\n", scr: url_open, arg:"https://www.youtube.com/watch?v=rz2lvfYwHyQ"},
	{str: "1.2 Color schemes\n\n", scr: url_open, arg: "https://youtu.be/QCn5csFYYgA"},
	
	{str:"Help menu", scr: help, output: true}," / ",{str: "Basic syntax", col: "embed_hover"}
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

return format_output([{str: "Help menu", scr: help, output: true}," / ",{str: _nice_thing, scr: nice_thing, outp: true}], true, nice_thing, _nice_thing)
}