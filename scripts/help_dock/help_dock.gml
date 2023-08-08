function help_dock(){
o_console.help = new Console_dock() with o_console.help {
initialize()
name = "Greenbean Console"
draw_name_bar = false
subdocks = {}
var menu_button = new_cd_button("Back to main menu", function(){to_set = subdocks.main}, false)
subdocks.main = new element_container([
	new_embedded_text([
		{str: "Welcome to the Greenbean console & IDE package!\n\n", col: dt_tag},
		"Help & info\n",
		{str: "Command list\n", scr: function(){o_console.help.to_set = o_console.help.subdocks.commands}},
		{str: "Console language guide\n", scr: function(){o_console.help.to_set = o_console.help.subdocks.syntax}},
		{str: "IDE guide\n", scr: function(){o_console.help.to_set = o_console.help.subdocks.ide}},"\n"+
			
		"Features\n",
		{str: "Element list\n", scr: function(){o_console.element_dock.enabled = not o_console.element_dock.enabled; move_to_front(o_console.element_dock)}},"\n"+
			
		"Options\n",
		{str: "Themes\n", scr: function(){o_console.help.to_set = o_console.help.subdocks.themes}},
		{str: "Settings\n", scr: function(){o_console.help.to_set = o_console.help.subdocks.settings}},"\n"+
			
		"Other stuff\n",
		{str: "Say a nice thing!\n", scr: function(){output_set(nice_thing())}},
		{str: "Github page", scr: url_open, arg: "https://github.com/Epsiilon2048/gms-script-console"}," [link]\n",
		{str: "Credits", scr: function(){o_console.help.to_set = o_console.help.subdocks.credits}},
	]),
])
	
subdocks.settings = new element_container([
	new_cd_text("Settings", dt_tag),
	new_cd_text("None of this is saved between runtimes!", dt_real),
	new_separator(),
	[new_cd_checkbox(,"o_console.BAR.dock.enabled"),"Command bar window"],
	[new_cd_checkbox(,"o_console.command_colors"),"Intellisense colors"],
	[new_cd_checkbox(,"o_console.autofill.side_text_override"),"Autofill side text"],
	[new_cd_checkbox(,"o_console.bird_mode"),"Bird mode"],
	new_separator(),
	menu_button,
])

subdocks.syntax = new element_container([
	new_cd_text("Console Language features", dt_tag),
	new_separator(),
	new_embedded_text([
		"The console scope (listed on the side of the command bar) is the scope which commands\n"+
		"operate in.\n\n"+
	
		"Setting scope:     ",{str:"instance",col: dt_instance},"\n"+
		"Getting variables: ",{str:"instance",col: dt_instance},{str:".",col: dt_unknown},{str:"variable",col: dt_variable},"\n"+
		"Setting variables: ",{str:"instance",col: dt_instance},{str:".",col: dt_unknown},{str:"variable",col: dt_variable},{str:" = value",col: dt_unknown},"\n"+
		"Running functions: ",{str:"function",col: dt_method},{str:"(argument1, argument2, ...)",col: dt_unknown},"\n"+ 
		"Running methods:   ",{str:"instance",col: dt_instance},{str:".",col: dt_unknown},{str:"method",col: dt_method},{str:"(argument1, argument2, ...)",col: dt_unknown},"\n\n"+ 
		
		"The separator character for arguments is space ( ), but characters such as commas (,)\n"+	
		"are handled the same. This means GML code is often compatible with GBCL code.\n\n"+
	
		"Multiple commands can be run in a single line when separated by semi-colons (;).\n\n"+
	
		"If a console command asks for a variable as an argument, it's asking for a string of the\n"+
		"variable name.",
	]),
	new_separator(),
	menu_button,
])

set(subdocks.main)
}

add_console_element(o_console.help)
}