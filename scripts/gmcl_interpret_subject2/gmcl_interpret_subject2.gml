
function gmcl_interpret_subject(arg){ with o_console {

var _arg = string(arg)
var _arg_plain = _arg

var value = undefined
var type = -1
var macro = undefined
var iden_type = ""
var macro_type = ""
var error = undefined
var description = undefined

var arg_first = string_char_at(_arg, 1)
var arg_last = (string_length(_arg) <= 1) ? "" : string_last(_arg)

if string_char_at(arg, 2) == "/" and variable_struct_exists(identifiers, arg_first)
{
	iden_type = identifiers[$ string_char_at(_arg, 1)]
	_arg = slice(_arg, 3, -1, 1)
	_arg_plain = _arg
	
	arg_first = string_char_at(_arg, 1)
}

if _arg == "" 
{
	error = exceptionNoValue
}
else
{	
	macro = console_macros[$ _arg]
	if not is_undefined(macro) and iden_type != dt_variable
	{
		macro_type = macro.type
		
		if macro.type == dt_string	_arg = "\""+string(macro.value)+"\""
		else if is_numeric(macro)	_arg = string_format_float(macro.value)
		else						_arg = string(macro.value)
		
		arg_first = string_char_at(_arg, 1)
		arg_last = (string_length(_arg) <= 1) ? "" : string_last(_arg)
	}
	
	var is_float = string_is_float(_arg)
	var is_int = is_float and string_is_int(_arg)
	
	if is_float and iden_type != dt_string
	{
		var arg_real = real(_arg)
			
		if iden_type != "" switch iden_type
		{
			case dt_real:
				type = dt_real
				value = arg_real
			break
			case dt_asset:
				if is_int and arg_real >= 0 and arg_real <= 0xfffffffffffffb and object_exists(arg_real)
				{
					value = arg_real
					type = dt_asset
				}
				else
				{
					error = exceptionObjectNotExists
				}
			break
			case dt_variable:
				error = exceptionBotchedVariable
			break
			case dt_method:
				if is_int and better_script_exists(arg_real)
				{
					value = arg_real
					type = dt_method
				}
				else
				{
					error = exceptionScriptNotExists
				}
			break
			case dt_instance:
				if is_int and better_instance_exists(arg_real)
				{
					value = arg_real
					type = dt_instance
				}
				else
				{
					error = exceptionInstanceNotExists
				}
			break
			case dt_color:
				if slice(_arg, 1, 3, 1) == "0x" value = hex_to_color(_arg)
				else value = real(_arg)
			
				type = dt_color
		}
		else if macro_type != ""
		{
			type = macro_type
			value = arg_real
		}
		else if instance_exists(arg_real)
		{
			type = dt_instance
			value = arg_real
		}
		else
		{
			error = exceptionInstanceNotExists
		}
	}
	else if iden_type != ""
	{
		switch iden_type
		{
			case dt_real:
				error = exceptionBotchedReal
			break
			case dt_string:
				type = dt_string
				value = string(_arg)
			break
			case dt_asset:
				var asset = asset_get_index(_arg_plain)
				if asset == -1
				{
					error = exceptionAssetNotExists
				}
				else
				{
					value = asset
					type = dt_asset
				}
			break
			case dt_variable:
				if not is_undefined(macro) and macro.type == dt_variable
				{
					value = _arg
					type = dt_variable
				}
				else
				{
					value = _arg_plain
					type = dt_variable
				}
			break
			case dt_method:
				var asset = asset_get_index(_arg_plain)
				if better_script_exists(asset)
				{
					value = asset
					type = dt_method
				}
				else if not is_undefined(macro) and macro.type == dt_method and better_script_exists(macro.value)
				{
					value = macro.value
					type = dt_method
				}
				else
				{
					error = exceptionScriptNotExists
				}
			break
			case dt_instance:
				var asset = asset_get_index(_arg_plain)
				if better_instance_exists(asset)
				{
					value = asset
					type = dt_instance
				}
				else if not is_undefined(macro) and macro.type == dt_instance and better_instance_exists(macro.value)
				{
					value = macro.value
					type = dt_instance
				}
				else
				{
					error = exceptionInstanceNotExists
				}
			break
			case dt_color:
				error = exceptionBotchedColor
		}
	}
	else if arg_first == "\""
	{
		if arg_last != "\""
		{
			error = exceptionBotchedString
		}
		else
		{
			type = dt_string
			value = (arg_first == "\"") ? slice(_arg, 2, -2, 1) : _arg
		}
	}
	else
	{
		var asset = asset_get_index(_arg)
		if asset != -1
		{
			type = dt_asset
			value = asset
			
			switch asset_get_type(_arg)
			{
				case asset_object: type = dt_instance
				break
				case asset_script: type = dt_method
			}
		}
		else
		{
			variable = variable_string_exists_error(_arg)
			error = variable.error
			if variable.exists
			{
				type = dt_variable
				value = string_add_scope(_arg, true)
			}
		}
	}
}

return {
	value: value, 
	type: type,
	plain: string(arg),
	error: error,
	description: description,
}
}}