function generate_embed_list(array, columns, firstcolumn_embed, column_arg){

if is_undefined(firstcolumn_embed) firstcolumn_embed = {}

var column_count = array_length(columns)

var column_lengths = array_create(column_count, 0)

for(var i = 0; i <= array_length(array)-1; i++)
{
	for(var j = 0; j <= column_count-1; j++)
	{
		var length = string_length( variable_struct_exists_get(array[i], columns[j], "") )+2
		
		if column_lengths[j] < length column_lengths[j] = max(length, string_length(columns[j])+2)
	}
}

var list = ["  "]

for(var i = 0; i <= column_count-1; i++)
{
	array_push(list, columns[i]+string_repeat(" ", column_lengths[i] - string_length(columns[i])))
}


for(var i = 0; i <= array_length(array)-1; i++)
{
	var item = string( variable_struct_exists_get(array[i], columns[0], "N/A") )
	var selected = variable_struct_exists_get(array[i], "__selected__", false)
	
	if selected array_push(list, {str: "\n[ ", col: dt_unknown})
	
	var struct = struct_copy(firstcolumn_embed)
	
	struct.str = (selected ? "" : "\n  ")+item+string_repeat(" ", column_lengths[0] - string_length(item))
	if selected struct.col = "embed_hover"
	if not is_undefined(column_arg) struct.arg = variable_struct_exists_get(array[i], column_arg, undefined)
	
	array_push(list, struct)
	
	var str = ""
	
	for(var j = 1; j <= column_count-1; j++)
	{
		var item = string( variable_struct_exists_get(array[i], columns[j], "N/A") )
		
		str += item+string_repeat(" ", (j != column_count-1)*(column_lengths[j] - string_length(item)))
	}

	array_push(list, {str: str, col: (selected ? "embed_hover" : "output")})
	if selected array_push(list, {str: " ]", col: dt_unknown})
}

return list
}