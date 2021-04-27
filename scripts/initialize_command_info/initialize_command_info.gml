
function initialize_command_info(){

static com_add = function(name, details){

command_doc_add(name, details)
ds_list_add(command_order, {str: name, cat: false})
}

static com_add_category = function(text, hidden){

ds_list_add(command_order, {str: text, cat: true, hidden: is_undefined(hidden) ? false : hidden})
}

commands = ds_map_create()
command_order = ds_list_create()

com_add_category("Help & info", false)
com_add("help", {desc: "Returns console help and info. But surely you already know this command if you're viewing it?"})
com_add("command_help", {optargs: ["command"], desc: "Returns the usage of a command; if left blank, returns the list of commands"})
com_add("syntax_help", {hidden: true, desc: "Returns an explanation of basic GMCL syntax"})
com_add("adv_syntax_help", {hidden: true, desc: "Returns an explanation of advanced GMCL syntax"})
com_add("console_window_help", {hidden: true, desc: "Returns an explanation of console windows"})
com_add("embedded_text_help", {hidden: true, desc: "Returns an explanation of text embedding"})
com_add("Epsiilon", {hidden: true, desc: "Returns info about the creator of the console"})
com_add("nice_thing", {hidden: true, desc: "Why don't you run it and find out?"})

com_add_category("Settings", false)
com_add("console_settings", {desc: "Returns the console settings menu"})
com_add("color_scheme", {args:["color scheme index"], desc: "Sets the console color scheme to the specified index"})
com_add("color_scheme_settings", {hidden: true, desc: "Returns the color scheme settings menu"})
com_add("console_videos", {hidden: true, desc: "Returns a list of videos featuring the console"})
com_add("initialize_color_schemes", {hidden: true, desc: "Resets the color schemes"})
com_add("destroy_console", {hidden: true, hiddenargs: ["are you certain?"], desc: "please dont :/"})

com_add_category("Logging", false)
com_add("error_report", {desc: "Returns the exception of the previous error thrown by a console command"})
com_add("compile_report", {desc: "Returns a report of how the previous command was interpreted"})

com_add_category("Variable operations", false)
com_add("addvar", {args: ["variable"], optargs: ["value"], desc: "Adds a value to the specified variable; value defaults to 1"})
com_add("togglevar", {args: ["variable"], desc: "Toggles a boolean variable"})

com_add_category("Data structure access", true)
com_add("dealwith_array", {hidden: true, args: ["array"], optargs: ["index", "value"], desc: "Returns an array, returns an item off an array, or sets an array item to a value"})
com_add("dealwith_struct", {hidden: true, args: ["struct"], optargs: ["key1", "value1"], moreargs: true, desc: "Returns a struct or allows you to set key/value pairs"})
com_add("dealwith_ds_list", {hidden: true, args: ["ds_list"], optargs: ["index", "value"], desc: "Returns a ds list, returns an item off a ds list, or sets a ds list item to a value"})
com_add("create_variable", {hidden: true, args: ["name"], optargs: ["value"], desc: "Declares a variable within the specified/scoped instance"})

com_add_category("Objects", false)
com_add("roomobj", {desc: "Returns all the instances in the room"})
com_add("objvar", {optargs: ["instance"], desc: "Returns all the variables in the specified/scoped instance"})
com_add("select_obj", {desc: "After running, click on an instance to set the console's scope"})
com_add("reset_obj", {optargs: ["instance"], desc: "Destroys and recreates the specified/scoped instance"})

com_add_category("Window commands", false)
com_add("window", {optargs: ["text"], desc: "Sets the Window text; if left blank, toggles the Window"})
com_add("window_reset_pos", {desc: "Resets the position of the Window"})

com_add_category("Display commands", false)
com_add("display", {optargs: ["variable"], hiddenargs: ["enable?"], desc: "Puts a specified variable on the Display; if left blank, toggles the Display"})
com_add("display_all", {optargs: ["object"], hiddenargs: ["enable all?"], desc: "Puts all variables in the specified/scoped instance on the Display"})
com_add("display_clear", {desc: "Removes all variables from the Display"})
com_add("display_reset_pos", {desc: "Resets the position of the Display"})

com_add_category("Console key binds", false)
com_add("bind", {args: ["key", "command"], desc: "Binds a key to a command"})
com_add("unbind", {args: ["bind index"], hiddenargs: ["return bindings menu?"], desc: "Removes the binding in the specified index"})
com_add("bindings", {desc: "Returns the list of bindings"})

com_add_category("Colors", false)
com_add("color_get", {args: ["color value"], desc: "Returns the properties of a color value; if left blank returns the RBG of the scoped instance's _col variable"})
com_add("create_color_scheme4", {args: ["main", "body", "plaintext", "specialtext"], desc: "Builds a color scheme from 4 colors"})
com_add("create_color_scheme7", {args: ["main", "body", "body_accent", "plaintext", "exposedtext", "specialtext", "method"], desc: "Builds a color scheme from 7 colors"})
com_add("create_color_scheme10", {args: ["main", "body", "body_accent", "plaintext", "exposedtext", "specialtext", "variable", "method", "asset", "string"], desc: "Builds a color scheme from 10 colors"})
com_add("create_color_scheme_full", {args: ["body", "body_accent", "body_bm", "body_alpha", "output", "ex_output", "embed", "embed_hover", "plaintext", "real", "string", "variable", "method", "asset", "tag", "deprecated"], desc: "Builds a color scheme from 16 colors"})

com_add_category("Draw functions", false)
com_add("clip_rect_cutout", {args: ["x1", "y1", "x2", "y2"], desc: "Initializes a retangular clip mask shader"})

command_doc_add("@", commands[? "dealwith_array"])
command_doc_add("|", commands[? "dealwith_ds_list"])
command_doc_add("$", commands[? "dealwith_struct"])
command_doc_add("var", commands[? "create_variable"])

command_doc_add("instance_create_layer", {args: ["x", "y", "layer_id_or_name", "obj"], desc: ""})
command_doc_add("instance_create_depth", {args: ["x", "y", "depth", "obj"], desc: ""})
command_doc_add("instance_destroy", {optargs: ["id"], desc: ""})

command_doc_add("power", {args: ["x", "n"], desc: ""})

command_doc_add("array_length",{args: ["array"], desc: ""})

command_doc_add("instanceof",{args: ["struct"], desc: ""})

command_doc_add("array_delete", {args: ["array", "index", "number"], desc: ""})
command_doc_add("array_insert", {args: ["array", "index", "value"], desc: ""})
command_doc_add("array_push", {args: ["array", "value"], moreargs: true, desc: ""})

command_doc_add("asset_get_type", {args: ["name"], desc: ""})

command_doc_add("real", {args: ["val"], desc: ""})

command_doc_add("is_string", {args: ["val"], desc: ""})
command_doc_add("is_numeric", {args: ["val"], desc: ""})

command_doc_add("shader_set_uniform_f", {args: ["uniform_id", "val"], moreargs: true, desc: ""})

command_doc_add("draw_line", {args: ["x1", "y1", "x2", "y2"], desc: ""})
command_doc_add("draw_line_width", {args: ["x1", "y1", "x2", "y2"], desc: ""})
command_doc_add("draw_point", {args: ["x", "y"], desc: ""})
command_doc_add("draw_rectangle", {args: ["x1", "y1", "x2", "y2", "outline"], desc: ""})
command_doc_add("draw_circle", {args: ["x", "y", "r", "outline"], desc: ""})
command_doc_add("draw_sprite", {args: ["sprite", "subimg", "x", "y"], desc: ""})
command_doc_add("draw_sprite_ext", {args: ["sprite", "subimg", "x", "y", "xscale", "yscale", "rot", "col", "alpha"], desc: ""})
command_doc_add("draw_sprite_pos", {args: ["sprite", "subimg", "x1", "y1", "x2", "y2", "x3", "y3", "x4", "y4", "alpha"], desc: ""})
command_doc_add("draw_sprite_general", {args: ["sprite", "subimg", "left", "top", "width", "height", "x", "y", "xscale", "yscale", "rot", "c1", "c2", "c3", "c4", "alpha"], desc: ""})
command_doc_add("draw_text", {args: ["x", "y", "string"], desc: ""})

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