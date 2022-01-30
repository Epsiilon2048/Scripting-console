
function new_textbox_editor(text_box){

var editor = new_console_dock("Advanced text box editor",[
	[new_display_box("Text", "text", false)],
	[new_display_box("Value", "value", false)],
	[new_display_box("Added float places", "added_float_places", false)],
	
	new_separator(),
	[new_text_box("Name", "name")],
	[new_text_box("Ghost text", "initial_ghost_text")],
	[new_text_box("Variable", "variable")],
	[new_text_box("Ghost text", "initial_ghost_text")],
	["Enabled",new_cd_checkbox(undefined,"enabled")],
	["Show name",new_cd_checkbox(undefined,"draw_name")],
	["Instant update",new_cd_checkbox(undefined,"instant_update")],
	["Include in dock printing",new_cd_checkbox(undefined,"allow_printing")],

	new_console_dock("Shared Attributes", [
		["User input",new_cd_checkbox(undefined,"att.allow_input")],
		["Update with variable",new_cd_checkbox(undefined,"att.allow_exinput")],
		["Update with variable when scoped",new_cd_checkbox(undefined,"att.allow_scoped_exinput")],
		["Allow alpha characters",new_cd_checkbox(undefined,"att.allow_alpha")],
		["Draggable",new_cd_checkbox(undefined,"att.allow_dragging")],
		["Select all on click",new_cd_checkbox(undefined,"att.select_all_on_click")],
		["Set variable on input",new_cd_checkbox(undefined,"att.set_variable_on_input")],
		["Draw box",new_cd_checkbox(undefined,"att.draw_box")],
		["Length between",new_scrubber(undefined,"att.length_min", 1),"and",new_scrubber(undefined,"att.length_max", 1)],
		["Lock text length",new_cd_checkbox(undefined,"att.lock_text_length")],
	
		[new_scrubber("Float places","att.float_places", 1)],
		["Clamp between",new_scrubber(undefined,"att.value_min", 1),"and",new_scrubber(undefined,"att.value_max", 1)],
		[new_scrubber("Arrow key step","att.incrementor_step", .5)],
		["Is scrubber",new_cd_checkbox(undefined, "att.scrubber")],
		[new_scrubber("Scrubber step","att.scrubber_step", .5)],
		[new_scrubber("Scrubber pixels per step","att.scrubber_pixels_per_step", 1)],
	]),
])
editor.association = text_box

return editor
}