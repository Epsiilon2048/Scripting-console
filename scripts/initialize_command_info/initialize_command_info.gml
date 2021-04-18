// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function initialize_command_info(){

commands = ds_map_create()
command_order = ds_list_create()

com_add_category("Help & info")
com_add("help", {desc: "Returns console help and info. But surely you already know this command if you're viewing it?"})
com_add("command_help", {optargs: ["command"], desc: "Returns the usage of a command; if left blank, returns the list of commands"})
com_add("syntax_help", {hidden: true, desc: "Returns an explanation of basic GMCL syntax"})
com_add("adv_syntax_help", {hidden: true, desc: "Returns an explanation of advanced GMCL syntax"})
com_add("console_window_help", {hidden: true, desc: "Returns an explanation of console windows"})
com_add("embedded_text_help", {hidden: true, desc: "Returns an explanation of text embedding"})
com_add("Epsiilon", {hidden: true, desc: "Returns info about the creator of the console"})
com_add("nice_thing", {hidden: true, desc: "Why don't you run it and find out?"})

com_add_category("Settings")
com_add("console_settings", {desc: "Returns the console settings menu"})
com_add("color_scheme", {args:["color scheme index"], desc: "Sets the console color scheme to the specified index"})
com_add("color_scheme_settings", {hidden: true, desc: "Returns the color scheme settings menu"})
com_add("console_videos", {hidden: true, desc: "Returns a list of videos featuring the console"})
com_add("initialize_color_schemes", {hidden: true, desc: "Resets the color schemes"})
com_add("destroy_console", {hidden: true, hiddenargs: ["are you certain?"], desc: "please dont :/"})

com_add_category("Logging")
com_add("error_report", {desc: "Returns the exception of the previous error thrown by a console command"})
com_add("compile_report", {desc: "Returns a report of how the previous command was interpreted"})

com_add_category("Variable operations")
com_add("addvar", {args: ["variable"], optargs: ["value"], desc: "Adds a value to the specified variable; value defaults to 1"})
com_add("togglevar", {args: ["variable"], desc: "Toggles a boolean variable"})

com_add_category("Data structure access", true)
com_add("dealwith_array", {hidden: true, args: ["array"], optargs: ["index", "value"], desc: "Returns an array, returns an item off an array, or sets an array item to a value"})
com_add("dealwith_struct", {hidden: true, args: ["struct"], optargs: ["key1", "value1 (...)"], desc: "Returns a struct or allows you to set key/value pairs"})
com_add("dealwith_ds_list", {hidden: true, args: ["ds_list"], optargs: ["index", "value"], desc: "Returns a ds list, returns an item off a ds list, or sets a ds list item to a value"})
com_add("create_variable", {hidden: true, args: ["name"], optargs: ["value"], desc: "Declares a variable within the specified/scoped instance"})

com_add_category("Objects")
com_add("roomobj", {desc: "Returns all the instances in the room"})
com_add("objvar", {optargs: ["instance"], desc: "Returns all the variables in the specified/scoped instance"})
com_add("select_obj", {desc: "After running, click on an instance to set the console's scope"})
com_add("reset_obj", {optargs: ["instance"], desc: "Destroys and recreates the specified/scoped instance"})

com_add_category("Window commands")
com_add("window", {optargs: ["text"], desc: "Sets the Window text; if left blank, toggles the Window"})
com_add("window_reset_pos", {desc: "Resets the position of the Window"})

com_add_category("Display commands")
com_add("display", {optargs: ["variable"], hiddenargs: ["enable?"], desc: "Puts a specified variable on the Display; if left blank, toggles the Display"})
com_add("display_all", {optargs: ["object"], hiddenargs: ["enable all?"], desc: "Puts all variables in the specified/scoped instance on the Display"})
com_add("display_clear", {desc: "Removes all variables from the Display"})
com_add("display_reset_pos", {desc: "Resets the position of the Display"})

com_add_category("Console key binds")
com_add("bind", {args: ["key", "command"], desc: "Binds a key to a command"})
com_add("unbind", {args: ["bind index"], hiddenargs: ["return bindings menu?"], desc: "Removes the binding in the specified index"})
com_add("bindings", {desc: "Returns the list of bindings"})

com_add_category("Color operations")
com_add("color_make", {args: ["r", "g", "b"], desc: "Returns a color value and sets the scoped instance's _col variable to the return"})
com_add("color_get", {optargs: ["color value"], desc: "Returns the RGB, HSV, and hex of a color value; if left blank returns the RBG of the scoped instance's _col variable"})

com_add_category("Draw functions")
com_add("clip_rect_cutout", {args: ["x1", "y1", "x2", "y2"], desc: "Iinitializes a retangular clip mask shader"})

deprecated_commands = ds_map_create()
var o = deprecated_commands

o[? "ar"]						= {newname: "@",							ver: "Release 1.2"}
o[? "obj_reset"]				= {newname: "reset_obj",					ver: "Early 1.2"}
o[? "window_toggle"]			= {newname: "window",						ver: "Early 1.2"}
o[? "display_all_variables"]	= {newname: "display_all",					ver: "Early 1.2"}
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