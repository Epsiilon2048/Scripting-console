function draw_autofill_list(){ 
	
static at = o_console.AUTOFILL_LIST

with o_console {

var old_color = draw_get_color()
var old_font = draw_get_font()
var old_halign = draw_get_halign()
var old_valign = draw_get_valign()

draw_set_font(font)
draw_set_halign(fa_left)
draw_set_valign(fa_bottom)

var cw = string_width(" ")
var ch = string_height(" ")

var entries = (
	((autofill.macros == -1) ? 0 : (autofill.macros.max - autofill.macros.min+1)) +
	((autofill.methods == -1) ? 0 : (autofill.methods.max - autofill.methods.min+1)) +
	((autofill.assets == -1) ? 0 : (autofill.assets.max - autofill.assets.min+1)) +
	((autofill.instance == -1) ? 0 : (autofill.instance.max - autofill.instance.min+1)) +
	((autofill.scope == -1) ? 0 : (autofill.scope.max - autofill.scope.min+1))  
)-1

if entries <= -1 return -1

var asp = ch/at.char_height
var _text_sep = ceil(at.text_sep*asp)
var entries_height = (entries+1)*ch + (entries-1)*(_text_sep)

var _width = at.width*asp
var _height = ceil( min(entries_height+1, at.height*asp) )
var _border_w = round(at.border_w*asp)
var _border_h = round(at.border_h*asp)

var x1 = BAR.left
var y1 = OUTPUT.bottom
var x2 = x1 + _width + _border_w*2
var y2 = y1 - _height - _border_h*2 - 1

at.mouse_on = gui_mouse_between(x1, y1, x2, y2)
at.mouse_on_item = gui_mouse_between(x1, y1, x2-SCROLLBAR.width*asp-_border_w*2, y2)

if at.mouse_on 
{
	if not (at.mouse_dragging_top or at.mouse_dragging_right) and mouse_check_button_pressed(mb_left)
	{
		var _mouse_border = at.mouse_border*asp
		
		at.mouse_dragging_top = gui_mouse_between(x1, y2-_mouse_border, x2, y2+_mouse_border)
		at.mouse_dragging_right = gui_mouse_between(x2+_mouse_border, y1, x2-_mouse_border, y2)
		
		if at.mouse_dragging_top and at.mouse_dragging_right	window_set_cursor(cr_size_nesw)
		else if at.mouse_dragging_top							window_set_cursor(cr_size_ns)
		else if at.mouse_dragging_right							window_set_cursor(cr_size_we)
	}
}

if at.mouse_dragging_top or at.mouse_dragging_right
{
	if mouse_check_button(mb_left)
	{
		if at.mouse_dragging_right at.width	= max((gui_mx - x1 - _border_w*2)/asp, at.width_min)
		if at.mouse_dragging_top at.height = max((-gui_my + y1 - _border_h*2)/asp, at.height_min)
		
		_width = at.width*asp
		_height = ceil(at.height*asp)
		
		if not at.mouse_dragging_top _height = min(entries_height+2, _height)
		
		x2 = x1 + _width + _border_w*2
		y2 = y1 - _height - _border_h*2
	}
	else
	{
		at.mouse_dragging_top = false
		at.mouse_dragging_right = false
		
		window_set_cursor(cr_default)
	}
}

//at.scrollbar.set_pos(x1, y1, x2+o_console.SCROLLBAR.width*asp, y2)
at.scrollbar.set_pos(x1+1, y2+_border_h, x2-_border_w, y1-_border_h)
at.scrollbar.page_height = (entries_height + ceil(_text_sep/2))/asp
at.scrollbar.page_width = _width

var _scroll = floor(at.scrollbar.scroll*asp)

var _sidetext_bar = floor(at.sidetext_bar*asp)
var _sidetext_width = ceil(at.sidetext_width*asp)
var _sidetext_border = floor(at.sidetext_border*asp)

var sidetext_x = x1
var text_x = sidetext_x + _sidetext_bar + _sidetext_width + _sidetext_border
var text_y = y1 - _border_h + _scroll

draw_console_body(x1, y1, x2, y2)
draw_scrollbar(at.scrollbar)
clip_rect_cutout(x1+1, y2+_border_h+1, x2-_border_w*2-o_console.SCROLLBAR.width, y1-_border_h)

with global.scrvar
{
	self.asp = asp
	self.at = at
	self._text_sep = _text_sep
	self.sidetext_x = sidetext_x
	self._sidetext_bar = _sidetext_bar
	self._sidetext_width = _sidetext_width
	self._sidetext_border = _sidetext_border
	self.text_x = text_x
	self.text_y = text_y
	self.x1 = x1
	self.x2 = x2
	self.y1 = y1
	self.y2 = y2
	self.ch = ch
	self.item_index = 0
}

at.index += keyboard_check_pressed(vk_up) - keyboard_check_pressed(vk_down)

static draw_list = function(range, list, color_method){ with global.scrvar {

if range == -1 return undefined
var access = is_array(list) ? array_get : ds_list_find_value

for(var i = range.min; i <= range.max; i++)
{	
	if text_y-ch < y1-1
	{
		var this = color_method(access(list, i))
		var selected = at.index == item_index or (at.mouse_on_item and gui_mouse_between(x1, text_y, x2, text_y-ch))
		var color = o_console.colors[$ this.entry_color]

		if selected
		{
			draw_set_color(color)
			draw_rectangle(x1, text_y, x2, text_y-ch-1, false)
			
			draw_set_color(o_console.colors.body_real)
		}
		else
		{
			draw_set_color(color_set_hsv(color, color_get_hue(color)+at.sidetext_hue, at.sidetext_saturation, at.sidetext_value))
			draw_rectangle(sidetext_x, text_y, sidetext_x+_sidetext_bar+_sidetext_width, text_y-ch-1, false)
		
			draw_set_color(color)
			draw_rectangle(sidetext_x, text_y, sidetext_x+_sidetext_bar, text_y-ch-1, false)
			
			if at.dropshadow
			{
				draw_set_color(c_black)
				draw_text(sidetext_x+_sidetext_bar+_sidetext_border+1, text_y+2, this.text)
			}
			
			draw_set_color(color)
		}
		
		draw_text(sidetext_x+_sidetext_bar+_sidetext_border, text_y+1, this.text)
		draw_text(text_x, text_y+1, access(list, i))
	}
	
	item_index ++
	
	text_y -= ch + _text_sep
	
	if text_y < y2 break
}

}}

static macro_color = function(item){ 
	
	if is_undefined(o_console.console_macros[$ item])
	{
		return {entry_color: dt_real, text: "Macro"}
	}
	
	var type = o_console.console_macros[$ item].type
	var entry_color = dt_real
	
	if type == dt_method or type == dt_asset or type == dt_instance
	{
		entry_color = type
	}
	else if type == dt_variable
	{
		entry_color = dt_builtinvar
	}

	var type = o_console.console_macros[$ item].type
	var value = o_console.console_macros[$ item].value
	
	var text = undefined
	
	switch type
	{
	case dt_method: text = (value < 100000) ? "Built-in" : "Function"
	break
	case dt_variable: text = (string_pos("global.", value) == 1) ? "Global" : "Shortcut"
	break
	case dt_real: text = "Constant"
	break
	case dt_string: text = "Constant"
	}
	
	if is_undefined(text) text = "Macro"
	
	return {entry_color: entry_color, text: text}
}


static method_color	= function(item){ 
	return {entry_color: dt_method, text: "Function"}
}


static asset_color = function(item){

	var index = asset_get_index(item)
	var type = asset_get_type(item)
	var entry_color = dt_asset
	var type_name = "Asset"
	
	if type == asset_object and instance_exists(index) entry_color = dt_instance
	
	switch type
	{
	case asset_animationcurve: type_name = "Anim curve"
	break
	case asset_font: type_name = "Font"
	break
	case asset_object: type_name = "Object"
	break
	case asset_path: type_name = "Path"
	break
	case asset_room: type_name = "Room"
	break
	case asset_script: type_name = "Script"
	break
	case asset_sequence: type_name = "Sequence"
	break
	case asset_shader: type_name = "Shader"
	break
	case asset_sound: type_name = "Sound"
	break
	case asset_tiles: type_name = "Tiles"
	break
	case asset_timeline: type_name = "Timeline"
	}
	
	return {entry_color: entry_color, text: type_name}
}


static variable_color = function(item){
	
	var varstring = string(o_console.object.id)+"."+item
	var value = variable_instance_get(o_console.object, item)
	var text = "Variable"
	var entry_color = dt_variable
	
	if is_struct(value) 
	{
		text = "Struct"
		entry_color = dt_instance
	}
	else if is_array(value)
	{
		text = "Array"
	}
	else if is_method(value)
	{
		text = "Method"
	}
	else if is_real(value) and ds_map_exists(o_console.ds_types, varstring)
	{
		text = "Ds "+ds_type_to_string(o_console.ds_types[? varstring])
	}
	
	return {entry_color: entry_color, text: text}
}


static scope_color = function(item){
	
	var varstring = string_scope_to_id(string(o_console.char_pos_arg.scope)+"."+item)
	var value = variable_string_get(varstring)
	var text = "Variable"
	var entry_color = dt_variable
	
	if is_struct(value) 
	{
		text = "Struct"
		entry_color = dt_instance
	}
	else if is_array(value)
	{
		text = "Array"
	}
	else if is_method(value)
	{
		text = "Method"
		entry_color = dt_method
	}
	else if is_real(value) and ds_map_exists(o_console.ds_types, varstring)
	{
		text = "Ds "+ds_type_to_string(o_console.ds_types[? varstring])
	}
	
	return {entry_color: entry_color, text: text}
}


draw_list(autofill.scope, scope_variables, scope_color)
draw_list(autofill.instance, instance_variables, variable_color)
draw_list(autofill.assets, asset_list, asset_color)
draw_list(autofill.methods, method_list, method_color)
draw_list(autofill.macros, macro_list, macro_color)

shader_reset()

draw_set_color(old_color)
draw_set_font(old_font)
draw_set_halign(old_halign)
draw_set_valign(old_valign)
}}