
mouse_on_console = false
clicking_on_console = false

run_in_console = false
run_in_embed   = false

gui_mouse_x = gui_mx
gui_mouse_y = gui_my

var old_font = draw_get_font()
draw_set_font(o_console.font)

ctx_menu_get_input()

if mouse_check_button_released(mb_right) ctx_menu_set([
	new_ctx_text("heya", function(){show_debug_message(1)}),
	new_ctx_text("heya 2", function(){show_debug_message(2)}),
	new_ctx_text("the option", function(){show_debug_message(3)}),
	new_scrubber("a test of skill","0.x",1),
	new_ctx_text("the cooler option", function(){show_debug_message(3)}),
])

COLOR_PICKER.get_input()
//cs_editor.association = o_console.colors

var was_clicking = clicking_on_console
var front = -1
for(var i = 0; i <= ds_list_size(elements)-1; i++)
{
	elements[| i].get_input()
	if not was_clicking and clicking_on_console 
	{
		front = i
		was_clicking = true
	}
}
if front != -1
{
	var el = elements[| front]
	ds_list_delete(elements, front)
	ds_list_insert(elements, 0, el)
}

if not mouse_check_button(mb_left) element_dragging = noone

console_measurer_inputs()

event_commands_exec(event_commands.step_end)
step ++

draw_set_font(old_font)