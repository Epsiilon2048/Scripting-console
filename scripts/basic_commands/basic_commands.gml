// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function ar(array_name, index, value){

var _array_name = array_name

if is_string(array_name) _array_name = string_add_scope(array_name)

if is_undefined(_array_name)
{
	return "Missing variable scope"
}
else if is_undefined(value)
{
	var array = array_name
	
	if is_string(array) var array = variable_string_get(_array_name)
	
	return array[index]
}
else
{
	if variable_string_exists(_array_name)
	{
		var array = variable_string_get(_array_name)
	
		if is_array(array)
		{
			array[index] = value
			variable_string_set(_array_name, array)
		
			return stitch("Set "+array_name+"[",index,"] to ",value)
		}
		else
		{
			return array_name+" is not an array"
		}
	}
	else return "Array "+array_name+" does not exist"
}
}
	
	
	
	
function addvar(variable, value){

if is_undefined(value) value = 1

var _variable = string_add_scope(variable)

if is_undefined(_variable)
{
	return "Missing variable scope"
}
else if variable_string_exists(_variable)
{
	var _value = variable_string_get(_variable)
	
	variable_string_set(_variable, _value+value)
	return stitch("Added ",value," to "+variable+" (",_value+value,")")
}
else
{
	return "Variable "+variable+" does not exist"
}
}




function togglevar(variable){
	
var _variable = string_add_scope(variable)
var toggle

if is_undefined(_variable)
{
	return "Missing variable scope"
}
else if variable_string_exists(_variable)
{
	var toggle = not variable_string_get(_variable)
	
	variable_string_set(_variable, toggle)
	return stitch("Toggled "+variable+" (",toggle _BOOL_STRING,")")
}
else
{
	return "\""+variable+"\" does not exist"
}
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
	
return {__embedded__: true, o: [{str: "color ", col: _col},stitch(color_get_red(_col),", ",color_get_green(_col),", ",color_get_blue(_col))]}
}}