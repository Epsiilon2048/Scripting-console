
function Autofill_sublist() constructor {

enabled = true

list = []

show_all_if_blank = false
show_all_always = false

list = undefined
self.min = 0
self.max = infinity

color = undefined

get = noscript

format = format_autofill_item


sort = function(){
	if is_array(list)	array_sort(list, true)
	else				ds_list_sort(list, true)
}


get_size = function(){
	
	if is_numeric(list)		return ds_list_size(list)
	else if	is_array(list)	return array_length(list)
	else					return 0
}


get_range = function(term){
	
	var minmax
	if enabled
	{
		if show_all_always or (show_all_if_blank and term == "")
		{
			minmax = {min: 0, max: get_size()}
			if minmax.max == 0 minmax = -1//{min: -1, max: -1}
		}
		else minmax = autofill_in_list(list, term, undefined)
	}
	else minmax = -1//{min: -1, max: -1}
	
	if minmax == -1
	{
		self.min = -1
		self.max = -1
	}
	else
	{
		self.min = minmax.min
		self.max = minmax.max
	}
	
	return minmax
}
}



function format_autofill_item(item){

if not is_struct(item) item = new Autofill_item(item, item)
else if instanceof(item) != "Autofill_item" item = struct_replace(new Autofill_item(), item)
 
return item
}



function Autofill_item(name="", value="", side_text=undefined, color=undefined) constructor {

if is_numeric(name) self.name = string_format_float(name, float_count_places(name, 3))
else self.name = string(name)

self.value = value
self.side_text = side_text
self.color = color

if is_undefined(value) and name != "undefined" and name != "null" self.value = name
}



function Console_autofill_list() constructor{

list = -1
lists = -1

association = noone

initialize = function(){

	list = ds_list_create()
	lists = ds_list_create()
	include_side_text = false
	side_text_override = undefined
	
	mouse_index = -1
	key_index = -1
	
	x = 0
	y = 0
	left = 0
	top = 0
	right = 0
	bottom = 0
	
	width = 400
	height = 150
	
	sidetext_bar_length = 15
	
	entries_width = 0
	entries_height = 0
	
	entries_length = 0
	
	scrollbar = new Console_scrollbar() with scrollbar {
		initialize()
		wbar_enabled = true
		hbar_enabled = true
		condensed = true
		wresize = true
		hresize = true
	}
	
	mouse_on = false
	clicking = false	
}


sort = noscript
before_get = noscript


clear = function(){
	entries_length = 0
	ds_list_clear(self.list)
	ds_list_clear(self.lists)
}


add = function(list){
	
	var size = ds_list_size(self.list)
	
	// Get minmax of list, if provided
	var _min
	var _max
	var list_len
	var color = undefined
	var format = format_autofill_item
	if is_struct(list)
	{
		list_len = is_array(list.list) ? array_length(list.list) : ds_list_size(list.list)
		
		_min = list.min
		_max = min(list_len, list.max)
		
		color = list.color
		format = list.format
		
		list = list.list
	}
	else
	{
		list_len = is_array(list) ? array_length(list) : ds_list_size(list)
		_min = 0
		_max = list_len
	}
	
	// Convert to ds list
	if is_array(list) for(var i = _min; i <= _max-1; i++)
	{
		ds_list_add(self.list, list[i])
	}
	else if is_numeric(list) for(var i = _min; i <= _max-1; i++)
	{
		ds_list_add(self.list, list[| i])
	}
	
	// Convert items to Autofill item objects
	for(var i = size; i <= ds_list_size(self.list)-1; i++)
	{	
		self.list[| i] = format(self.list[| i])
		
		if is_undefined(self.list[| i].color) self.list[| i].color = color
		
		if not is_undefined(self.list[| i].side_text) and self.list[| i].side_text != "" include_side_text = true
		
		entries_length = max(entries_length, string_length(self.list[| i].name))
	}
	
	if not is_undefined(side_text_override) include_side_text = side_text_override
}


add_to_lists = function(list){
	ds_list_add(lists, list)
}


set = function(list){
	
	ds_list_clear(self.list)
	ds_list_clear(self.lists)
	
	include_side_text = false
	add(list)
	add_to_lists(list)
	
	sort()
}


set_multiple = function(lists){

	clear()

	for(var i = 0; i <= array_length(lists)-1; i++)
	{
		add(lists[i])
		add_to_lists(lists[i])
	}
	
	sort()
}


get = function(term){
	
	ds_list_clear(list)
	entries_length = 0
	before_get()
	
	for(var i = 0; i <= ds_list_size(lists)-1; i++)
	{
		var li = lists[| i]
		if is_struct(li) and instanceof(li) == "Autofill_sublist" with li
		{
			get(term)
			sort()
			get_range(term)
		}
		else
		{
			var minmax = autofill_in_list(li, term, undefined)
			
			if minmax == -1 li = []
			else
			{
				//show_debug_message(minmax.max - minmax.min)
				var newli = array_create(minmax.max - minmax.min)
			
				if is_numeric(li) li = ds_list_to_array(li)
			
				if is_array(li)	array_copy(newli, 0, li, minmax.min, minmax.max - minmax.min)
			
				li = newli
			}
		}
		
		add(li)
	}
	
	key_index = ds_list_size(list)
	
	scrollbar_get_boundaries()
	scrollbar.set_scroll_y(9999999999999)
}


get_array = function(){
	return ds_list_to_array(list)
}


destroy = function(){
	
if ds_exists(ds_type_list, list) ds_list_destroy(list)
if ds_exists(ds_type_list, lists) ds_list_destroy(lists)
}	
	
	
scrollbar_get_boundaries = function(){

	var cw = string_width("W")
	var ch = string_height("W")
	
	var _sidetext_bar_length = sidetext_bar_length*include_side_text*cw
	
	entries_width = cw*(entries_length+3) + _sidetext_bar_length
	entries_height = ch*ds_list_size(list)+1
	
	var _width = width + _sidetext_bar_length
	var _height = min(height, entries_height+1)
	
	if not include_side_text
	{
		_width = min(_width, entries_width + cw*3)
	}
	
	left = x
	top = y + (height-_height)
	right = left+_width-1
	bottom = top+_height-1
	
	scrollbar.wbar_enabled = _width < entries_width
	scrollbar.hbar_enabled = height < (entries_height+1)
	
	scrollbar.set_boundaries(entries_width, entries_height, left, top, right, bottom)
}


get_input = function(){
	
	if ds_list_size(list) == 0 exit
	
	var tb = o_console.TEXT_BOX
	
	var cw = string_width("W")
	var ch = string_height("W")

	scrollbar_get_boundaries()
	scrollbar.get_input()
	
	var tab = keyboard_check_pressed(vk_f1)
	if tab
	{
		key_index --
		if key_index < 0
		{
			key_index = ds_list_size(list)-1
			scrollbar.set_scroll_y(999999)
		}
		else
		{
			scrollbar.set_scroll_y(
				min(scrollbar.scroll_y, (key_index-1.5)*ch)
				// Could be better but ehh
			)
		}
	}
	
	clicking = mouse_check_button(mb_left) and (clicking or mouse_on)
	
	if /*not mouse_on_console and */gui_mouse_between(left, top, right, bottom)
	{
		if not clicking and not (not mouse_on and mouse_check_button(mb_left))
		{
			//mouse_on_console = true
			mouse_on = true
			
			var prev_index = mouse_index
			mouse_index = floor((gui_my-top + scrollbar.scroll_y)/ch)
			
			if prev_index != mouse_index
			{
				scrollbar.set_scroll_y(min(scrollbar.scroll_y, mouse_index*ch))
			}
		}
	}	
	else if mouse_on and not clicking
	{
		mouse_on = false
		mouse_index = -1
	}
	else if not clicking
	{
		mouse_index = -1
	}
}
}


