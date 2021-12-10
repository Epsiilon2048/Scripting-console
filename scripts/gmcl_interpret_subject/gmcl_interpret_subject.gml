
function gmcl_interpret_subject(arg){ with o_console {

var _arg = string(arg)
var _arg_plain = _arg

var value = undefined
var type = -1
var macro = undefined
var iden_type = ""
var macro_type = ""
var error = undefined
var description = ""

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
		else						_arg = string_format_float(macro.value, undefined)
		
		arg_first = string_char_at(_arg, 1)
		arg_last = (string_length(_arg) <= 1) ? "" : string_last(_arg)
	}
	
	var is_float = string_is_float(_arg)
	var is_int = is_float and string_is_int(_arg)
	
	if is_float and iden_type != dt_string  // Is numeric
	{
		var arg_real = real(_arg)
			
		if iden_type != "" switch iden_type  // Has identifier and is numeric
		{
			case dt_real:
				type = dt_real
				value = arg_real
				
				if slice(_arg, 1, 3, 1) == "0x" description = value
			break
			case dt_asset:
				value = arg_real
				type = dt_real
				
				if macro_type == dt_method
				{
					description = "Script asset "+string(value)
				}
				else if macro_type == dt_instance
				{
					if object_exists(arg_real) description = "Object "+object_get_name(value)
					else if instance_exists(arg_real)  description = "Instance of "+object_get_name(value.object_index)
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
					
					description = object_get_name(value.object_index)+" ("+string(value.id)+")"
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
				
				description = stitch("RGB ",color_get_red(value)," ",color_get_green(value)," ",color_get_blue(value))
		}
		else if macro_type != ""  // Has macro
		{
			if macro_type == dt_instance and not instance_exists(arg_real)
			{
				if object_exists(arg_real) type = dt_asset
				else error = exceptionInstanceNotExists
			}
			else type = macro_type
			value = arg_real
			
			switch macro_type
			{
				case dt_instance:
					var count = instance_number(value.object_index)
					if value.object_index == value description = stitch("Object "+object_get_name(value.object_index)," (object index ",value.object_index,"; ",count,((count == 1) ? " instance":" instances")+"; implicit ID ",value.id,")")
					else description = stitch("Instance ",value.id," (object "+object_get_name(value.object_index)+"; object index ",value.object_index,"; ",count,((count == 1) ? " instance":" instances")+")")
				break
				case dt_asset:
					if macro_type == dt_instance description = "Object "+object_get_name(value)+" (object index "+string(value)+"; no instances)"
					else description = "Unknown asset with index "+string(value)
				break
				case dt_color:
					description = stitch("RGB ",color_get_red(value)," ",color_get_green(value)," ",color_get_blue(value))
				break
				case dt_method:
					description = command_doc_desc(_arg_plain)
					if is_undefined(description) description = command_doc_desc(script_get_name(value))
				break
				case dt_real:
					description = "Constant with value of "+string(value)
				break
				case dt_string:
					description = "Constant with value of \""+string(value)+"\""
				break
				case dt_variable:
					if is_string(value)
					{
						description = "Shortcut for "+value
				
						var _value = string_add_scope(value, true)
						if not is_undefined(_value) value = _value
						
						var info
						info = variable_string_info(value)
						
						if info.exists
						{
							if is_struct(info.value)		description += " (holds "+instanceof(info.value)+")"
							else if is_array(info.value)	description += " (holds array)"
							else if is_ptr(info.value)		description += " (holds pointer)"
							else if is_method(info.value)	description += " (holds method)"
							else if is_bool(info.value)		description += " ("+(info.value ? "true" : "false")+")"
							else if is_string(info.value)
							{
								if string_length(info.value) > 300 or (string_height(info.value)/string_height("W")) > 1 description += " (holds string)"
								else description += " (\""+info.value+"\")"
							}
							else if is_numeric(info.value) and ds_map_exists(ds_types, _arg)
							{
								description = "(holds ds_"+ds_type_to_string(ds_types[? _arg])+"; index "+string(variable.value)+")"
							}
							else description += " ("+string(info.value)+")"
						}
						else description += " (does not exist?)"
					}
					else if is_real(value) and better_script_exists(value)
					{
						description = "Shortcut for "+script_get_name(value)+"()"
					}
			}
		}
		else if better_instance_exists(arg_real)  // Has instance
		{
			type = dt_instance
			value = arg_real
			
			description = object_get_name(arg_real.object_index)+" ("+string(arg_real.id)+")"
		}
		else
		{
			error = exceptionInstanceNotExists
		}
	}
	else if iden_type != ""  // Has identifier and isn't numeric
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
					
					description = string_capitalize(asset_type_to_string(asset_get_type(_arg)))+" asset "+string(asset)
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
					
					description = command_doc_desc(_arg_plain)
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
		type = dt_string
		value = slice(_arg, 2, -1-(arg_last == "\""), 1)
	}
	else
	{
		var asset = asset_get_index(_arg)
		if asset != -1
		{
			value = asset
			type = dt_asset
			
			switch asset_get_type(_arg)
			{
				default:
					show_debug_message(asset_get_type(_arg))
					description = string_capitalize(asset_type_to_string(asset_get_type(_arg)))+" asset "+string(asset)
				break
				case asset_object:
					if instance_exists(asset)
					{
						type = dt_instance
						var count = instance_number(asset)
						description = stitch("Object asset ",asset," (",count,((count == 1) ? " instance":" instances")+"; implicit ID ",asset.id,")")
					}
					else
					{
						description = "Object index "+string(asset)+" (no instances)"
					}
				break
				case asset_script: 
					type = dt_method
					description = command_doc_desc(_arg)
			}
		}
		else
		{
			variable = variable_string_info(_arg)
			if variable.error == exceptionVariableNotExists error = exceptionUnrecognized
			else error = variable.error
			
			if variable.exists
			{			
				type = dt_variable
				value = string_add_scope(_arg, true)
				
				description = value
				
				if is_struct(variable.value)		description += " (holds "+instanceof(variable.value)+")"
				else if is_array(variable.value)	description += " (holds array)"
				else if is_ptr(variable.value)		description += " (holds pointer)"
				else if is_method(variable.value)	description += " (holds method)"
				else if is_bool(variable.value)		description += " ("+(variable.value ? "true" : "false")+")"
				else if is_string(variable.value)
				{
					if string_length(variable.value) > 300 or (string_height(variable.value)/string_height("W")) > 1 description += " (holds string)"
					else description += " (\""+variable.value+"\")"
				}
				else if is_numeric(variable.value) and ds_map_exists(ds_types, _arg)
				{
					description = "(holds ds_"+ds_type_to_string(ds_types[? _arg])+"; index "+string(variable.value)+")"
				}
				else
				{
					description += " ("+string(variable.value)+")"
				}
			}
		}
	}
}

if not is_undefined(error) and error != exceptionUnrecognized description = error
else if error == exceptionUnrecognized
{
	description = command_doc_desc(string(arg))
}

return {
	value: value, 
	type: type,
	plain: string(arg),
	error: error,
	description: description,
}
}}