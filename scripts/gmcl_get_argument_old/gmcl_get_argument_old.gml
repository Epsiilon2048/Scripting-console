function gmcl_get_argument_old(command, pos){ with o_console {

static sep = " ;,=()[]:@#$?|"

var marker = 1
var in_string = false
var segment = ""
var instscope = ""

for(var i = 1; i <= string_length(command); i++)
{
	var char = string_char_at(command, i)
	
	if char == "\""
	{
		in_string = not in_string
	}
	else if not in_string and string_pos(char, sep)
	{
		if pos <= i break
		marker = i+1
	}
}
	
segment = string_copy(command, marker, i-marker)

if autofill_from_float and string_char_at(segment, 1) == "." and instance_exists(object)
{
	segment = string(object)+segment
}

if string_pos(".", segment) 
{
	instscope = string_copy(segment, 1+string_pos("/", segment), string_last_pos(".", segment)-1-string_pos("/", segment))
}

var variable

if string_pos(".", segment)	variable = string_copy(segment, string_last_pos(".", segment)+1, string_length(segment))
else						variable = string_copy(segment, 1+string_pos("/", segment), string_length(segment))

var inst = string_to_instance(instscope, true)
var varscope = string_add_scope(instscope, true)

if string_pos(".", instscope) == 0 and inst != -1 and (autofill_from_float or not ((variable == "" or string_is_float(variable)) and string_is_float(instscope)))
{
	instscope = inst
}
else if variable_string_exists(varscope) and is_struct(variable_string_get(varscope))
{
	instscope = string_scope_to_id(varscope, true)
}
else if instscope != ""
{
	instscope = ""
	variable = ""
}

var iden = identifiers[$ (string_char_at(segment, 2) == "/") ? string_char_at(segment, 1) : ""]

return {scope: instscope, arg: segment, inst: inst, variable: variable, iden: iden}
}}