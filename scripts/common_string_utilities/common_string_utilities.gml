
function shave(substr, str){ //removes substr from the ends of str

var output = str

while string_char_at(output, 1) == substr
{
	output = string_delete(output, 1, 1)
}

while string_char_at(output, string_length(output)) == substr
{
	output = string_delete(output, string_length(output), 1)
}
return output
}
	
function stitch(){ //combines args into a string
	
var str = ""

for( var i = 0; i <= argument_count-1; i++ )
{
	str += string(argument[i])
}

return str
}
	
function stitch_sep(sep){ //combines args into a string with a separator in between
	
var _sep = string(sep)
var str = ""

for( var i = 1; i <= argument_count-1; i++ )
{
	str += string(argument[i])
	
	if i != argument_count-1 str += _sep
}

return str	
}

function string_count_exclude(substr, str, before, after){ //counts substrs in the str, excluding substrs around the specified before and after substrs

var _before = before
var _after  = after

if is_undefined(before) _before = ""
if is_undefined(after)  _after  = ""

var count = 0

for(var i = 1; i <= string_length(str); i++)
{
	if	string_pos_ext(substr, str, i-1) == i and
		(_before == "" or (i == 1 or string_pos_ext(_before, str, i-1-string_length(_before)) != i-string_length(_before))) and
		(_after  == "" or string_pos_ext(_after,  str, i-1+string_length(substr)) != i+string_length(substr))
	{
		count ++
	}
}
return count
}

function string_pos_exclude(substr, str, before, after){ //finds the string pos, excluding substrs around the specified before and after substrs

var _before = before
var _after  = after

if is_undefined(before) _before = ""
if is_undefined(after)  _after  = ""

for(var i = 1; i <= string_length(str); i++)
{
	if	string_pos_ext(substr, str, i-1) == i and
		(_before == "" or (i == 1 or string_pos_ext(_before, str, i-1-string_length(_before)) != i-string_length(_before))) and
		(_after  == "" or string_pos_ext(_after,  str, i-1+string_length(substr)) != i+string_length(substr))
	{
		return i
	}
}
return 0
}
	
function string_split(substr, str){ //splits a string into an array by a separator

var list = array_create(string_count(substr, str), "")
var len = string_length(substr)

var i = 0; while str != ""
{
	if string_pos(substr, str) != 0
	{
		list[i] = string_copy(str, 1, string_pos(substr, str)-1)
		str = string_delete(str, 1, string_pos(substr, str)+len-1)
	}
	else
	{
		list[i] = str
		str = ""
	}
	
	i++
}
return list
}

function string_split_exclude(substr, str, before, after){ //splits a string into an array by a separator, excluding separators around the specified before and after substrs

var list = array_create(string_count_exclude(substr, str, before, after), "")
var len = string_length(substr)

var i = 0; while str != ""
{
	if string_pos_exclude(substr, str, before, after) != 0
	{
		list[i] = string_copy(str, 1, string_pos_exclude(substr, str, before, after)-1)
		str = string_delete(str, 1, string_pos_exclude(substr, str, before, after)+len-1)
	}
	else
	{
		list[i] = str
		str = ""
	}
	
	i++
}
return list
}

function string_split_keep(substr, str){ //splits a string into an array by a separator, but keeping it

var list = array_create(string_count(substr, str), "")
var len = string_length(substr)

var i = 0; while str != ""
{
	if string_pos(substr, str) != 0 
	{
		list[i] = string_copy(str, 1, string_pos(substr, str)+len-1)
		str = string_delete(str, 1, string_pos(substr, str)+len-1)
	}
	else
	{
		list[i] = str
		str = ""
	}
	
	i++
}
return list
}
	
