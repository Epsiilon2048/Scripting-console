function gmcl_get_argument(command, pos){

static sep = ";,=()[]:"

var marker = 1
var in_string = false
var in_string_iden = false
var segment = ""
var instscope = ""

for(var i = 1; i <= string_length(command); i++)
{
	var char = string_char_at(command, i)
	
	if char == "\""
	{
		in_string = not in_string
	}
	else if not in_string and (string_pos(char, sep) or i == string_length(command)+1)
	{
		if pos <= i break
		marker = i+1
	}
}
	
segment = string_copy(command, marker, i-marker)

if string_pos(".", segment) instscope = string_copy(segment, 1, string_last_pos(".", segment)-1)

var variable = string_pos(".", segment) ? string_copy(segment, string_last_pos(".", segment)+1, string_length(segment)) : ((string_char_at(segment, 2) == "/") ? string_delete(segment, 1, 2) : segment)

var inst = string_to_instance(instscope, true)
var varscope = string_add_scope(instscope, true)

if string_pos(".", instscope) == 0 and inst != -1
{
	instscope = inst
}
else if variable_string_exists(varscope) and is_struct(variable_string_get(varscope))
{
	instscope = string_scope_to_id(varscope)
}
else if instscope != ""
{
	instscope = ""
	variable = ""
}

return {scope: instscope, arg: segment, inst: inst, variable: variable}
}