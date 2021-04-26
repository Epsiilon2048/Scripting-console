// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function value_box(variable, type){ with o_console {

static vb_y = 30

if is_undefined(variable) return "Must specify a variable"
else if not is_string(variable) return "Must provide variable as string"

var _variable = string_add_scope(variable, false)

if is_undefined(type) and not variable_string_exists(_variable) return variable+" does not exist"

var value = variable_string_get(_variable)

var vb
if not is_undefined(type) and (
	type == vb_asset or		type == vb_bool or		type == vb_color or	type == vb_counter or
	type == vb_grid or		type == vb_list or		type == vb_map or	type == vb_scrubber or
	type == vb_static or	type == vb_string or	type == vb_variable
)							vb = type
else if is_bool(value)		vb = vb_bool
else if is_numeric(value)	vb = vb_scrubber
else						vb = vb_static

var v = new Console_value_box()
v.initialize(ds_list_size(value_boxes), 40, vb_y, _variable, vb)

vb_y += 40

ds_list_add(value_boxes, v)

return "Created value box from "+variable
}}