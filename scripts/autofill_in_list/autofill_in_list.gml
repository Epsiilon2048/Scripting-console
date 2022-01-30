
function autofill_in_list(array_or_ds_list, criteria, range){ with global._scrvar_ {

// The range used in the script works as the max being 
// the last item in the list within the range. However,
// when returning the value, the max is converted to be
// the first item outside of the range, as is how range
// works in most stuff. So, just keep that in mind.

criteria = string(criteria)
list = array_or_ds_list

if first_is_digit(criteria) or (not is_array(list) and (not is_numeric(list) or not ds_exists(list, ds_type_list))) return -1//{min: -1, max: -1}

i = 1
access = is_array(list) ? array_get : ds_list_find_value

var list_size = ( is_array(list) ? array_length(list) : ds_list_size(list) )
var c_len = string_length(criteria)

if list_size == 0 or c_len == 0 return -1//{min: -1, max: -1}

var _min = is_struct(range) ? range.min : 0
var _max = is_struct(range) ? range.max : (list_size-1)
if is_struct(range) 
{
	range.used = true
}

var index = ceil(_max/2)

static get_ord = function(index){

	return ord( string_char_at(access(list, index), i) )
}

for(i = 1; i <= c_len; i++)
{
	var c_ord = ord( string_char_at(criteria, i) )
	var m_ord = get_ord(index)
	var _index = index
	
	var max_ord = get_ord(_max)
	var min_ord = get_ord(_min)
	
	if min_ord == c_ord and max_ord == c_ord continue
	
	if min_ord != c_ord and max_ord != c_ord while c_ord != m_ord
	{
		var m_ord = get_ord(index)
	
		if c_ord != m_ord
		{
			if c_ord > m_ord			_min = min(index+1, list_size-1)
			else /*if c_ord < m_ord*/	_max = max(index-1, 0)
			
			if _max-_min <= 1
			{
				var max_is = (string_pos(criteria, access(list, _max)) == 1)
				var min_is = (string_pos(criteria, access(list, _min)) == 1)
				
				if not (max_is or min_is) return -1//{min: -1, max: -1}
				break
			}
			
			index = _min + ceil((_max-_min)/2)
		}
	}
	
	max_ord = get_ord(_max)
	min_ord = get_ord(_min)
	
	if min_ord == c_ord index = _min
	if max_ord == c_ord index = _max
	
	
	var _index = index
	
	if c_ord != min_ord
	{
		do _index --
		until _index == (_min-1) or get_ord(_index) != c_ord
	
		_min = _index+1
	}
		
	
	var _index = index
	
	if c_ord != max_ord
	{
		do _index ++
		until _index == (_max+1) or get_ord(_index) != c_ord
	
		_max = _index-1
	}

	index = _min + ceil((_max-_min)/2)
}
return {min: _min, max: _max+1}
}}