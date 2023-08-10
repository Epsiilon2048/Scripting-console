
function set_console_scale(scale){
o_console.auto_scale = false
o_console.scale(scale)
}



function create_variable(name, value){

if not is_string(name) return "Variable name must be string!"
if string_is_int(string_char_at(name, 1)) return "Invalid variable name - can't start with number!"

for(var i = 1; i <= string_length(name); i++)
{
	var char = string_char_at(name, i)
	if not (char == "_" or string_lettersdigits(char) == char)
	{
		return "Invalid variable name - can't use special characters!"
	}
}

console_macro_add(name, dt_variable, "o_console.variables."+name)
o_console.variables[$ name] = value
return o_console.variables[$ name]
}


function roomobj(){ with o_console {

static obj_collumn	= "name"
static id_collumn	= "id"

var longest_object = string_length(obj_collumn)+2

for (var i = 0; i <= instance_count-1; i++)
{
	var inst = instance_id[i]
	var objlen = string_length(object_get_name(inst.object_index))
	if longest_object < objlen	longest_object = objlen+2
}

//var obj_spaces = string_repeat(" ", longest_object - string_length( obj_collumn ))
//var ind_spaces = string_repeat(" ", longest_index - string_length( ind_collumn ))

var instances = []

var i = -1
while object_exists(i) 
{
	i++
	if not instance_exists(i) continue
	array_push(instances,
	{
		name: object_get_name(i),
		id: i.id,
		__selected__: instance_exists(object) and i.id == object.id
	})
}

var text = generate_embed_list(instances, ["name", "id"], {scr: roomobj, vari: "o_console.object", arg: inst, output: true}, "id")

array_push(text, 
	"\n"+((instance_count == 1) ? "\nIt's just me!" : "")+"\n",
	"Click on an object to set the console scope"
)

return format_output(text, true)
}}


function roominst(){ with o_console {

static obj_collumn	= "name"
static ind_collumn	= "ind"
static id_collumn	= "id"

var longest_object = string_length(obj_collumn)+2
var longest_index = string_length(ind_collumn)+2

for (var i = 0; i <= instance_count-1; i++)
{
	var inst = instance_id[i]
	
	var objlen = string_length(object_get_name(inst.object_index))
	var indlen = string_length(inst.object_index)
	
	if longest_object < objlen	longest_object = objlen+2
	if longest_index < indlen	longest_object = indlen+2
}

//var obj_spaces = string_repeat(" ", longest_object - string_length( obj_collumn ))
//var ind_spaces = string_repeat(" ", longest_index - string_length( ind_collumn ))

var instances = array_create(instance_count)

for (var i = 0; i <= instance_count-1; i++)
{
	instances[i] = 
	{
		name: object_get_name(instance_id[i].object_index),
		id: instance_id[i],
		__selected__: instance_exists(object) and instance_id[i] == object.id
	}
}

var text = generate_embed_list(instances, ["name", "id"], {scr: roomobj, vari: "o_console.object", arg: inst, output: true}, "id")

array_push(text, 
	"\n"+((instance_count == 1) ? "\nIt's just me!" : "")+"\n",
	"Click on an instance to set the console scope"
)

return format_output(text, true, roomobj, "Instances in room")
}}


function reset_obj(obj){
	
if is_undefined(obj) obj = object
var _x = obj.x
var _y = obj.y
var _layer = obj.layer

instance_destroy(obj)
instance_create_layer(_x, _y, _layer, obj)
return "Object reset!"
}
	

function display(variable=undefined){ with o_console {

if not is_undefined(variable)
{
	var t = new_text_box(variable, variable)
	t.instant_update = true
	t.att.allow_input = false

	add_console_element(t)
	exit
}

if variable_struct_names_count(DISPLAY) == 0 
{
	DISPLAY = new_variable_display()
	with DISPLAY before_func = function(){ association = instance_exists(o_console.object) ? o_console.object : {}}
	add_console_element(DISPLAY)
	return "Initialized display"
}
else
{
	var o
		
	DISPLAY.enabled = not DISPLAY.enabled
		
	if not DISPLAY.enabled	o = "Hid display dock"
	else					o = "Enabled display dock"
		
	return new element_container(new_embedded_text([o+" (",{s: "undo", func: display, outp: true},")"]))
}
}}


function add_textbox(variable){

var t = new_text_box(variable, variable)
t.instant_update = true
add_console_element(t)
}


function add_scrubber(variable, step){

var t = new_scrubber(variable, variable, step)
t.instant_update = true
add_console_element(t)
}


function add_colorbox(variable){

var t = new_color_box(variable, variable)
add_console_element(t)
}