function draw_autofill_list_new(x=o_console.autofill.x, y=o_console.autofill.y, list=o_console.autofill){ with o_console.TEXT_BOX {

if ds_list_size(list.list) == 0 exit

var at = o_console.AUTOFILL

list.x = x
list.y = y

var cw = string_width("W")
var ch = string_height("W")
var asp = ch/char_height
var _text_wdist = round(text_wdist*asp)

var xx
var yy
var text_x
var text_y
var y1
var y2

draw_console_body(list.left, list.top, list.right-1, list.bottom-1)

var imin = floor(list.scrollbar.scroll_y/ch)
var imax = min(floor((list.scrollbar.scroll_y+list.height)/ch), ds_list_size(list.list)-1)  // experience it in IMAX

clip_rect_cutout(list.left+1, list.top+1, list.right-1, list.bottom-1)
for(var i = imin; i <= imax; i++)
{	
	var item = list.list[| i]
	
	xx = list.left-list.scrollbar.scroll_x
	yy = list.top-list.scrollbar.scroll_y
	
	var col = item.color
	if is_string(col) col = o_console.colors[$ col]
	if not is_numeric(col) col = o_console.colors.plain
	
	text_x = xx+_text_wdist
	text_y = yy+ch*i+1
	
	y1 = yy+ch*i+1
	y2 = yy+ch*i+ch-1
	
	var selected = list.mouse_index == i
	var key_selected = list.key_index == i
	
	if selected or list.include_side_text
	{	
		var sidetext_col = color_set_hsv(col, color_get_hue(col)+at.sidetext_hue, at.sidetext_saturation, at.sidetext_value)
		draw_set_color(sidetext_col)
	}
	
	if list.include_side_text
	{
		text_x = xx+_text_wdist + cw*list.sidetext_bar_length  // Side bar length based on characters
		
		// Longer side bar
		if key_selected draw_rectangle(xx, y1, list.right, y2, false)
		else draw_rectangle(xx, y1, text_x-_text_wdist, y2, false)
		
		// Side text
		draw_set_color(col)
		draw_text(xx+_text_wdist, text_y, item.side_text)
		
		var sidebar_right = xx+_text_wdist/3
	
		// Side bar
		draw_rectangle(xx, y1, sidebar_right, y2, false)
	}
	else
	{
		draw_set_color(col)
	}
	
	// Text
	draw_text(text_x, text_y, list.list[| i].name)
	
	if selected	
	{
		gpu_set_blendmode(bm_add)
		if list.clicking draw_set_alpha(.2)
		else draw_set_alpha(.1)
		draw_rectangle(xx, y1, list.right, y2, false)
		draw_set_alpha(1)
		gpu_set_blendmode(bm_normal)
	}
	
	if key_selected
	{
		draw_hollowrect(xx+1, y1, list.right-2, y2, 1)
	}
}
shader_reset()

list.scrollbar.draw()
}}