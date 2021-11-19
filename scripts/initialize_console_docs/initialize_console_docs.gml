
function initialize_console_docs(){

static com_add = function(name, details){

command_doc_add(name, details)
ds_list_add(command_order, {str: name, cat: false})
}

static com_add_category = function(text, hidden){

ds_list_add(command_order, {str: text, cat: true, hidden: is_undefined(hidden) ? false : hidden})
}

commands = ds_create(ds_type_map, "commands")
command_order = ds_create(ds_type_list, "command_order")

com_add_category("Help & info", false)
com_add("help", {desc: "Returns console help and info. But surely you already know this command if you're viewing it?"})
com_add("command_help", {hidden: true, optargs: ["command"], desc: "Returns the usage of a command; if left blank, returns the list of commands"})
com_add("syntax_help", {hidden: true, desc: "Returns an explanation of basic GMCL syntax"})
com_add("adv_syntax_help", {hidden: true, desc: "Returns an explanation of advanced GMCL syntax"})
com_add("console_window_help", {hidden: true, desc: "Returns an explanation of console windows"})
com_add("Epsiilon", {hidden: true, desc: "Returns info about the creator of the console"})
com_add("nice_thing", {hidden: true, desc: "Why don't you run it and find out?"})

com_add_category("Settings", false)
com_add("console_settings", {desc: "Returns the console settings menu"})
com_add("color_scheme", {args:["color scheme index"], desc: "Sets the console color scheme to the specified index"})
com_add("color_scheme_settings", {hidden: true, desc: "Returns the color scheme settings menu"})
com_add("console_videos", {hidden: true, desc: "Returns a list of videos featuring the console"})
com_add("destroy_console", {hidden: true, hiddenargs: ["are you certain?"], desc: ":("})

com_add_category("Logging", false)
com_add("error_report", {desc: "Returns the exception of the previous error thrown by a console command"})

com_add_category("Variable operations", false)
com_add("addvar", {args: ["variable"], optargs: ["value"], desc: "Adds a value to the specified variable; value defaults to 1"})
com_add("multvar", {args: ["variable", "value"], desc: "Divides the specified variable by a value"})
com_add("divvar", {args: ["variable", "value"], desc: "Multiplies the specified variable by a value"})
com_add("togglevar", {args: ["variable"], desc: "Toggles a boolean variable"})

com_add_category("Objects", false)
com_add("roomobj", {desc: "Returns all the instances in the room"})
com_add("objvar", {optargs: ["instance"], desc: "Returns all the variables in the specified/scoped instance"})
com_add("select_obj", {desc: "After running, click on an instance to set the console's scope"})
com_add("reset_obj", {optargs: ["instance"], desc: "Destroys and recreates the specified/scoped instance"})

com_add_category("Console key binds", false)
com_add("bind", {args: ["key", "command"], desc: "Binds a key to a command"})
com_add("unbind", {args: ["bind index"], hiddenargs: ["return bindings menu?"], desc: "Removes the binding in the specified index"})
com_add("bindings", {desc: "Returns the list of bindings"})

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