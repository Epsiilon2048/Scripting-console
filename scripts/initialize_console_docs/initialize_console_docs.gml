
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

com_add_category("Console features", false)
com_add("help", {desc: "Opens the help menu"})
com_add("console_settings", {desc: "Opens the console settings menu"})
com_add("color_scheme", {args:["color scheme index"], desc: "Sets the console color scheme to the specified index"})
com_add("color_scheme_settings", {hidden: true, desc: "Returns the color scheme settings menu"})
com_add("console_videos", {hidden: true, desc: "Returns a list of videos featuring the console"})
com_add("destroy_console", {hidden: true, hiddenargs: ["are you certain?"], desc: ":("})
com_add("error_report", {desc: "Returns the exception of the previous error thrown by a console command"})

com_add("display", {desc: "Adds a display element from a variable; if left blank, toggles the display dock", optargs: ["variable"]})
com_add("textbox", {desc: "Creates a text box element", args: ["variable"]})
com_add("scrubber", {desc: "Creates a scrubber box element", args: ["variable"], optargs: ["step"]})
com_add("colorbox", {desc: "Creates a color box element", args: ["variable"]})

com_add_category("Objects", false)
com_add("roomobj", {desc: "Returns all the instances in the room"})
com_add("objvar", {optargs: ["instance"], desc: "Returns all the variables in the specified/scoped instance"})
com_add("reset_obj", {optargs: ["instance"], desc: "Destroys and recreates the specified/scoped instance"})

command_doc_add("new_text_box", {desc: "Returns a text box element", args: ["name","variable"]})
command_doc_add("new_scrubber", {desc: "Returns a scrubber element", args: ["name","variable"], optargs: ["step"]})
command_doc_add("new_value_box", {desc: "Returns a value box element", args: ["name", "variable"], optargs: ["is scrubber","scrubber step","length min","length max","value min","value max","allow float?","float places"]})
command_doc_add("new_color_dock", {desc: "Returns a color dock", optargs: ["variable","use varbox","use rgb","use hsv","use hex","use gml"]})

command_doc_add("instance_create_layer", {args: ["x", "y", "layer_id_or_name", "obj"]})
command_doc_add("instance_create_depth", {args: ["x", "y", "depth", "obj"]})

command_doc_add("array_delete", {args: ["array", "index", "number"]})
command_doc_add("array_insert", {args: ["array", "index", "value"]})
command_doc_add("array_push", {args: ["array", "value"], moreargs: true})

command_doc_add("shader_set_uniform_f", {args: ["uniform_id", "val"], moreargs: true})

deprecated_commands = ds_create(ds_type_map, "deprecated_commands")
// newname, ver, note
}