
//This is a library of functions which work independently from the console.


/// @description Capitalizes a string
/// @param str
function string_capitalize(str){

if not is_string(str) return string(str)
return string_upper(string_char_at(str, 1))+string_delete(str, 1, 1)
}



/// @description Gets if a font has consistent character widths
/// @param font
function font_has_consistent_kerning(font){

var old_font = draw_get_font()
draw_set_font(font)

var sw = string_width("W")
var same = true

for(var i = 32; i <= 126; i++)
{
	if string_width(chr(i)) != sw
	{
		same = false
		break
	}
}

draw_set_font(old_font)
return same
}
	

	
/// @description Returns value as a string; if the value was a string, adds quotes
/// @param {*} value
function quotes_if_string(value){

if is_string(value) return "\""+value+"\""
return string(value)
}



/// @description Returns a stringified asset type
/// @param {real} type
function asset_type_to_string(type){

switch type
{
default:					return "unknown"
case asset_object:			return "object"
case asset_script:			return "script"
case asset_animationcurve:	return "animcurve"
case asset_font:			return "font"
case asset_path:			return "path"
case asset_room:			return "room"
case asset_sequence:		return "sequence"
case asset_shader:			return "shader"
case asset_sound:			return "sound"
case asset_sprite:			return "sprite"
case asset_tiles:			return "tiles"
case asset_timeline:		return "timeline"
}
}
	


/// @description Retruns the next instance in a string of any of the chars, starting from the pos, in the direction of dir
/// @param {string} chars
/// @param {string} str
/// @param {real} pos
/// @param {real} dir - 1 for forward and -1 for backward
function string_char_next(chars, str, pos, dir){

var i = pos+dir
var len = string_length(str)

var inv = string_pos(string_char_at(str, i), chars) 

while 1 <= i and i <= len and (inv xor not string_pos(string_char_at(str, i), chars))
{
	i += dir
}

i -= dir

//if i > len return 0
return i
}
	
	
	
/// @description Executes a script, method, or builtin function with an array
/// @param {(real|method)} ind
/// @param {array} [array=[]]
function script_execute_ext_builtin(ind, array){

//So, the reason I do this weird thing instead of using script_execute_ext is because for
//reasons beyond human comprehension, gms... doesn't allow you to use arrays with built in
//scripts?? like, normally it would pass the script an argument for each item in the array,
//but with built ins it just passes the array as a single argument... wtf...

//if is_undefined(array) array = []
if not is_array(array) array = [array]
else if array_length(array) == 0 array = [undefined]

if is_numeric(ind) and ind >= 100000 
{
	show_message(array)
	return script_execute_ext(ind, array)
}

var f = ind
var a = array

switch array_length(a)
{
case 24: return   f(a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13],a[14],a[15],a[16],a[17],a[18],a[19],a[20],a[21],a[22],a[23])		;break
case 22: return         f(a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13],a[14],a[15],a[16],a[17],a[18],a[19],a[20],a[21])			;break
case 20: return               f(a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13],a[14],a[15],a[16],a[17],a[18],a[19])					;break
case 18: return                      f(a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13],a[14],a[15],a[16],a[17])						;break
case 16: return                            f(a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13],a[14],a[15])								;break
case 14: return                                  f(a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13])									;break
case 12: return                                        f(a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11])											;break
case 10: return                                            f(a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9])													;break
case 8:  return                                                  f(a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7])														;break
case 6:  return                                                        f(a[0],a[1],a[2],a[3],a[4],a[5])															;break
case 4:  return                                                              f(a[0],a[1],a[2],a[3])																;break
case 2:  return                                                                  f(a[0],a[1])																	;break
case 0:  return	                                                                     f([])																		;break
case 1:  return                                                                    f(a[0])																		;break
case 3:  return                                                                f(a[0],a[1],a[2])																;break
case 5:  return                                                            f(a[0],a[1],a[2],a[3],a[4])															;break
case 7:  return                                                      f(a[0],a[1],a[2],a[3],a[4],a[5],a[6])														;break
case 9:  return                                                f(a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8])													;break
case 11: return                                          f(a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10])												;break
case 13: return                                      f(a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12])										;break
case 15: return                                f(a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13],a[14])								;break
case 17: return                          f(a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13],a[14],a[15],a[16])							;break
case 19: return                    f(a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13],a[14],a[15],a[16],a[17],a[18])					;break
case 21: return             f(a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13],a[14],a[15],a[16],a[17],a[18],a[19],a[20])				;break
case 23: return       f(a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13],a[14],a[15],a[16],a[17],a[18],a[19],a[20],a[21],a[22])		;break
case 25: return f(a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13],a[14],a[15],a[16],a[17],a[18],a[19],a[20],a[21],a[22],a[23],a[24])	;break
}
}

	
	
