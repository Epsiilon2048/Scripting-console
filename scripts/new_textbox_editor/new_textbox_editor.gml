
function new_textbox_editor(text_box){

var editor = new_console_dock("Basic text box editor",[
	[new_text_box("Label", "name")],
	[new_text_box("Variable", "variable")],
	["Visible",new_cd_checkbox(undefined,"enabled"),"  Allow input",new_cd_checkbox(undefined,"att.allow_input")],
	["Select text on click",new_cd_checkbox(undefined,"att.select_all_on_click")],
	new_separator(),
	new_cd_text("Scrubber settings", dt_tag),
	["Scrubber",new_cd_checkbox(undefined, "att.scrubber")," ",new_scrubber("Step","att.scrubber_step", .5)],
	["Clamp between",new_scrubber(undefined,"att.value_min", 1),"and",new_scrubber(undefined,"att.value_max", 1)],
])
editor.association = text_box

return editor
}