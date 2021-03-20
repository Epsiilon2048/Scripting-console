// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function initialize_command_info(){

commands = [
	{scr: "help", desc: "Returns console help and info. But surely you already know this command if you're viewing it?"},
	{scr: "command_help", optargs: ["command"], desc: "Returns the usage of a command; if left blank, returns the list of commands"},
	{scr: "syntax_help", optargs: ["command"], desc: "Returns the usage of a command; if left blank, returns the list of commands"},
	{hidden: true, scr: "console_window_help", desc: "Returns an explanation of console windows"},
	{hidden: true, scr: "embedded_text_help", desc: "Returns an explanation of text embedding"},
	
	{scr: "console_settings", desc: "Returns the console settings menu"},
	{scr: "color_scheme", args:["color scheme index"], desc: "Sets the console color scheme to the specified index"},
	{scr: "color_scheme_settings", desc: "Returns the color scheme settings menu"},
	{hidden: true, scr: "console_videos", desc: "Returns a list of videos featuring the console"},
	{hidden: true, scr: "initialize_color_schemes", desc: "Resets the color schemes"},
	
	{hidden: true, scr: "Epsiilon", desc: "Returns info about the creator of the console"},
	{hidden: true, scr: "nice_thing", desc: "Why don't you run it and find out?"},
	{hidden: true, scr: "destroy_console", hiddenargs: ["are you certain?"], desc: "please dont :/"},
	
	{scr: "error_report", desc: "Returns the longMessage of the previous error thrown by a console command"},
	
	{scr: "ar", args: ["array", "index"], optargs: ["value"], desc: "Returns the specified index of an array, or sets the specified index to a value"},
	{scr: "addvar", args: ["variable"], optargs: ["value"], desc: "Adds a value to the specified variable; value defaults to 1"},
	{scr: "togglevar", args: ["variable"], desc: "Toggles a boolean variable"},
	
	{scr: "roomobj", desc: "Returns all the instances in the room"},
	{scr: "objvar", optargs: ["object"], desc: "Returns all the variables in the specified/scoped instance"},
	
	{scr: "select_obj", desc: "After running, click on an instance to set the console's scope"},
	{scr: "reset_obj", optargs: ["object"], desc: "Destroys and recreates the specified/scoped instance"},
	
	{scr: "window", optargs: ["text"], desc: "Sets the Window text; if left blank, toggles the Window"},
	{scr: "window_reset_pos", desc: "Resets the position of the Window"},
	
	{scr: "display", optargs: ["variable"], hiddenargs: ["enable?"], desc: "Puts a specified variable on the Display; if left blank, toggles the Display"},
	{scr: "displayds", optargs: ["DS list"], hiddenargs: ["enable?"], desc: "Puts a specified DS list on the Display"},
	{scr: "display_all", optargs: ["object"], hiddenargs: ["enable all?"], desc: "Puts all variables in the specified/scoped instance on the Display"},
	{scr: "display_clear", desc: "Removes all variables from the Display"},
	{scr: "display_reset_pos", desc: "Resets the position of the Display"},
	
	{scr: "bind",	  args: ["key", "command"], desc: "Binds a key to a command"},
	{scr: "unbind",	  args: ["bind index"], hiddenargs: ["return bindings menu?"], desc: "Removes the binding in the specified index"},
	{scr: "bindings", desc: "Returns the list of bindings"},

	{scr: "vtv", optargs: ["to variable", "from variable"], desc: "Sets the 'to' variable to the 'from' variable every step; if left blank clears the previous vtv"},
	{scr: "vt_mx", optargs: ["variable"], desc: "Sets the specified variable to mouse_x every step; if left blank clears the previous vt_mx"},
	{scr: "vt_my", optargs: ["variable"], desc: "Sets the specified variable to mouse_y every step; if left blank clears the previous vt_my"},
	{scr: "vtm_gui", desc: "Toggles between taking the regular/gui positions of the mouse for the var to mouse commands"},

	{scr: "color_make", args: ["r", "g", "b"], desc: "Returns a color value and sets the scoped instance's _col variable to the return"},
	{scr: "color_get",	optargs: ["color value"], desc: "Returns the RGB of a color value; if left blank returns the RBG of the scoped instance's _col variable"},
]


deprecated_commands = ds_map_create()
var o = deprecated_commands

o[? "ar"]						= {newname: "@",							ver: "Release 1.2"}
o[? "color"]					= {newname: "color_make",					ver: "Early 1.2"}
o[? "obj_reset"]				= {newname: "reset_obj",					ver: "Early 1.2"}
o[? "window_toggle"]			= {newname: "window",						ver: "Early 1.2"}
o[? "display_all_variables"]	= {newname: "display_all",					ver: "Early 1.2"}
o[? "select"]					= {newname: "select_obj",					ver: "Unreleased 1.0"}
o[? "objects_in_room"]			= {newname: "roomobj",						ver: "Unreleased 1.0"}
o[? "variables_in_object"]		= {newname: "objvar",						ver: "Unreleased 1.0"}

o[? "vtv"]						= {note: "Became obsolete with event tags", ver: "Release 1.2"}
o[? "vt_mx"]					= {note: "Became obsolete with event tags", ver: "Release 1.2"}
o[? "vt_my"]					= {note: "Became obsolete with event tags", ver: "Release 1.2"}
o[? "var_to_mouse_x"]			= {note: "Became obsolete with event tags", ver: "Unreleased 1.0"}
o[? "var_to_mouse_y"]			= {note: "Became obsolete with event tags", ver: "Unreleased 1.0"}
o[? "var_to_var"]				= {note: "Became obsolete with event tags", ver: "Unreleased 1.0"}
o[? "create_camera_point"]		= {note: "Was project specific",			ver: "Unreleased 1.0"}
}