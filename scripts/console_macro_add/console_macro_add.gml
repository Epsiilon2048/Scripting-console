
function ds_list_file(id, value){

for(var i = 0; i <= ds_list_size(id)-1; i++)
{
	var item = id[| i]

	if value == item break
	
	var j = 1; while string_char_at(item, j) == string_char_at(value, j)
	{
		j++
	}
	
	if ord( string_char_at(value, j) ) < ord( string_char_at(item, j) )
	{
		break
	}
}

ds_list_insert(id, i, value)
}



function console_macro_add_ext(name, type, value, sort){ with o_console {

console_macros[$ name] = {type: type, value: value}

if sort and ds_list_find_index(macro_list, name) == -1 ds_list_file(macro_list, name)
}}



function console_macro_add(name, type, value){

console_macro_add_ext(name, type, value, true)
}



function index_functions(){ with o_console {

var i = 100001
while better_script_exists(i)
{
	var name = script_get_name(i++)
	
	if string_pos("___struct___", name) != 1 and string_pos("anon_", name) != 1
	{
		ds_list_add(method_list, name)
	}
}

ds_list_sort(method_list, true)

var cur = ""
var prev = ""

for(var i = 0; i <= ds_list_size(method_list)-1; i++)
{
	cur = method_list[| i]
	if cur == prev ds_list_delete(method_list, i--)
	prev = cur
}
}}


function shader_exists(ind){
	
try {
	shader_get_name(ind)
	return true
}
catch(_){
	delete _ //get rid of that dumbass warning sign thing
	return false
}
}



function index_assets(){ with o_console {
	
static asset = [
	{exists: animcurve_exists,	get_name: function(curve_id){ return animcurve_get(curve_id).name }},
	{exists: font_exists,		get_name: font_get_name},
	{exists: object_exists,		get_name: object_get_name},
	{exists: path_exists,		get_name: path_get_name},
	{exists: room_exists,		get_name: room_get_name},
	{exists: sequence_exists,	get_name: function(sequence_id){ return sequence_get(sequence_id).name }},
	{exists: shader_exists,		get_name: shader_get_name},
	{exists: audio_exists,		get_name: audio_get_name},
	{exists: sprite_exists,		get_name: sprite_get_name},
	{exists: function(tileset_id){ return tileset_get_name(tileset_id) != "<undefined>" }, get_name: tileset_get_name},
	{exists: timeline_exists,	get_name: timeline_get_name},
]

for(var i = 0; i <= array_length(asset)-1; i++)
{
	var j = 0
	while asset[i].exists(j)
	{
		if asset[i].get_name(j) != "__YYInternalObject__3" ds_list_add(asset_list, asset[i].get_name(j))
		
		j++
	}
}

ds_list_sort(asset_list, true)
}}




function console_macro_add_builtin(criteria){ with o_console {

if is_undefined(criteria) criteria = ""

static i = 0
static check_inc = 70
var t

if initialized 
{
	i = 0
}
else t = get_timer()

var added = 0
var addressed = 0

for(; i <= 10000; i++)
{
	var name = script_get_name(i)
	
	if better_script_exists(i)
	{	
		var excluded = false
		
		if criteria != "" 
		{
			if string_pos(criteria, name) != 1 excluded = true
		}
		else for(var j = 0; j <= array_length(builtin_excluded)-1; j++)
		{
			if string_pos(builtin_excluded[j], name) == 1 
			{
				excluded = true
				break
			}
		}
		
		if not excluded 
		{
			console_macros[$ name] = {type: dt_method, value: i}
			
			if ds_list_find_index(macro_list, name) == -1 
			{
				ds_list_add(macro_list, name)
				added ++
			}
		}
		
		if (addressed++ mod check_inc) == check_inc-1
		{
			var _t = get_timer()
		
			var ms = (_t-t)/10000
			var lag = (ms/(room_speed/100))
			
			if lag >= .5
			{
				stay = true
				break
			}
		}
	}
}

if i > 10000 
{
	ds_list_sort(macro_list, true)
	return "Added "+string(added)+" builtin function"+((added == 1) ? "" : "s")
}
}}

