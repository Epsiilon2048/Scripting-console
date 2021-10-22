
function initialize_variable_display(){ with o_console {

var var_name_text_box = new_text_box("Name", "__variable_add_name__")
var var_add_button = new_cd_button("+", noscript)
var var_explanation = new_cd_text("Enter a variable name to add!", undefined)

var var_text_box = new_text_box("Variable", "__variable_add_var__") with var_text_box
{
	association = var_text_box
	button = var_add_button
	explanation_text = var_explanation
	draw_name = false
	initial_ghost_text = "variable"
	allow_printing = false
	att.exit_with_enter = false
	att.set_variable_on_input = false
	att.allow_scoped_exinput = false
	att.exit_with_enter = true
	att.length_min = string_length(initial_ghost_text)+12
	att.scoped_color = dt_variable

	__variable_add_var__ = ""

	color_method = function(text){
		var info = variable_string_info(text)
		button.can_click = info.exists and not (is_struct(info.value) and not (is_undefined(instanceof(info.value)) or instanceof(info.value) == "" or instanceof(info.value) == "weakref"))
		return gmcl_string_color(text, undefined)
	}
	
	autofill_method = function(command, char_pos){
		return gmcl_autofill_old(command, char_pos, {instance: true, assets: true, scope: true})
	}
	
	enter_func = function(){
		if text == "" return undefined
		__variable_add_var__ = ""
		var v = button.released_script()
		var constructor_object = v.exists and (is_struct(v.value) and not (is_undefined(instanceof(v.value)) or instanceof(v.value) == "" or instanceof(v.value) == "weakref")) 
		if not v.exists or constructor_object
		{
			explanation_text.enabled = true
			if constructor_object explanation_text.set("Cannot display; potential\nstack overflow")
			else explanation_text.set("Variable does not exist")
			explanation_text.color = dt_real
		}
	}
}

var type_text_box = new_text_box("Variable type", )

var scrubber_inc_text_box = new_value_box("Scrubber inc", )

with var_add_button
{
	var_box = var_text_box
	type_box = type_text_box
	scrubber_inc_box = scrubber_inc_text_box
	explanation_text = var_explanation
	can_click = false
	released_script = function(){
		explanation_text.enabled = false
		var variable = variable_string_info(var_box.text)
		if variable.exists and not (is_struct(variable.value) and not (is_undefined(instanceof(variable.value)) or instanceof(variable.value) == "" or instanceof(variable.value) == "weakref"))
		{
			var el
			
			switch asset_get_index(type_box.text)
			{
			default:
				if is_numeric(variable.value)		
				{
					if variable.value == c_white
					{
						el = new_color_box(var_box.text, var_box.text)
					}
					else
					{
						var p = float_count_places(variable.value, 4)
						if p == 0 p = 1
						else p = 1/(10*float_count_places(variable.value, 4))
						el = new_scrubber(var_box.text, var_box.text, p)
					}
				}
				else if is_string(variable.value)	el = new_text_box(var_box.text, var_box.text)
				else								el = new_display_box(var_box.text, var_box.text, true)
			break
			case new_text_box:
				el = new_text_box(var_box.text, var_box.text)
			break
			case new_scrubber:
				el = new_scrubber(var_box.text, var_box.text, scrubber_inc_box.value)
			break
			case new_display_box:
				el = new_display_box(var_box.text, var_box.text, true)
			break
			}
			
			el.instant_update = true
			
			dock.insert_vertical(0, el)
			var_box.__variable_add_name__ = ""
		}
		var_box.update_variable()
		
		return variable
	}
}

DISPLAY = new_console_dock("Display",[
	[var_add_button, var_text_box],
	new_separator(),
	[var_explanation],
])
with DISPLAY
{
	before_func = function(){ association = o_console.object }
	allow_element_dragging = true
}

add_console_element(DISPLAY)
}}