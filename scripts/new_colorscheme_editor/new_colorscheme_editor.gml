
function new_colorscheme_editor(){

var bm_box = new_text_box("Blend mode", "body_bm")
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

var
pln		= new_color_box("Plain     ", "plain"),		num	= new_color_box("Numeric   ", dt_real),			str = new_color_box("String    ", dt_string),
inst	= new_color_box("Instance  ", dt_instance),	scr	= new_color_box("Script    ", dt_method),		ast = new_color_box("Asset     ", dt_asset),
vari	= new_color_box("Variable  ", dt_variable),	bti	= new_color_box("Built-in  ", dt_builtinvar),	col = new_color_box("Color     ", dt_color),
tag		= new_color_box("Tag       ", dt_tag),		unk	= new_color_box("Unknown   ", dt_unknown),		dep = new_color_box("Deprecated", dt_deprecated)

var c = function(variable){call_color_box_ext(variable, gui_mx+20, gui_my+20, self, o_console.colors)}

var ide_colors = new_console_dock("IDE colors", [
	[new_color_box("Primary", "output"),new_color_box("Accent", "body_accent")],
	new_separator(),
	[new_color_box("Regular BG", "body"),bm_box],
	[new_value_box("Regular BG alpha", "body_alpha", true, .01, 4, 4, 0, 1, true, 2),new_value_box("Outline", "bevel", true, 1, 1, 2, 0, 30, false, 0)],
	[new_color_box("Solid BG", "body_real")],
	[new_value_box("Added solid BG alpha", "body_real_alpha", true, .01, 1, infinity, 0, 1, true, 2),],
	new_separator(),
	new_embedded_text({s:"Oh wild, theres a button right here", scr: show_message, arg: "congrats you can grasp the concept of buttons"}),
	[new_color_box("Button", "embed"), new_color_box("Hovering", "embed_hover")],
	new_separator(),
	new_embedded_text([{s:"c/0x", col: dt_color},{s:"1F", col: "red"},{s:"2E", col: "green"},{s:"3D", col: "blue"},]),
	[new_color_box("Red", "red"),		new_color_box("Green", "green"),	new_color_box("Blue", "blue"),new_color_box("Black", "black"),	new_color_box("White", "white")],
])
with ide_colors before_func = function(){association = o_console.colors}

var text_colors = new_console_dock("Text colors", [
	new_embedded_text([
		{s: "method",col: dt_method,scr: c, arg: dt_method},			{s: "(",col: dt_unknown,scr: c, arg: dt_unknown},
		{s: "0123",col: dt_real,scr: c, arg: dt_real},					{s: ", ",col: dt_unknown,scr: c, arg: dt_unknown},
		{s: "\"string\"",col: dt_string,scr: c, arg: dt_string},		{s: ", ",col: dt_unknown,scr: c, arg: dt_unknown},
		{s: "o_instance",col: dt_instance,scr: c, arg: dt_instance},	{s: ".",col: dt_unknown,scr: c, arg: dt_unknown},
		{s: "variable",col: dt_variable,scr: c, arg: dt_variable},		{s: ", ",col: dt_unknown,scr: c, arg: dt_unknown},
		{s: "s_asset",col: dt_asset,scr: c, arg: dt_asset},				{s: ")\n",col: dt_unknown,scr: c, arg: dt_unknown},
		
		{s: "#tag ",col: dt_tag,scr: c, arg: dt_asset,scr: c, arg: dt_tag},
		{s: "mouse_x",col: dt_builtinvar,scr: c, arg: dt_builtinvar}, {s: " = ",col: dt_unknown,scr: c, arg: dt_unknown},
		{s: "c/color",col: dt_color,scr: c, arg: dt_color},
		{s: "; unknown_term = ",col: dt_unknown,scr: c, arg: dt_unknown},
		{s: "deprecated_term",col: dt_deprecated,scr: c, arg: dt_deprecated},
	]),
	[pln,	num,	str],
	[inst,	scr,	ast],
	[vari,	bti,	col],
	[tag,	unk,	dep],
])
with text_colors before_func = function(){association = o_console.colors}

var editor = new_console_dock("Color scheme editor", [
	new_console_dock("Global settings", color_scheme_settings()),
	new_separator(),
	"Tools for editing the selected colorscheme",
	ide_colors,
	text_colors,
])

with editor before_func = function(){association = o_console.colors}
editor.before_func()
editor.hide_all()

return editor
}