/// @description Returns if a script exists
/// @param {real} ind
function better_script_exists(ind){

return 0 <= ind and ind <= 0xfffffffb and script_get_name(ind) != "<unknown>" and script_get_name(ind) != "<undefined>"
}



/// @description Returns if an instance exists
/// @param {real} inst
function better_instance_exists(inst){

return inst < 0xfffffffb and instance_exists(inst)
}
	
	
	
/// @description Returns if an object exists
/// @param {real} obj
function better_object_get_name(obj){
return (obj == global) ? "global" : object_get_name(obj)
}
	
	
	
/// @description Returns if all the given keys are down and at least one is pressed
/// @param {...real} key
function keyboard_check_multiple_pressed(){
	
var pressed = false
	
for(var i = 0; i <= argument_count-1; i++)
{
	if keyboard_check(argument[i])
	{
		if keyboard_check_pressed(argument[i])
		{
			pressed = true
		}
	}
	else return false
}
	
return pressed
}
	
	
	
/// Returns if the mouse is between gui coordinates
/// @param x1
/// @param y1
/// @param x2
/// @param y2
function gui_mouse_between(x1, y1, x2, y2){

return point_in_rectangle(gui_mx, gui_my, min(x1, x2), min(y1, y2), max(x1, x2), max(y1, y2))
}
	
	
	
/// @description If a variable in a struct exists return the variable, otherwise return the not_exists value
/// @param struct
/// @param variable
/// @param not_exists
function variable_struct_exists_get(struct, variable, not_exists){

if is_struct(struct) and variable_struct_exists(struct, variable) return variable_struct_get(struct, variable)
else return not_exists
}
	
	
	
/// @description Returns the index if a value in an array
/// @param array
/// @param value
function array_find(array, value){

for(var i = 0; i <= array_length(array)-1; i++)
{
	if array[i] == value return i
}

return -1
}



/// @description Returns an array of the value held by each struct in an array of structs
/// @param array
/// @param value
function array_struct_get(array, name){

var _array = array_create(array_length(array), undefined)

for(var i = 0; i <= array_length(array)-1; i++)
{
	_array[i] = variable_struct_get(array[i], name)
}

return _array
}
	


/// @description Returns each item off an array as a string, separated by the separator
/// @param array
/// @param separator
function array_to_string(array, separator){

if is_string(array) return array

var str = ""
var add = ""

for(var i = 0; i <= array_length(array)-1; i++)
{
	add = string(array[i])
	
	str += separator + add
}
return string_copy(str, string_length(separator)+1, string_length(str)-1)
}
	
	
	
/// @description Returns an array converted from a ds list
/// @param ds_list
function ds_list_to_array(ds_list){

var array = array_create(ds_list_size(ds_list))

for(var i = 0; i <= ds_list_size(ds_list)-1; i++)
{
	array[@ i] = ds_list[| i]
}
return array
}




function struct_copy(struct){

var names = variable_struct_get_names(struct)
var name_count = array_length(names)

var new_struct = {}

for(var i = 0; i <= name_count-1; i++)
{
	new_struct[$ names[@ i]] = struct[$ names[@ i]]
}

return new_struct
}




function struct_clear(struct){

var names = variable_struct_get_names(struct)
var name_count = array_length(names)

for(var i = 0; i <= name_count-1; i++)
{
	struct[$ names[@ i]] = undefined
}
}




function struct_add(dest, src){
	
var names = variable_struct_get_names(src)
var name_count = array_length(names)

for(var i = 0; i <= name_count-1; i++)
{
	dest[$ names[@ i]] = src[$ names[@ i]]
}
}




