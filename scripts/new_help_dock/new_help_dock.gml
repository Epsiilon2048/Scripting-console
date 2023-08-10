function new_help_dock(){
o_console.help = new Console_dock() with o_console.help {
initialize()
name = "Greenbean Menu"
draw_name_bar = false
subdocks = {}
var menu_button = new_cd_button("Back to main menu", function(){to_set = subdocks.main}, false)
subdocks.main = new element_container([
	new_embedded_text([
		{str: "Welcome to the Greenbean console!\n\n", col: dt_tag},
		"Help & info\n",
		{str: "Commands\n", scr: function(){o_console.help.to_set = o_console.help.subdocks.commands}},
		{str: "Language basics\n", scr: function(){o_console.help.to_set = o_console.help.subdocks.syntax}},
		{str: "Language identifiers\n", scr: function(){o_console.help.to_set = o_console.help.subdocks.advsyntax}},
		{str: "Language importing\n", scr: function(){o_console.help.to_set = o_console.help.subdocks.import}},"\n"+
		
		"Docks\n",
		{str: "Variable display\n", scr: display},
		{str: "Color picker\n", scr: function(){replace_console_element(new_color_dock("o_console._col"))}},
		{str: "Dock manager\n", scr: function(){o_console.element_dock.enabled = not o_console.element_dock.enabled}},"\n"+
			
		"Other stuff\n",
		{str: "Themes\n", scr: function(){o_console.help.to_set = o_console.help.subdocks.themes}},
		{str: "Github page", scr: url_open, arg: "https://github.com/Epsiilon2048/gms-script-console"}," [link]\n",
		{str: "Credits", scr: function(){o_console.help.to_set = o_console.help.subdocks.credits}},
	]),
])

subdocks.syntax = new element_container([
	new_cd_text("Language basics", dt_tag),
	new_separator(),
	new_embedded_text([
		"The console scope (on the side of the command bar) is the scope\n"+
		"in which commands operate.\n\n"+
	
		"Setting scope:     ",{str:"instance",col: dt_instance},"\n"+
		"Getting variables: ",{str:"instance",col: dt_instance},{str:".",col: dt_unknown},{str:"variable",col: dt_variable},"\n"+
		"Setting variables: ",{str:"instance",col: dt_instance},{str:".",col: dt_unknown},{str:"variable",col: dt_variable},{str:" value",col: dt_unknown},"\n"+
		"Running functions: ",{str:"function",col: dt_method},{str:" argument1 argument2 ...",col: dt_unknown},"\n\n"+
		
		"If a console command asks for a variable as an argument, it's\n"+
		"asking for a string of the variable name.",
	]),
	new_separator(),
	menu_button,
])

subdocks.advsyntax = new element_container([
	new_cd_text("Language identifiers", dt_tag),
	new_separator(),
	new_embedded_text([
		"Datatype identifiers can be used for avoiding naming conflicts,\n"+
		"telling the compiler what type a value is, and for checking if\n"+
		"a value works for a datatype.\n\n"+
	
		"Supported identifiers:\n"+
		"(",{s:"r",col: dt_real},")eal, (",{s:"s",col: dt_string},")tring, (",{s:"a",col: dt_asset},")sset, (",{s:"v",col: dt_variable},")ariable, (",{s:"m",col: dt_method},")ethod, (",{s:"i",col: dt_instance},")nstance, (",{s:"c",col: dt_color},")olor\n\n"+
	
		"Just a couple use cases:\n"+
		"Writing a variable as a string, but retaining the colors\n",
		{s:"s/",col: dt_string},{s:"instance",col: dt_instance},{s:".",col: dt_string},{s:"variable",col: dt_variable}," -> ",{s:"\"instance.variable\"\n\n",col: dt_string},
	
		"Checking if an instance of an object or ID exists\n",
		{s:"i/",col: dt_instance},{s:"object_with_no_instance",col: dt_unknown}," - ",{s:"i/object_with_instance\n\n",col: dt_instance},
		
		"Formatting a color value\n",
		{s:"c/0x3B8281",col: dt_color}," -> ",{s:"This Color",col: #3B8281},
	]),
	new_separator(),
	menu_button,
])

subdocks.import = new element_container([
	new_cd_text("Importing GML functions", dt_tag),
	new_separator(),
	new_embedded_text([
		"The console automatically indexes GameMaker functions on\n"+
		"on startup. However, for the sake of brevity, some are excluded.\n"+
		"If you're missing something, you can use this command to add it:\n\n",
		{s:"#include ",col: dt_tag},{s:"function_name\n",col: dt_unknown},
		"Added 1 builtin function."
	]),
	new_separator(),
	menu_button,
])


var cs_list = variable_struct_get_names(o_console.color_schemes)
var list = array_create(array_length(cs_list))
var n = ""
for(var i = 0; i <= array_length(cs_list)-1; i++)
{
	list[i] = {str: n+cs_list[i], scr: color_scheme, arg: cs_list[i]}
	n = "\n"
}

subdocks.themes = new element_container([
	new_cd_text("Themes", dt_tag),
	new_separator(),
	[new_cd_checkbox("","o_console.force_body_solid"),"Solid background"],
	[new_cd_checkbox("","o_console.bird_mode"),"bird mode"],
	new_embedded_text(list),
	new_separator(),
	menu_button,
])
set(subdocks.main)
}

replace_console_element(o_console.help)
}