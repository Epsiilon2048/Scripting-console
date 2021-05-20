
function slice(value, from, to, step){
///@description slice(value,[from],[to],[step])

static string_concat  = function(string, value)	 { return string+value }
static ds_list_concat = function(ds_list, value) { ds_list_add(ds_list, value); return ds_list }

static list = ds_list_create()

var _is_string = is_string(value)
var _is_array = is_array(value)
var _is_ds_list = is_real(value)

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