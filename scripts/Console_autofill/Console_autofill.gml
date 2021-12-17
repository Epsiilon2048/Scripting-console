
function Autofill_sublist() constructor {

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

get_range = function(term){
	var minmax = autofill_in_list(list, term, undefined)
	
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

if not is_struct(item) item = new Autofill_item(item, item, undefined, undefined)
else if instanceof(item) != "Autofill_item" item = struct_replace(new Autofill_item("", "", undefined, undefined), item)

return item
}



function Autofill_item(name, value, side_text, color) constructor {

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


initialize = function(){

	list = ds_list_create()
	lists = ds_list_create()
	include_side_text = false
}


sort = noscript


clear = function(){
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
	}
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
	
	for(var i = 0; i <= ds_list_size(lists)-1; i++)
	{
		var li = lists[| i]
		if is_struct(li) and instanceof(li) == "Autofill_sublist" with li
		{
			get()
			sort()
			get_range(term)
		}
		
		add(li)
	}
}


get_array = function(){
	return ds_list_to_array(list)
}


destroy = function(){
	
if ds_exists(ds_type_list, list) ds_list_destroy(list)
if ds_exists(ds_type_list, lists) ds_list_destroy(lists)
}
}
	
	

function draw_autofill_list_new(x, y, list){

var ch = string_height("W")
draw_console_body(x, y, x+700, y+ch*ds_list_size(list.list))

for(var i = 0; i <= ds_list_size(list.list)-1; i++)
{
	if undefined != list.list[| i].color draw_set_color(list.list[| i].color)
	draw_rectangle(x, y+ch*i, x+15, y+ch*i+ch, false)
	
	draw_set_color(c_white)
	draw_text(x+20, y+ch*i, list.list[| i].name)
}
}