function struct_replace(dest, src){
	
var names = variable_struct_get_names(src)
var name_count = array_length(names)

for(var i = 0; i <= name_count-1; i++)
{
	var value = dest[$ names[@ i]]
	
	if is_method(value) continue
	if is_struct(value) dest[$ names[@ i]] = struct_copy( src[$ names[@ i]] )
	else dest[$ names[@ i]] = src[$ names[@ i]]
}

return dest
}




function ds_map_to_struct(ds_map){

var struct = {}
var keys = ds_map_keys_to_array(ds_map)

for(var i = 0; i <= ds_map_size(ds_map)-1; i++)
{
	struct[$ keys[@ i]] = ds_map[? keys[@ i]]
}
return struct
}
	
	


function signbool(bool){ //formats a bool to be -1 if false
return -(sign(bool) == 0) + sign(bool)
}
	
	
	
	
function color_add_hue(col, add){ //returns a color with added hue

return make_color_hsv(
	color_get_hue(col)+add, 
	color_get_saturation(col),
	color_get_value(col)
)
}
	

	
	
function color_add_hsv(col, hue, saturation, value){ //returns a color with added hue

if is_undefined(hue) hue = 0
if is_undefined(saturation) saturation = 0
if is_undefined(value) value = 0

return make_color_hsv(
	color_get_hue(col)+hue, 
	color_get_saturation(col)+saturation,
	color_get_value(col)+value
)
}
	



function color_set_hsv(col, hue, saturation, value){ //returns a color with added hue

if is_undefined(hue) hue = color_get_hue(col)
if is_undefined(saturation) saturation = color_get_saturation(col)
if is_undefined(value) value = color_get_value(col)

return make_color_hsv(
	hue, 
	saturation,
	value
)
}
	
	
	
	
function dec_to_hex(dec, len){ //converts base10 to base16
/// GMLscripts.com/license

// Slightly modified for compatibility with GM 2.3 as well as formatting consistency
// https://www.gmlscripts.com/script/dec_to_hex

var _dec = dec
var _len = is_undefined(len) ? 1 : len

var hex = ""
 
if _dec < 0
{
    _len = max(_len, ceil( logn( 16, 2*abs(_dec) ) ) )
}
 
var dig = "0123456789ABCDEF"
while _len-- or _dec 
{
    hex = string_char_at(dig, (_dec & $F) + 1) + hex
    _dec = _dec >> 4;
}
 
return hex;
}




function hex_to_dec(hex){ //converts base16 to base10
/// GMLscripts.com/license

// Slightly modified for compatibility with GM 2.3 as well as formatting consistency
// https://www.gmlscripts.com/script/hex_to_dec


var _hex = string_upper(hex)
var dec = 0
h = "0123456789ABCDEF"
for (var p = 1; p <= string_length(_hex); p++)
{
    dec = dec << 4 | (string_pos( string_char_at(_hex, p), h ) - 1)
}
return dec
}




function rgb_to_hex(r, g, b){ //converts rgb to hex
/// GMLscripts.com/license

// Slightly modified for compatibility with GM 2.3 as well as formatting consistency
// https://www.gmlscripts.com/script/rgb_to_hex

var _r = r & 255
var _g = r & 255
var _b = r & 255
return dec_to_hex(_r << 16 | _g << 8 | _b, 1)
}
	
	
	

function float_count_places(float, max_places){

if (float mod 1) == 0 return 0

if is_undefined(max_places) max_places = 10

var float_string = string_format(float, 0, max_places)

var i = 1
var len = string_length(float_string)
var char = string_char_at(float_string, len)
while char == "0"
{
	i++
	char = string_char_at(float_string, len-i)
}
	
return len-string_pos(".", float_string)-i
}




function hex_to_color(hex){

var _hex

if is_string(hex)
{
	_hex = string(hex)
	if slice(_hex, 1, 3, 1) == "0x" _hex = slice(_hex, 3, -1, 1)
}
else if is_numeric(hex) _hex = dec_to_hex(hex, 6)

return hex_to_dec( string_copy(_hex, 5, 2)+string_copy(_hex, 3, 2)+string_copy(_hex, 1, 2) )
}


	
	
