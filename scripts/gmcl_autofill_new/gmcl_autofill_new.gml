
function gmcl_autofill_new(gmcl_string){

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

var scope = o_console.object
var iden = dt_unknown
var first = string_char_at(gmcl_string, 1)
var dots = string_count(".", gmcl_string)
var has_bracket = string_pos("[", gmcl_string) != 0

for(var i = 0; i <= ds_list_size(autofill.lists)-1; i++)
{
	autofill.lists[| i].enabled = false
}

scope_variables.show_all_if_blank = false
assets.show_all_if_blank = false
methods.show_all_if_blank = false
instances.show_all_if_blank = false

var autofill_string = gmcl_string

if first == "$"
{
	chatterbox.enabled = true
	autofill.get(gmcl_string)
	exit
}

if string_char_at(gmcl_string, 2) == "/" and variable_struct_exists(o_console.identifiers, first)
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
	
	autofill.get(autofill_string)
	exit
}


// Only text
if dots == 0 and not has_bracket
{
	for(var i = 0; i <= ds_list_size(autofill.lists)-1; i++)
	{
		autofill.lists[| i].enabled = true
	}
	
	autofill.get(autofill_string)
	exit
}


// Text that starts with a dot
if dots == 1 and not has_bracket and first == "." and (is_struct(scope) or better_instance_exists(scope))
{
	autofill_string = slice(autofill_string, 2)
	scope_variables.show_all_if_blank = true
	scope_variables.enabled = true
	autofill.get(autofill_string)
	exit
}


var in_array = false
var scope
if in_array
{
	array.enabled = true
	autofill.get(autofill_string)
	exit
}


autofill.get("")
}
