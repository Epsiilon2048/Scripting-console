
function gmcl_interpret_subject_old(subject, argument_total){
///@description gmcl_interpret_subject(subject, [argument_total])

var _arg = subject
var arg
var type = -1
var value = undefined
var error = undefined
var description = undefined

var iden = false

if string_char_at(_arg, 2) == "/" and variable_struct_exists(identifiers, string_char_at(_arg, 1))
{
	type = identifiers[$ string_char_at(_arg, 1)]
	_arg = string_copy(_arg, 3, string_length(_arg))
	iden = true
}

if _arg == "" 
{
	type = undefined
	arg = subject
}
else
{
	var _macro = console_macros[$ _arg]
	
	if type == -1 and not is_undefined(_macro)
	{
		if _macro.type == dt_real arg = string_format_float(_macro.value)
		else					  arg = string(_macro.value)
		
		type = _macro.type
	}
	else arg = _arg

	if type == dt_string or (type == -1 and string_char_at(arg, 1) == "\"" and string_last(arg) == "\"")
	{
		if string_char_at(arg, 1) == "\"" and string_last(arg) == "\"" value = string_copy(arg, 2, string_length(arg)-2)
		else value = arg
		
		type = dt_string
	}

	if type == dt_color
	{
		if string_is_float(arg) or string_is_float("0x"+arg)
		{
			if not (not is_undefined(_macro) and _macro.type == dt_color) value = hex_to_color(arg)
			else value = real(arg)
		}
		else type = undefined
	}

	if (type == -1 or type == dt_instance or type == dt_method) and asset_get_index(arg) != -1
	{
		var asset_type = asset_get_type(arg)
		var asset_index = asset_get_index(arg)
		
		switch asset_type
		{
		case asset_script:	type = dt_method
							value = asset_index
		break
		case asset_room:	type = dt_room
							value = asset_index
		break
		case asset_object:
			if instance_exists(asset_index)
			{
				type = dt_instance
				value = asset_index.id
			}
			else description = "Object index "+string(asset_index)+" (no instance)"
		}
		
		if type == -1 
		{
			type = dt_asset
			description = "Asset index "+string(asset_index)
		}
	}
	else if type == dt_instance and not string_is_int(arg) 
	{
		type = undefined
		error = "Object with name "+arg+" does not exist"
	}
	else if type == dt_method
	{
		if string_is_int(arg)
		{
			if not is_method(real(arg)) and not script_exists(real(arg)) and is_undefined(_macro)
			{
				type = undefined
				error = "Method with ID "+string(real(arg))+" does not exist"
			}
			else value = real(arg)
		}
		else if is_undefined(_macro)
		{
			type = undefined
			error = "Method with name "+arg+" does not exist"
		}
	}
	
	if (type == -1 or type == dt_instance) and string_is_int(arg)
	{
		if type != dt_instance and string_pos("0x", arg)
		{
			type = dt_real
		}
		else if better_instance_exists(real(arg)) or real(arg) == noone
		{
			type = dt_instance
			if object_exists(real(arg)) value = real(arg).id
			else value = real(arg)
		}
		else 
		{
			type = undefined
			error = "Instance with ID "+string(real(arg))+" does not exist"
		}
	}
	
	if type == dt_real
	{
		if string_is_float(arg) value = string_format_float(arg)
		else type = undefined
	}
	
	if type == -1 or type == dt_variable 
	{
		var varstring = string_add_scope(arg, not iden)

		if not is_undefined(varstring) and variable_string_exists(varstring)
		{
			var varstringvalue = variable_string_get(varstring)
			
			if type != dt_variable and is_method(varstringvalue)
			{
				type = dt_method
				value = varstringvalue
			}
			else
			{
				type = dt_variable
				value = varstring
			}
		}
		else
		{
			type = undefined
		}
	}
	
}

if is_undefined(type) and is_undefined(error) error = "Syntax error from \""+arg+"\""

if is_undefined(description) switch type
{ 
case dt_asset:		description = "Return object index"
break
case dt_color:		description = "Return color value properties"
break
case dt_instance:	description = (value == noone) ? "Reset console scope" : ("Set console scope to "+object_get_name(value.object_index))
break
case dt_method:		if is_undefined(commands[? _arg]) description = "Execute"+((value > 10000) ? "" : " builtin")+" method "+(string_is_int(arg) ? script_get_name(real(arg)) : arg)
					else description = command_doc(_arg)+((commands[? _arg].desc == "") ? "" : " - "+commands[? _arg].desc)
break
case dt_real:		description = "Return real value of "+arg
break
case dt_string:		description = "Echo string"
break
case dt_variable:	description = is_undefined(argument_total) ? "Get or set variable "+arg : ((argument_total > 1) ? "Set variable "+arg : "Get variable "+arg)
break
case undefined:		description = ds_map_exists(deprecated_commands, arg) ? command_doc(arg) : "Unrecognized"
break
}

return {
	value: value,
	type: type,
	plain: subject,
	error: error,
	description: description
}
}