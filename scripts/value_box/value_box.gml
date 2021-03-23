// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function value_box(variable){ with o_console {

if is_undefined(variable) return "Must specify a variable"
else if not is_string(variable) return "Must provide variable as string"

var _variable = string_add_scope(variable)

if not variable_string_exists(_variable) return variable+" does not exist"

var v = new Console_value_box()
v.initialize(ds_list_size(value_boxes), 40, 40, _variable, vb_static)

ds_list_add(value_boxes, v)

return "Created value box from "+variable
}}