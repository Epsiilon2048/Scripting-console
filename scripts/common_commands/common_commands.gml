
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



function roomobj(){ with o_console {

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

var instances = []

var i = 0
while object_exists(i) 
{
	if instance_exists(i)
	{
		array_push(instances,
		{
			name: object_get_name(i),
			ind: i,
			id: i.id,
			__selected__: instance_exists(object) and i.id == object.id
		})
	}
	i++
}

var text = generate_embed_list(instances, ["name", "ind", "id"], {scr: roomobj, vari: "o_console.object", arg: inst, output: true}, "id")

array_push(text, 
	"\n"+((instance_count == 1) ? "\nIt's just me!" : "")+"\n",
	"Click on an object to set the console scope"
)

return format_output(text, true, roomobj, "Objects in room")
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
		ind: instance_id[i].object_index,
		id: instance_id[i],
		__selected__: instance_exists(object) and instance_id[i] == object.id
	}
}

var text = generate_embed_list(instances, ["name", "ind", "id"], {scr: roomobj, vari: "o_console.object", arg: inst, output: true}, "id")

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