
function dealwith_array(array, index, value){

if is_undefined(array) return "Must provide array!"

var _array
var _array_name = ""

if is_string(array) 
{
	_array_name = string_add_scope(array, true)
	
	if is_undefined(_array_name)				return "Missing variable scope"
	if not variable_string_exists(_array_name)	return array+" doesn't exist"
	
	_array = variable_string_get(_array_name)
}
else _array = array

if is_undefined(index) return _array
if is_undefined(value) return _array[index]

if not is_string(array) return "Must provide array name as string when setting items"

_array[index] = value
variable_string_set(_array_name, _array)
return stitch(array+"[",index,"] set to ",value)
}



function dealwith_struct(struct){

if is_undefined(struct) return "Must provide struct!"

if is_string(struct)
{
	var varstring = string_add_scope(struct, true)
	
	if not variable_string_exists(varstring)
	{
		variable_string_set(varstring, {})
		if argument_count == 1 return ""
	}
	
	struct = variable_string_get(varstring)
}

if argument_count == 1 return struct

for(var i = 1; i <= argument_count-2; i+=2)
{
	variable_struct_set(struct, argument[i], argument[i+1])
}
}

	
	
function dealwith_ds_list(ds_list, index, value){

if is_undefined(ds_list) return "Must provide ds list!"
if not is_numeric(ds_list) or not ds_exists(ds_list, ds_type_list) return stitch("\"",ds_list,"\""+" is not a ds list")

if is_undefined(index) return ds_list_to_array(ds_list)
if is_undefined(value) return ds_list[| index]

ds_list[| index] = value
return stitch("Set item ",value," in datastructure ",ds_list," to ",value)
}



function create_variable(name, value){

var _name = string_add_scope(name, true)

if not is_undefined(_name)
{
	var _existed = variable_string_exists(_name)
	
	variable_string_set(_name, value)
	
	if _existed return "Set "+name+" to "+string(value)
	
	else return "Declared "+name+" as "+string(value)
}
else return "Missing variable scope"
}



function addvar(variable, amount){

if not is_string(variable) return "Must provide variable name as string"

var _variable = string_add_scope(variable, true)
var _amount = amount

if is_undefined(amount) _amount = 1

if is_undefined(_variable)				 return "Missing variable scope"
if not variable_string_exists(_variable) return "Variable "+variable+" doesn't exist"

var value = variable_string_get(_variable) + _amount

variable_string_set(_variable, value)

return stitch("Added ",_amount," to "+variable+" (",value,")")
}



function togglevar(variable){
	
if not is_string(variable) return "Must provide variable name as string"

var _variable = string_add_scope(variable, true)

if is_undefined(_variable)				 return "Missing variable scope"
if not variable_string_exists(_variable) return "Variable "+variable+" doesn't exist"

var toggle = not variable_string_get(_variable)

variable_string_set(_variable, toggle)

return stitch("Toggled "+variable+" (",toggle _BOOL_STRING,")")
}



function roomobj(){

var text = []

for (i = 0; i <= instance_count-1; i++)
{
	var inst = instance_id[i]
	var name = object_get_name(inst.object_index)
	var entry = {}; with entry
	{
		id   = inst
		str  = stitch("(",id,")")
		func = function(){o_console.object = id; output_set(roomobj())}
	}
	
	var scoped_text = ""
	if inst == o_console.object scoped_text = " - current scope"
	
    array_push(text, name+" ", entry, scoped_text+"\n")
}
text[array_length(text)] = "\nClick on an ID to set the console scope"

return format_output(text, true, roomobj)
}



function objvar(obj){ with o_console {

if is_undefined(obj) obj = object
var list = variable_instance_get_names(obj)
array_sort(list, true)

for(var i = 0; i <= array_length(list)-1; i++)
{
	list[i] = {str: list[i]+"\n", scr: display, arg: string(obj)+"."+list[i]}
}

list[array_length(list)] = "\nClick on a variable to add to the display"
return format_output(list, true, -1)
}}




function select_obj(){

inst_select = true
display("o_console.inst_selecting_name", true)
return "Select object instance with cursor"
}




function reset_obj(obj){
	
if is_undefined(obj) obj = object
var _x = obj.x
var _y = obj.y
var _layer = obj.layer

instance_destroy(obj)
instance_create_layer(_x, _y, _layer, obj)
return "Object reset!"
}




function previous_menu(){

var _output = "No previous menu"

if script_exists(o_console.Output.tag_prev_menu) 
{
	_output = o_console.Output.tag_prev_menu()
	output_set(_output)
}

return _output
}




function color_make(r, g, b){ with o_console {

if is_undefined(r) r = 0
if is_undefined(g) g = 0
if is_undefined(b) b = 0

var _col = make_color_rgb(r, g, b)
var box = {str: "color ", col: _col}

if instance_exists(object)
{
	object._col = _col
	return {__embedded__: true, o: [box, stitch(object_get_name(object.asset_index),"._col set to ",_col)]}
}
else
{
	return {__embedded__: true, o: [box, string(_col)]}
}
}}




function color_get(_col){ with o_console {

if is_undefined(_col) _col = object._col
	
return stitch(
	"RBG ",color_get_red(_col),", ",color_get_green(_col),", ",color_get_blue(_col),"\n"+
	"HSV ",color_get_hue(_col),", ",color_get_saturation(_col),", ",color_get_value(_col),"\n"+
	"HEX ",color_to_hex(_col)
)
}}