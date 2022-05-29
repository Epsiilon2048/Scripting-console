
function help(){

return format_output([
	"Help & info\n",
	{str: "Command list\n", scr: command_help, output: true},
	{str: "GMCL syntax\n", scr: syntax_help, output: true},
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


function adv_syntax_help(){
	
return format_output([
	"Advanced GMCL syntax\n\n"+
	
	"Datatype identifiers can be used for avoiding naming conflicts, instructing the compiler\n"+
	"on what to return, or for checking to see if a value works for a datatype.\n\n"+
	
	"Supported identifiers: (",{s:"r",col: dt_real},")eal - (",{s:"s",col: dt_string},")tring - (",{s:"a",col: dt_asset},")sset - (",{s:"v",col: dt_variable},")ariable - (",{s:"m",col: dt_method},")ethod - (",{s:"i",col: dt_instance},")nstance - (",{s:"c",col: dt_color},")olor\n\n"+
	
	"(just a couple) use cases:\n"+
	"Writing a variable as a string, but retaining the text colors to make sure it's correct\n",
	{s:"s/",col: dt_string},{s:"instance",col: dt_instance},{s:".",col: dt_string},{s:"variable",col: dt_variable}," -> ",{s:"\"instance.variable\"\n\n",col: dt_string},
	
	"Checking if an instance of an object or ID exists\n",
	{s:"i/",col: dt_instance},{s:"object_with_no_instance",col: dt_unknown}," - ",{s:"i/object_with_instance\n\n",col: dt_instance},
	
	"Avoiding a naming conflict between a console macro and instance variable\n",
	{s:"console_macro",col: dt_instance}," - ",{s:"v/console_macro\n\n",col: dt_variable},
	
	{str:"Help menu", scr: help, output: true}," / ",{str: "Basic syntax", scr: syntax_help, output: true}," / ",{str: "Advanced syntax", col: "embed_hover"}," / ",{str: "Event tags", scr: tag_help, output: true}
], true, adv_syntax_help, "Advanced GMCL syntax documentation")
}



function tag_help(){

return format_output([
	"Compiler instructions inform the compiler where to send the command.\n\n"+
	
	"Event tags are used to run console commands during events, rather than when it's run.\n\n"+
	
	"An example:\n",
	{s:"#draw ",col: dt_tag},{s:"draw_line ",col: dt_method},{s:"0 0 ",col: dt_real},{s:"mouse_x mouse_y\n\n",col: dt_variable},
	
	"This command would be run in every draw event, drawing a line to the mouse position.\n\n"+
	
	{str:"Help menu", scr: help, output: true}," / ",{str: "Basic syntax", scr: syntax_help, output: true}," / ",{str: "Advanced syntax", scr: adv_syntax_help, output: true}," / ",{str: "Event tags", col: "embed_hover"}
], true, tag_help, "Compiler instructions documentation")
}



function console_settings(){ with o_console {
	
static sc = scale
	
return format_output([
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
	if variable_struct_exists_get(color_schemes[$ cs_list[i]], "builtin", false)
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
	{cbox: "o_console.force_body_solid"}," Force solid background\n\n",

	{str: "", checkbox: "o_console.bird_mode"}," bird mode\n",
	{str: "", checkbox: "o_console.rainbow"}," gamer mode\n\n",

	{str: "New color scheme\n", scr: new_color_scheme, outp: true},
	{str: "Regenerate default color schemes\n\n", scr: initialize_color_schemes},
	
	{str: "Help menu", scr: help, output: true}," / ",{str: "Color schemes", col: "embed_hover"}," / ",{str: "Color scheme editor", scr: new_colorscheme_editor, dock: true},
)

return format_output(text, true, color_scheme_settings)
}}



function Epsii(){

return format_output([
	"This console was developed by Epsii, with help from the \nGMS community\n\n",
	
	"[links] ",{str: "Twitter",	scr: url_open, arg: "https://twitter.com/pepsiilon"}," - ",{str: "Youtube",	scr: url_open, arg: "https://www.youtube.com/channel/UCA4znMVFR0P0V6ZitJhi2bA"}," - ",{str: "Github",		scr: url_open, arg: "https://github.com/Epsiilon2048"},"\n\n"+

	"With scripts from:\n",
	{str: "yellowafterlife", scr: url_open, arg: "https://yal.cc/"}," (",{str: "string_split", scr: url_open, arg: "https://yal.cc/gamemaker-split-string/"},")\n",
	{str: "GMLscripts.com",	scr: url_open, arg: "https://GMLscripts.com/"}," / Schreib & xot (",{str: "dec_to_hex", scr: url_open, arg: "https://www.gmlscripts.com/script/dec_to_hex"},", ",{str: "hex_to_dec", scr: url_open, arg: "https://www.gmlscripts.com/script/hex_to_dec"},", ",{str: "rgb_to_hex", scr: url_open, arg: "https://www.gmlscripts.com/script/rgb_to_hex"},")\n\n",
	
	"Thank you so much for your interest and support!\n\n",
	
	{str:"Help menu", scr: help, output: true}," / ",{str: "Credits", col: "embed_hover"}
], true, Epsii)
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
static index = irandom(array_length(_nice_things)-1)

var _nice_thing = _nice_things[index++ mod array_length(_nice_things)]

return _nice_thing
}