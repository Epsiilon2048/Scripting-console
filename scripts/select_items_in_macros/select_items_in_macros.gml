
function select_items_in_macros(criteria){ with o_console {

var c_len = string_length(criteria)

var _min = 0
var _max = ds_list_size(console_macro_order)-1
var index = ceil( (ds_list_size(console_macro_order)-1)/2 )

for(var i = 1; i <= c_len; i++)
{
	
	var c_ord = ord( string_char_at(criteria, i) )
	var m_ord = ord( string_char_at(console_macro_order[| index], i) )
	var _index = index
	
	var max_ord = ord( string_char_at(console_macro_order[| _max], i) )
	var min_ord = ord( string_char_at(console_macro_order[| _min], i) )
	
	if min_ord == c_ord and max_ord == c_ord continue
	
	if min_ord != c_ord and max_ord != c_ord while c_ord != m_ord
	{
		var m_ord = ord( string_char_at(console_macro_order[| index], i) )
	
		if c_ord != m_ord
		{
			if c_ord > m_ord			_min = index+1
			else /*if c_ord < m_ord*/	_max = index-1
			
			if (_max-_min) <= 0 return -1
			
			index = _min + ceil((_max-_min)/2)
		}
	}
	
	if min_ord == c_ord index = _min
	if max_ord == c_ord index = _max
	
	
	var _index = index
	
	do _index --
	until _index == (_min-1) or ord( string_char_at(console_macro_order[| _index], i) ) != c_ord
	
	_min = _index+1
		
		
	var _index = index
	
	do _index ++
	until _index == (_max+1) or ord( string_char_at(console_macro_order[| _index], i) ) != c_ord
	
	_max = _index-1

	index = _min + ceil((_max-_min)/2)
}

var array = array_create(_max-_min+1)
for(var i = _min; i <= _max; i++)
{
	array[i-_min] = console_macro_order[| i]
}
return array
}}