function color_to_hex(color){

var hex = dec_to_hex(color, 6)

return string_copy(hex, 5, 2)+string_copy(hex, 3, 2)+string_copy(hex, 1, 2)
}




function shave(substr, str){ //removes substr from the ends of str

var in = 1
var out = string_length(str)

var str_len = string_length(substr)
var substr_len = string_length(substr)

if substr_len == 0 return str
if substr_len == 1
{
	while in <= str_len and string_char_at(str, in) == substr
	{
		in++
	}
	
	while out >= 0 and string_char_at(str, out) == substr
	{
		out--
	}
}
else
{
	while in <= str_len and slice(str, in, in+substr_len, 1) == substr
	{
		in += substr_len
	}
	
	while out >= 0 and slice(str, out-substr_len+1, out+1, 1) == substr
	{
		out -= substr_len
	}
}
return slice(str, in, out+1, 1)
}




function stitch(){ //combines args into a string
	
var str = ""

for( var i = 0; i <= argument_count-1; i++ )
{
	str += string(argument[i])
}

return str
}
	
	
	
	
function string_split(substr, str){ //splits a string into an array by a separator

static split = ds_list_create()

var pos = string_pos(substr, str)
if not pos return [str]

var marker = 1
var substrlen = string_length(substr)

ds_list_clear(split)

if substrlen while pos
{	
	var item = string_copy(str, marker, pos - marker)
	
    ds_list_add(split, item)
	
    marker = pos + substrlen
    pos = string_pos_ext(substr, str, marker)
}
ds_list_add(split, string_delete(str, 1, marker - 1))

return ds_list_to_array(split)
}



	
function string_is_int(str){ //returns true if a string is a base10 or base16 integer

if not is_string(str) return false

var _str = str
if string_pos("-", _str) == 1 _str = string_delete(_str, 1, 1)

if _str == "" return false	

if string_pos("0x", _str) == 1
{
	_str = string_delete(_str, 1, 2)
	
	return hex_to_dec(_str) >= 0
}

return string_digits(_str) == _str
}




function string_is_float(str){ //returns true if a string is a base10 or base16 float

if not is_string(str) or string_pos(".-", str) == 1 return false

var _str = str
if string_pos(".", str) != 0 
{
	if string_pos(".0x", _str) or string_pos("0.x", _str) return false
	
	_str = string_delete( _str, string_pos(".", _str), 1 )
}

return string_is_int(_str)
}




function string_format_float(float, decimal_places){ //formats a float into a string

if not is_numeric(float) or (is_undefined(decimal_places) and (float mod 1) == 0) return string(float)

var _decimal_places = is_undefined(decimal_places) ? 3 : decimal_places

var float_string = string_format(float, 0, _decimal_places)

if is_undefined(decimal_places) and (float mod 1) != 0
{
	var len = string_length(float_string)
	var i = len
	var char = string_char_at(float_string, len)
	while char == "0"
	{
		i--
		char = string_char_at(float_string, i)
	}
	
	float_string = slice(float_string, 1, i+1, 1)
}

return float_string
}




function string_pos_index(substr, str, index){ //returns the nth instance of the substr in the str

var pos = string_pos(substr, str)
if not (pos or index) return 0

repeat index-1
{
	pos = string_pos_ext(substr, str, pos)
	if not pos return 0
}

return pos
}


	
	
function string_last(str){ //returns the last character of a string
return string_char_at(str, string_length(str))
}




function first_is_digit(str){

var char = string_char_at(str, 1)

if char == "-" char = string_char_at(str, 2)

return ( string_digits(char) == char )
}
	
	
	
	
function bm_to_string(blendmode){
	
switch blendmode
{
case bm_normal:			return "bm_normal"
case bm_add:			return "bm_add"
case bm_subtract:		return "bm_subtract"
case bm_max:			return "bm_max"
case bm_dest_alpha:		return "bm_dest_alpha"
case bm_dest_color:		return "bm_dest_color"
case bm_inv_dest_alpha:	return "bm_inv_dest_alpha"
case bm_inv_dest_color:	return "bm_inv_dest_color"
case bm_src_alpha:		return "bm_src_alpha"
case bm_src_alpha_sat:	return "bm_src_alpha_sat"
case bm_inv_src_alpha:	return "bm_inv_src_alpha"
case bm_inv_src_color:	return "bm_inv_src_color"
}

return "<unknown>"
}
	
	
	
