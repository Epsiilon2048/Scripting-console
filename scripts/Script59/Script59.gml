
function gmcl_interpret_subject(subject, argument_total){
///@description gmcl_interpret_subject(subject, [argument_total])

var _arg = subject
var arg
var type = -1
var value = undefined
var error = undefined

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

	if type == dt_string or (type == -1 and string_char_at(arg, 1) == "\"" and string_pop(arg) == "\"")
	{
		if string_char_at(arg, 1) == "\"" and string_pop(arg) == "\"" value = string_copy(arg, 2, string_length(arg)-2)
		else value = arg
		
		type = dt_string
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
		}
		
		if type == -1 type = dt_asset
	}
	else if type == dt_instance and not string_is_int(arg) type = undefined
	else if type == dt_method and string_is_int(arg) value = real(arg)
	
	if (type == -1 or type == dt_instance) and string_is_int(arg)
	{
		if string_pos("0x", arg) 
		{
			type = dt_real
		}
		else if instance_exists(real(arg)) or real(arg) == noone
		{
			type = dt_instance
			if object_exists(real(arg)) value = real(arg).id
			else value = real(arg)
		}
		else 
		{
			type = undefined
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

var description

if is_undefined(type) error = "[SYNTAX ERROR] from \""+arg+"\""

switch type
{
case dt_asset:		description = "Returning asset index"
break
case dt_color:		description = "Returning color value properties"
break
case dt_deprecated: description = ""
break
case dt_instance:	description = "Setting console scope to "+subject
break
case dt_method:		description = "Executing method "+subject
break
case dt_real:		description = "Returning real value of "+subject
break
case dt_room:		description = "Switching to room "+room_get_name(value)
break
case dt_string:		description = "Echoing string "+subject
break
case dt_unknown:	description = "Unrecognized"
break
case dt_variable:	description = is_undefined(argument_total) ? "Getting or setting variable "+subject : ((argument_total > 1) ? "Setting variable "+subject : "Getting variable "+subject)
break
case undefined:		description = "Unrecognized"
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