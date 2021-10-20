
function initialize_cs_editor(){

var bm_box = new_text_box("blendmode", "body_bm")
with bm_box
{
	att.length_min = string_length("subtract")
	att.select_all_on_click = true
	att.set_variable_on_input = false
	att.text_color = dt_real
	att.scoped_color = dt_real
	value_conversion = function(val){
		att.text_color = dt_real
		switch val
		{
			default: 
				att.text_color = "plain"
				return value
			case "normal": return bm_normal
			case "add": return bm_add
			case "subtract": return bm_subtract
		}
		
		set_boundaries()
	}
	
	update_variable = function(){

		var old_text = text
		value = o_console.colors.body_bm
		
		att.text_color = dt_real
		switch value
		{
			default: 
				text = "unknown" 
				att.text_color = "plain"
				break
			case bm_normal: text = "normal" break
			case bm_add: text = "add" break
			case bm_subtract: text = "subtract" break
		}
		
		if string_length(text) != string_length(old_text) set_boundaries()
	}
}

var editor = new_console_dock("Color scheme editor", [
	new_cd_checkbox("","0.f"),
	[new_console_dock("IDE colors", [
		new_color_box("Primary", "output"),
		new_separator(),
		[new_color_box("Body     ", "body"), new_color_box("Solid ", "body_real"), new_color_box("Accent", "body_accent")],
		[new_value_box("alpha    ", "body_alpha", true, .01, 4, 4, 0, 1, true, 2), new_value_box("alpha ", "body_real_alpha", true, .01, 1, infinity, 0, 1, true, 2)],
		[bm_box, new_value_box("outline  ", "bevel", true, 1, 1, 2, 0, 30, false, 0)],
		new_separator(),
		[new_color_box("Button", "embed"), new_color_box("Hovering", "embed_hover")],
		new_separator(),
		[new_color_box("Red  ", "red"),		new_color_box("Green", "green"),	new_color_box("Blue ", "blue")],
		[new_color_box("Black", "black"),	new_color_box("White", "white")],
	]),""],
	[new_console_dock("Text colors", [
		[new_color_box("Plain     ", "plain"),		new_color_box("Numeric   ", dt_real),	new_color_box("Asset     ", dt_asset),		new_color_box("Instance  ", dt_instance)],
		[new_color_box("String    ", dt_string),	new_color_box("Color     ", dt_color),	new_color_box("Built-in  ", dt_builtinvar),	new_color_box("Tag       ", dt_tag)],
		[new_color_box("Variable  ", dt_variable),	new_color_box("Script    ", dt_method),	new_color_box("Unknown   ", dt_unknown),	new_color_box("Deprecated", dt_deprecated)],
	]),
	new_cd_button("Reset all", initialize_color_schemes)
	],
])
with editor before_func = function(){association = o_console.colors}
editor.before_func()
editor.hide_all()

return editor
}