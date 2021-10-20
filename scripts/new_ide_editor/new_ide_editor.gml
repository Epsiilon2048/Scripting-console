
function initialize_ide_editor(){

var editor = new_console_dock("Element adjusting", [
	new_console_dock("Dock", [
		"Name bar",
		[new_scrubber("Outline", "con.DOCK.name_outline_width", .1)],
		["Border", new_scrubber("W", "con.DOCK.name_wdist", 1), new_scrubber("H", "con.DOCK.name_hdist", 1)],
		new_separator(),
		"Elements",
		["Border", new_scrubber("W", "con.DOCK.element_wdist", 1),  new_scrubber("H", "con.DOCK.element_hdist", 1)],
		["Separation", new_scrubber("W", "con.DOCK.element_wsep", 1), new_scrubber("H", "con.DOCK.element_hsep", 1)],
		new_separator(),
		"Dropdown triangle",
		[new_scrubber("Base", "con.DOCK.dropdown_base", 1), new_scrubber("Hypotenuse", "con.DOCK.dropdown_hypotenuse", 1)],
		[new_scrubber("Border", "con.DOCK.dropdown_wdist", 1)],
	]),
	new_console_dock("Color picker", [
		new_scrubber("Outline", "con.COLOR_PICKER.outline", .1),
		new_scrubber("Border distance", "con.COLOR_PICKER.dist", 1),
		new_scrubber("Separation", "con.COLOR_PICKER.sep", 1),
		new_separator(),
		"Saturation/value square",
		new_scrubber("Square length", "con.COLOR_PICKER.svsquare_length", 1),
		new_scrubber("Dropper radius", "con.COLOR_PICKER.dropper_radius", 1),
		new_separator(),
		"Hue bar",
		new_scrubber("Bar width", "con.COLOR_PICKER.hstrip_width", 1),
		new_scrubber("Picker height", "con.COLOR_PICKER.hpicker_height", 1),
		new_separator(),
		"Color strip",
		new_scrubber("Strip height", "con.COLOR_PICKER.colorbar_height", 1),
	]),
	new_cd_button("Reset all", initialize_console_graphics)
])
editor.hide_all()

return editor
}