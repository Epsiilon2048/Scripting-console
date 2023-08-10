
function gmcl_autofill_new(gmcl_string=undefined, char_pos=0){ with o_console.autofill {

// Is tag
// Embed tag
// Output tag
// Event tag

// Has identifier
// String identifier
// Color identifier
// Variable identifier
// Real identifier
// Asset identifier
// Method identifier

// Console scope

var af = o_console.autofill_default

var reset = gmcl_string == undefined
if is_undefined(gmcl_string) gmcl_string = ""

for(var i = 0; i <= ds_list_size(af.lists)-1; i++)
{
	if not is_struct(af.lists[| i]) continue
	af.lists[| i].enabled = false
}

scope_variables.show_all_if_blank = false
assets.show_all_if_blank = false
methods.show_all_if_blank = false
instances.show_all_if_blank = false

char_pos_arg = gmcl_get_argument_old(gmcl_string, char_pos)
var autofill_string = char_pos_arg.arg

var scope = o_console.object
var iden = dt_unknown
var first = string_char_at(autofill_string, 1)
var last = string_last(autofill_string)
var dots = string_count(".", autofill_string)
var has_bracket = string_pos("[", autofill_string) != 0
var is_number = string_is_float(autofill_string)

if reset
{
	o_console.variable_scope_list = []
	af.get("")
	exit
}


// It'sa number!!
if is_number
{
	instances.enabled = true
	input_log.enabled = true
	o_console.variable_scope_list = []
	af.get(autofill_string)
	exit
}


if first == "$"
{
	chatterbox.enabled = true
	o_console.variable_scope_list = []
	af.get(autofill_string)
	exit
}

if string_char_at(autofill_string, 2) == "/" and variable_struct_exists(o_console.identifiers, first)
{
	iden = o_console.identifiers[$ first]
	autofill_string = slice(autofill_string, 3)
}


if iden != dt_unknown
{
	switch iden
	{
	case dt_variable:
		scope_variables.enabled = true
		instance_variables.enabled = true
		macros.enabled = true
	
		scope_variables.show_all_if_blank = true
	break
	case dt_asset:
		assets.enabled = true
		assets.show_all_if_blank = true
	break
	case dt_color:
		// Select only real variables and macros
	break
	case dt_instance:
		// List every instance, as well as instance macros
		instances.enabled = true
		instances.show_all_if_blank = true
	break
	case dt_method:
		methods.enabled = true
		methods.show_all_if_blank = true
	break
	}
	
	o_console.variable_scope_list = []
	af.get(autofill_string)
	exit
}

//{scope: instscope, arg: segment, inst: inst, variable: variable, iden: iden}
if is_struct(char_pos_arg.scope) or (is_numeric(char_pos_arg.scope) and better_instance_exists(char_pos_arg.scope))
{
	contrace(char_pos_arg.variable)
	o_console.variable_scope = char_pos_arg.scope
	o_console.variable_scope_list = variable_instance_get_names(char_pos_arg.scope)
	scope_variables.show_all_if_blank = true
	instance_variables.enabled = true
	
	af.get(char_pos_arg.variable)
	exit
}
o_console.variable_scope_list = []

// Only text
if dots == 0 and not has_bracket
{
	for(var i = 0; i <= ds_list_size(af.lists)-1; i++)
	{
		if not is_struct(af.lists[| i]) continue
		af.lists[| i].enabled = true
	}
	instances.enabled = false
	
	af.get(autofill_string)
	exit
}


// Text that starts with a dot
if dots == 1 and not has_bracket and first == "." and (is_struct(scope) or better_instance_exists(scope))
{
	autofill_string = slice(autofill_string, 2)
	scope_variables.show_all_if_blank = true
	scope_variables.enabled = true
	af.get(autofill_string)
	exit
}


var in_array = false
var scope
if in_array
{
	array.enabled = true
	af.get(autofill_string)
	exit
}


af.get("")
}}