/// @param x1
/// @param y1
/// @param x2
/// @param y2
/// @param [w]
function draw_hollowrect(x1, y1, x2, y2, w){

var _x1 = min(x1, x2)
var _y1 = min(y1, y2)
var _x2 = max(x1, x2)
var _y2 = max(y1, y2)

if os_type == os_macosx
{
	_x1 --
	_y1 --
	_x2 ++
	_y2 ++
}

w = max(round(w), 1) - 1

if _x1+w >= _x2 or _y1+w >= _y2 draw_rectangle(_x1, _y1, _x2, _y2, false)
else if w == 0
{
	draw_rectangle(_x1+1, _y1+1, _x2-1, _y2-1, true)
}
else
{
	draw_rectangle(_x1, _y1, _x2-w-1, _y1+w, false)
	draw_rectangle(_x2-w, _y1, _x2, _y2-w-1, false)
	draw_rectangle(_x2+1, _y2-w, _x1+w, _y2, false)
	draw_rectangle(_x1, _y2+1, _x1+w, _y1+w, false)
}
}
	
	
	
/// @description Returns an array converted from a ds list
/// @param value
/// @param [from=1]
/// @param [to=end_of_value]
/// @param [step=1]
function slice(value, from, to, step){
///@description slice(value,[from],[to],[step])

static string_concat  = function(string, value)	 { return string+value }
static ds_list_concat = function(ds_list, value) { ds_list_add(ds_list, value); return ds_list }

static list = ds_list_create()

var _is_string = is_string(value)
var _is_array = is_array(value)
var _is_ds_list = is_numeric(value)

var output
var len
var access
var concat

//bleck
if _is_string
{
	output = ""
	len = string_length(value)
	access = string_char_at
	concat = string_concat
}
else if _is_array	
{
	output = list
	len = array_length(value)
	access = array_get
	concat = ds_list_concat
}
else if _is_ds_list
{
	output = list
	len = ds_list_size(value)
	access = ds_list_find_value
	concat = ds_list_concat
}
else throw "Attempting to slice unsupported datatype"

if is_undefined(from)	from = _is_string
if is_undefined(to)		to = len+_is_string
if is_undefined(step)	step = 1

else if step == 0 throw "Step cannot be zero"

var dir = sign(step) != -1

var _from = ((sign(from) == -1) ? (len+from+1+_is_string) : from)
var _to	= ((sign(to) == -1) ? (len+to+1+_is_string) : to) - (step < -1 or not (_is_string or dir))

if not dir // kinda prefer this to adding to the control statements, they're already so unreadable
{
	var _ = _from // eugh
	_from = _to
	_to = _
}

var output

if step == 1 and not _is_ds_list // Basically the same as the copy functions, so we can just use those
{
	if _is_string
	{
		output = string_copy(value, _from, _to-_from)
	}
	else //if _is_array
	{
		output = array_create(min(_to-_from, len))
		array_copy(output, 0, value, _from, _to-_from)
	}
}
else 
{
	var item_count = 0
	
	for(var i = _from; (dir) ? (i <= _to-1) : (i >= _to); i += step)
	{	
		output = concat(output, access(value, i))
		item_count ++
	}

	if _is_array or _is_ds_list
	{
		output = array_create(item_count)
		
		for(var i = 0; i <= item_count-1; i++)
		{
			output[@ i] = list[| i]
		}
		ds_list_clear(list)
	}
}

return output
}
	
	


function ds_type_to_string(ds_type){

switch ds_type
{
case ds_type_grid:		return "grid"
case ds_type_list:		return "list"
case ds_type_map:		return "map"
case ds_type_priority:	return "priority"
case ds_type_queue:		return "queue"
case ds_type_stack:		return "stack"
}
}