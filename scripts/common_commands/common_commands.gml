
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