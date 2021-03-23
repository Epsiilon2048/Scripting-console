
function value_box_inputs(){ with o_console {

var cleanup = false

for(var i = 0; i <= ds_list_size(value_boxes)-1; i++)
{
	if is_struct(value_boxes[| i]) value_boxes[| i].get_input()
	
	if value_box_deleted 
	{
		cleanup = true
		
		COLOR_PICKER.variable = ""
		CTX_MENU.ctx = undefined
		value_boxes[| i] = undefined
		
		value_box_deleted = false
	}
}

if cleanup
{
	for(var i = 0; i <= ds_list_size(value_boxes)-1; i++)
	{
		if is_undefined(value_boxes[| i])
		{
			ds_list_delete(value_boxes, i)
			i--
		}
		else
		{
			value_boxes[| i].index = i
		}
	}
}
}}

function draw_value_boxes(){ with o_console {

for(var i = ds_list_size(value_boxes)-1; i >= 0; i--)
{
	if is_struct(value_boxes[| i]) value_boxes[| i].draw()
}
}}