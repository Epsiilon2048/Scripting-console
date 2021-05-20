function gmcl_autofill(gmcl_string, char_pos){

if not is_string(gmcl_string)
{
	autofill.macros	= -1
	autofill.methods = -1
	autofill.assets	= -1
	autofill.instance = -1
	autofill.scope = -1
	return undefined
}

char_pos_arg = gmcl_get_argument(gmcl_string, char_pos)
	
var sc = char_pos_arg.scope != ""
var idn = char_pos_arg.iden
var ch = is_undefined(idn) or idn == dt_string

if sc and (ch or idn == dt_variable)
{		
	if is_real(char_pos_arg.scope) scope_variables = variable_instance_get_names(char_pos_arg.scope)
	else scope_variables = variable_struct_get_names(variable_string_get(char_pos_arg.scope))
		
	array_sort(scope_variables, true)
		
	if char_pos_arg.variable == "" autofill.scope = {min: 0, max: array_length(scope_variables)-1}
	else autofill.scope = autofill_in_list(scope_variables, char_pos_arg.variable, autofill.scope)
}
else autofill.scope = -1
	
var v = char_pos_arg.variable

// Tried an optimization where it would retain it's previous range if characters were only added; didnt work for some reason
// so as long as it's not causing real performance issues I'm just not gonna bother
autofill.macros		= (not sc and (ch or idn == dt_method)) ?  autofill_in_list(macro_list, v, undefined) : -1
autofill.methods	= (not sc and (ch or idn == dt_method or idn == dt_asset)) ? autofill_in_list(method_list, v, undefined) : -1
autofill.assets		= (not sc and (ch or idn == dt_variable or idn == dt_asset)) ? autofill_in_list(asset_list, v, undefined) : -1
autofill.instance	= (not sc and (ch or idn == dt_variable)) ?  autofill_in_list(instance_variables, v, undefined) : -1
	
if not is_undefined(char_pos_arg.iden) and char_pos_arg.variable == ""
{
	switch idn
	{
		case dt_asset:		autofill.assets = {min: 0, max: ds_list_size(asset_list)-1}
							autofill.methods = {min: 0, max: ds_list_size(method_list)-1}
		break
		case dt_variable:	autofill.instance = {min: 0, max: array_length(instance_variables)-1}
		break
		case dt_method:		autofill.methods = {min: 0, max: ds_list_size(method_list)-1}
							autofill.macros = {min: 0, max: ds_list_size(macro_list)-1}
	}
}
}