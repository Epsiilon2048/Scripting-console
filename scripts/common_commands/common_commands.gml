
function dealwith_array(array, index, value){

if is_undefined(array) return "Must provide array!"

var _array
var _array_name = ""

if is_string(array) 
{
	_array_name = string_add_scope(array, true)
	
	if is_undefined(_array_name)				return "Missing variable scope"
	if not variable_string_exists(_array_name)	return "Array "+array+" doesn't exist"
	
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
	
	if is_undefined(varstring)					return "Missing variable scope"
	if not variable_string_exists(varstring)	return "Struct \""+struct+"\" doesn't exist"
	
	struct = variable_string_get(varstring)
}

if not is_struct(struct) return "Variable is not a struct"

if argument_count == 1 return struct

if argument_count == 2
{
	if variable_struct_exists(struct, argument[1])	return struct[$ argument[1]]
	else											return "Key "+string(argument[1])+" in struct does not exist"
}

for(var i = 1; i <= argument_count-2; i+=2)
{
	struct[$ argument[i]] = argument[i+1]
}
return "Set struct values"
}

	
	
	
function dealwith_ds_map(ds_map){

if is_undefined(ds_map) return "Must provide ds_map! (if you're looking for the help command, type \"help\"!)"

if is_string(ds_map)
{
	var varstring = string_add_scope(ds_map, true)
	
	if is_undefined(varstring)					return "Missing variable scope"
	if not variable_string_exists(varstring)	return "ds map \""+ds_map+"\" doesn't exist"
	
	ds_map = variable_string_get(varstring)
}

if not is_numeric(ds_map)				return "Invalid ds map index"
if not ds_exists(ds_map, ds_type_map)	return "ds map at index "+string(ds_map)+" does not exist"

if argument_count == 1 return ds_map_to_struct(ds_map)

if argument_count == 2 
{
	if ds_map_exists(ds_map, argument[1])	return ds_map[? argument[1]]
	else									return "Key "+string(argument[1])+" in ds map does not exist"
}

for(var i = 1; i <= argument_count-2; i+=2)
{
	ds_map[? argument[i]] = argument[i+1]
}
return "Set ds map values"
}

	
	
	
function dealwith_ds_list(ds_list, index, value){

if is_undefined(ds_list) return "Must provide ds list!"

if is_string(ds_list)
{
	var varstring = string_add_scope(ds_list, true)
	
	if is_undefined(varstring)					return "Missing variable scope"
	if not variable_string_exists(varstring)	return "ds list \""+ds_list+"\" doesn't exist"
	
	ds_list = variable_string_get(varstring)
}

if not is_numeric(ds_list)				return "Invalid ds list index"
if not ds_exists(ds_list, ds_type_list) return "ds list at index "+string(ds_list)+" doesn't exist"

if is_undefined(index)	return ds_list_to_array(ds_list)
if index < 0			return "Invalid index"

if is_undefined(value) 
{
	if index >= ds_list_size(ds_list)	return stitch("Index ",index," exceeds ds list size (",ds_list_size(ds_list),")")
	else								return ds_list[| index]
}

ds_list[| index] = value
return stitch("Set item ",value," in ds list to ",value)
}


