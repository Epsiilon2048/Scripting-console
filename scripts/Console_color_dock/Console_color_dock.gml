
function new_color_dock(variable, use_varbox, use_rgb, use_hsv, use_hex, use_gml){

if is_undefined(variable) variable = ""
if is_undefined(use_varbox) use_varbox = true
if is_undefined(use_rgb) use_rgb = true
if is_undefined(use_hsv) use_hsv = true
if is_undefined(use_hex) use_hex = true
if is_undefined(use_gml) use_gml = true

var c = new Console_color_dock()
c.initialize(variable, use_varbox, use_rgb, use_hsv, use_hex, use_gml)
return c
}



function Console_color_dock() constructor{

format_console_element()

initialize = function(variable, use_varbox, use_rgb, use_hsv, use_hex, use_gml){
	
	docked = false
	using_varbox = use_varbox
	using_rgb = use_rgb
	using_hsv = use_hsv
	using_hex = use_hex
	using_gml = use_gml
	
	color = c_white
	
	x = 0
	y = 0
	left = 0
	top = 0
	right = 0
	bottom = 0
	
	var cd = o_console.COLOR_PICKER
	
	color_picker = new Console_color_picker()
	color_picker.initialize(variable)
	color_picker.size = cd.color_picker_dock_size
	color_picker.draw_box = false
	
	var elements = [color_picker]
	
	if use_varbox
	{
		var_text_box = new_text_box("Variable", "color_picker.variable").set_att(cd.var_att)
		var_text_box.draw_name = false
		var_text_box.initial_ghost_text = "Variable"
		var_text_box.color_method = gmcl_string_color
		var_text_box.autofill_method = gmcl_autofill_old
		
		array_push(elements, [var_text_box])
	}
	if use_rgb
	{
		r = 255
		g = 255
		b = 255
		
		r_text_box = new_scrubber("Red", "r", 1).set_att(cd.rgb_att)
		r_text_box.draw_name = false
		g_text_box = new_scrubber("Green", "g", 1).set_att(cd.rgb_att)
		g_text_box.draw_name = false
		b_text_box = new_scrubber("Blue", "b", 1).set_att(cd.rgb_att)
		b_text_box.draw_name = false
		
		array_push(elements, ["RGB", r_text_box, g_text_box, b_text_box])
	}
	if use_hsv
	{
		hue = 0
		sat = 255
		val = 255
		
		hsv_255 = false
	
		hue_text_box = new_scrubber("Hue", "hue", 1).set_att(cd.hsv_att)
		hue_text_box.draw_name = false
		sat_text_box = new_scrubber("Sat", "sat", 1).set_att(cd.hsv_att)
		sat_text_box.draw_name = false
		val_text_box = new_scrubber("Val", "val", 1).set_att(cd.hsv_att)
		val_text_box.draw_name = false
		
		var toggle_hsv_255 = function(){
			hsv_255 = not hsv_255
			hsv_255_button.set_name(hsv_255 ? "255" : "100")
		}
	
		hsv_255_button = new Cd_button() with hsv_255_button
		{
			initialize(other.hsv_255 ? "255" : "100", noscript)
			pressed_script = toggle_hsv_255
			draw_box = false
		}
		
		array_push(elements, ["HSV", hue_text_box, sat_text_box, val_text_box, "/", hsv_255_button])
	}
	if use_hex
	{
		hex = "FFFFFF"
		hex_text_box = new_text_box("Hex", "hex").set_att(cd.hex_att)
		hex_text_box.draw_name = false
		
		hex_text_box.char_filter = function(char){
			static hex_chars = "0123456789ABCDEF"
			char = string_upper(char)
			var new_char = ""
			
			for(var i = 1; i <= string_length(char); i++)
			{
				var _char = string_char_at(char, i)
				
				if string_pos(_char, hex_chars) new_char += _char
			}
			
			return new_char
		}
	}
	if use_gml
	{
		gml_text_box = new_text_box("GML", "color").set_att(cd.gml_att)
		gml_text_box.draw_name = false
		gml_text_box.value_conversion = real
	}
	
	if use_hex and use_gml	array_push(elements, ["Hex", hex_text_box, "GML", gml_text_box])
	else if use_hex			array_push(elements, ["Hex", hex_text_box])
	else if use_gml			array_push(elements, ["GML", gml_text_box])
	
	self_dock = new_console_dock("Color dock", elements)
	self_dock.association = self
}



get_input = function(){
		
	if using_rgb
	{
		r = color_get_red(color_picker.color)
		g = color_get_green(color_picker.color)
		b = color_get_blue(color_picker.color)
	}
	
	if using_hex hex = color_to_hex(color_picker.color)
		
	if using_hsv and not (hue_text_box.scoped or sat_text_box.scoped or val_text_box.scoped)
	{
		val = color_get_value(color_picker.color)
		if not hsv_255 val /= 2.55
			
		if color_get_hue(color_picker.color) 
		{
			hue = color_get_hue(color_picker.color)
			if not hsv_255 hue /= 2.55
		}
			
		if val 
		{
			sat = color_get_saturation(color_picker.color)
			if not hsv_255 sat /= 2.55
		}
	}
		
	if using_hsv 
	{
		var hsv = hsv_255 ? 1 : 2.55
		var old_hsv = hue+sat+val
		hue_text_box.att.value_max = hsv_255 ? 255 : 100
	}
	if using_rgb var old_rgb = r+g+b
	if using_hex var old_hex = hex
		
	if docked
	{
		self_dock.x = x
		self_dock.y = y
		self_dock.docked = true
		self_dock.dock = dock
	}
	
	color_picker.size = o_console.COLOR_PICKER.color_picker_dock_size
	self_dock.get_input()
	
	left = self_dock.left
	top = self_dock.top
	right = self_dock.right
	bottom = self_dock.bottom
	
	if color_picker.color_changed
	{
		if using_hsv
		{
			hue = color_picker.hue*hsv
			sat = color_picker.sat*hsv
			val = color_picker.val*hsv
		}
	}
	else
	{
		var color_changed = false
		if using_rgb and (r_text_box.text_changed or g_text_box.text_changed or b_text_box.text_changed)
		{
			color_picker.color = make_color_rgb(r, g, b)
			color_picker.hue = color_get_hue(color_picker.color)
			color_picker.sat = color_get_saturation(color_picker.color)
			color_picker.val = color_get_value(color_picker.color)
			color_changed = true
		}
		else if using_hex and hex_text_box.text_changed
		{
			color_picker.color = hex_to_color(hex)
			color_picker.hue = color_get_hue(color_picker.color)
			color_picker.sat = color_get_saturation(color_picker.color)
			color_picker.val = color_get_value(color_picker.color)
			color_changed = true
		}
		else if using_gml and gml_text_box.text_changed
		{
			color_picker.color = color
			color_picker.hue = color_get_hue(color_picker.color)
			color_picker.sat = color_get_saturation(color_picker.color)
			color_picker.val = color_get_value(color_picker.color)
			color_changed = true
		}
		else if using_hsv and (hue_text_box.text_changed or sat_text_box.text_changed or val_text_box.text_changed)
		{
			color_picker.color = make_color_hsv(hue*hsv, sat*hsv, val*hsv)
			color_picker.hue = hue*hsv
			color_picker.sat = sat*hsv
			color_picker.val = val*hsv
			color_changed = true
		}
		
		if color_changed
		{
			var _association = is_undefined(color_picker.association) ? (docked ? dock.association : self) : color_picker.association
			with _association variable_string_set(other.color_picker.variable, other.color_picker.color)
			
			color_picker.update_dropper_positions()
		}
	}
}
	
	
	
draw = function(){
	if not self_dock.dragging self_dock.draw()
}
}