function dealwith_ds_grid(ds_grid, x, y, value){

if is_undefined(ds_grid) return "Must provide ds grid!"

if is_string(ds_grid)
{
	var varstring = string_add_scope(ds_grid, true)
	
	if is_undefined(varstring)					return "Missing variable scope"
	if not variable_string_exists(varstring)	return "ds grid \""+ds_grid+"\" doesn't exist"
	
	ds_grid = variable_string_get(varstring)
}

if not is_numeric(ds_grid)				return "Invalid coordinates"
if not ds_exists(ds_grid, ds_type_grid)	return "ds grid at index "+string(ds_grid)+" doesn't exist"

if is_undefined(x)							return "Hey, uh, haven't quite worked out how ds grids are gonna be displayed, give it a bit of time, yeah?"
if is_undefined(y)							return "Must provide y coordinate!"

if not is_numeric(x) or not is_numeric(y) or x < 0 or y < 0	return "Invalid ds grid coordinates"

if is_undefined(value)
{
	if x >= ds_grid_width(ds_grid) or y >= ds_grid_height(ds_grid)	return stitch("Index (",x,", ",y,") exceeds ds grid boundaries (",ds_grid_width(ds_grid),", ",ds_grid_height(ds_grid),")")
	else															return ds_grid[# x, y]
}

ds_grid[# x, y] = value
return stitch("Set position (",x,", ",y,") in ds grid to ",value)
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

if is_undefined(_variable)				 return "Missing variable scope"
if not variable_string_exists(_variable) return "Variable "+variable+" doesn't exist"

if is_string(amount)
{
	var varstring = string_add_scope(amount, true)
	
	if is_undefined(varstring)					return "Missing variable scope for amount"
	if not variable_string_exists(varstring)	return "Variable "+amount+" doesn't exist"
	
	_amount = variable_string_get(varstring)
}
else if is_undefined(amount) 
{
	amount = 1
	_amount = 1
}

var value = variable_string_get(_variable) + _amount

variable_string_set(_variable, value)

return stitch("Added ",amount," to "+variable+" (",value,")")
}




function divvar(variable, amount){

if not is_string(variable)	return "Must provide variable name as string"
if is_undefined(amount)		return "Must provide value to divide by"

var _variable = string_add_scope(variable, true)
var _amount = amount

if is_undefined(_variable)				 return "Missing variable scope"
if not variable_string_exists(_variable) return "Variable "+variable+" doesn't exist"

if is_string(amount)
{
	var varstring = string_add_scope(amount, true)
	
	if is_undefined(varstring)					return "Missing variable scope for amount"
	if not variable_string_exists(varstring)	return "Variable "+amount+" doesn't exist"
	
	_amount = variable_string_get(varstring)
}

if _amount == 0 return "Cannot divide by 0!"

var value = variable_string_get(_variable) / _amount

variable_string_set(_variable, value)

return stitch("Divided ",variable," by ",amount," (",value,")")
}



function multvar(variable, amount){

if not is_string(variable)	return "Must provide variable name as string"
if is_undefined(amount)		return "Must provide value to multiply by"

var _variable = string_add_scope(variable, true)
var _amount = amount

if is_undefined(_variable)				 return "Missing variable scope"
if not variable_string_exists(_variable) return "Variable "+variable+" doesn't exist"

if is_string(amount)
{
	var varstring = string_add_scope(amount, true)
	
	if is_undefined(varstring)					return "Missing variable scope for amount"
	if not variable_string_exists(varstring)	return "Variable "+amount+" doesn't exist"
	
	_amount = variable_string_get(varstring)
}

var value = variable_string_get(_variable) * _amount

variable_string_set(_variable, value)

return stitch("Multiplied ",variable," by ",amount," (",value,")")
}




function togglevar(variable){
	
if not is_string(variable) return "Must provide variable name as string"

var _variable = string_add_scope(variable, true)

if is_undefined(_variable)				 return "Missing variable scope"
if not variable_string_exists(_variable) return "Variable "+variable+" doesn't exist"

var toggle = not variable_string_get(_variable)

variable_string_set(_variable, toggle)

return stitch("Toggled "+variable+" (",toggle ? "true" : "false",")")
}


function roomobj(){

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

var obj_spaces = string_repeat(" ", longest_object - string_length( obj_collumn ))
var ind_spaces = string_repeat(" ", longest_index - string_length( ind_collumn ))
//var text = ["  "+obj_collumn+obj_spaces+ind_collumn+ind_spaces+id_collumn+"\n"]

//for (var i = 0; i <= instance_count-1; i++)
//{
//	var inst = instance_id[i]
//	
//	var selected = inst == o_console.object 
//	
//	var scoped_before
//	var scoped_after
//	var entry = {}
//	
//	var obj_spaces = string_repeat(" ", longest_object - string_length( object_get_name(inst.object_index) ))
//	var ind_spaces = string_repeat(" ", longest_index - string_length( inst.object_index ))
//	
//	if selected
//	{
//		scoped_before = {str: "[ ", col: dt_unknown}
//		scoped_after = {str: " ]", col: dt_unknown}
//		
//		entry = {str: object_get_name(inst.object_index), col: "embed_hover"}
//	}
//	else
//	{
//		var scoped_before = "  "
//		var scoped_after = ""
//		
//		with entry
//		{
//			str = object_get_name(inst.object_index)
//			scr = roomobj
//			vari = "o_console.object"
//			arg = inst
//			output = true
//		}
//	}
//	
//    array_push(text, scoped_before,entry,{str: stitch(obj_spaces,inst.object_index,ind_spaces,inst), col: selected ? "embed_hover" : "output"},scoped_after,"\n")
//}

var instances = array_create(instance_count)

for (var i = 0; i <= instance_count-1; i++)
{
	instances[i] = 
	{
		name: object_get_name(instance_id[i].object_index),
		ind: instance_id[i].object_index,
		id: instance_id[i],
		__selected__: instance_exists(object) and instance_id[i] == object.id
	}
}

var text = generate_embed_list(instances, ["name", "ind", "id"], {scr: roomobj, vari: "o_console.object", arg: inst, output: true}, "id")

array_push(text, 
	"\n"+((instance_count == 1) ? "\nIt's just me!" : "")+"\n",
	"Click on an object to set the console scope"
)

return format_output(text, true, roomobj, "Instances in room")
}



function objvar(obj){ with o_console {

if is_undefined(obj) obj = object

var _obj
var struct
if is_string(obj)
{
	var varscope = string_add_scope(obj, true)
	if is_undefined(varscope) return "Missing scope"
	if not variable_string_exists(varscope) return obj+" does not exist"
	
	_obj = variable_string_get(varscope)
	if not is_struct(_obj) return "Must provide struct or instance"
	
	struct = true
}
else if is_numeric(obj) or is_struct(obj)
{
	struct = is_struct(obj)
	
	if not struct and not instance_exists(obj) return "Must profide struct or instance"
	
	_obj = obj
}
else return "Must profide struct or instance"

var list = struct ? variable_struct_get_names(_obj) : variable_instance_get_names(_obj)
array_sort(list, true)

if not (struct and not is_string(obj)) 
{
	for(var i = 0; i <= array_length(list)-1; i++)
	{
		list[i] = {str: list[i]+"\n", scr: value_box, arg: string(obj)+"."+list[i]}
	}
	
	array_push(list, "\nClick on a variable to create a value box")
}
	
return format_output(list, not (struct and not is_string(obj)), -1, "Variables in "+(struct ? "struct" : "instance "+string(_obj)))
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




function color_get(_col){

return format_output([
	{str: "[COLOR]\n", col: _col},
	{str: "GML       ", col: "embed_hover"},string(_col)+"\n",
	{str: "RBG       ", col: "embed_hover"},stitch(color_get_red(_col),", ",color_get_green(_col),", ",color_get_blue(_col),"\n"),
	{str: "HSV (255) ", col: "embed_hover"},stitch(color_get_hue(_col),", ",color_get_saturation(_col),", ",color_get_value(_col),"\n"),
	{str: "HSV (100) ", col: "embed_hover"},stitch(color_get_hue(_col)/2.55,", ",color_get_saturation(_col)/2.55,", ",color_get_value(_col)/2.55,"\n"),
	{str: "HEX       ", col: "embed_hover"},color_to_hex(_col)
], true, -1, "Color properties of "+string(_col))
}