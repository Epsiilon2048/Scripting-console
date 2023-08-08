
function GBL_term(term, is_subject=false, has_parentheses=false) constructor{

raw = string(term)		// Original term
condensed = raw			// Term without identifier
type = dt_unknown		// Assumed datatype
identifier = dt_unknown	// Specified datatype
value = undefined		// Interpreted value
description = ""		// For intellisense
scope = noone			// For variable and methdos
argument_max = 0		// The amount of arguments it takes if it's a subject

internal_term = undefined  // For code in strings

self.is_subject = is_subject
self.has_parentheses = has_parentheses

simple = true  // If the value is a constant

compiles = true
error = ""


var asset = asset_unknown
var asset_type = asset_unknown


// Check if numeric
if string_is_float(raw)
{	
	value = real(raw)
	type = dt_real
	
	if slice(raw, , 3) == "0x"
	{
		description += string(value)
	}
}


// Check if string
else if string_char_at(raw, 1) == "\"" or string_char_at(raw, 1) == "'"
{
	if string_last(raw) != "\"" and string_last(raw) != "'"
	{
		raw += string_char_at(raw, 1)
	}
	
	type = dt_string
	value = slice(raw, 2, -2)
}


// Extract identifier
else if string_char_at(raw, 2) == "/"
{
	identifier = o_console.identifiers[$ string_char_at(raw, 1)]
	condensed = slice(raw, 3)
	
	if is_undefined(identifier) or (has_parentheses and identifier != dt_method) // Throw unknown identifier
	{
		error = exceptionBadIdentifier
		identifier = dt_unknown
	}
	else type = identifier
}



// Interpret if has identifier
if identifier != dt_unknown
{	
	switch identifier
	{
	case dt_string: #region string
	
		simple = false
		value = condensed
		internal_term = new GBL_term(value, false, false)
		description = internal_term.description
		
	break #endregion
	case dt_asset: #region Assets
	
		asset = asset_get_index(condensed)
		asset_type = asset_get_type(condensed)
	
		if not o_console.sandbox.other_assets
		{
			error = exceptionUnrecognized
		}
		else if asset_type == asset_unknown and condensed != "asset_unknown"  // Throw unknown asset
		{
			error = exceptionAssetNotExists
		}
		else
		{
			if	(not o_console.sandbox.scripts and asset_type == asset_script) or
				(not o_console.sandbox.scripts and asset_type == asset_object)
			{
				error = exceptionUnrecognized
			}
			else value = asset
		}
		
	break #endregion
	case dt_color: #region Color
	
		if string_is_float(condensed)
		{
			value = real(condensed)
		}
		else if string_count(",", condensed) == 2
		{
			var split = string_split(condensed, ",")
			var red = split[0]
			var green = split[1]
			var blue = split[2]
			
			if not string_is_float(red) or not string_is_float(green) or not string_is_float(blue)
			{
				error = exceptionBotchedColor
			}
			else
			{
				value = make_color_rgb(red, green, blue)
			}
		}
		else if asset_get_index(condensed) != asset_unknown
		{
			value = asset_get_index(condensed) 
		}
		else
		{
			simple = false
			
			var info
			if is_struct(o_console.object) or instance_exists(o_console.object) with o_console.object info = variable_string_info(condensed)
			else info = variable_string_info(condensed)
			
			if info.exists
			{
				if is_numeric(info.value)
				{
					value = info.value
				}
				else error = exceptionExpectingNumeric
			}
			else error = exceptionVariableNotExists
		}
		
	break #endregion
	case dt_variable: #region Variable
	
		simple = false
		argument_max = 1
		
		var info = variable_string_info(condensed)
		if info.exists
		{
			value = info.value
		}
		else error = exceptionVariableNotExists
		
	break #endregion
	case dt_method: #region Method
		
		if not sandbox.scripts
		{
			error = exceptionUnrecognized
		}
		else
		{
			if string_is_int(condensed)
			{
				if better_script_exists(real(condensed))
				{
					value = real(condensed)
					argument_max = infinity
				}
				else error = exceptionScriptNotExists
			}
			else if asset_get_type(condensed) == asset_script
			{
				value = asset_get_index(condensed)
				argument_max = infinity
			}
			else
			{
				simple = false
				argument_max = infinity
				
				var info = variable_string_info(condensed)
				if info.exists
				{
					if is_numeric(info.value)
					{
						if better_script_exists(info.value)
						{
							value = info.value
						}
						else error = exceptionScriptNotExists
					}
					else if is_method(info.value) or asset_get_type(info.value) == asset_script
					{
						value = info.value
					}
				}
				else error = exceptionVariableNotExists
			}
		}
	
	break #endregion
	case dt_instance: #region Instance
	
		if not sandbox.instances
		{
			error = exceptionUnrecognized
		}
		else
		{
			simple = false
			
			if string_is_int(condensed)
			{
				if better_instance_exists(real(condensed))
				{
					value = real(condensed)
				}
				else if object_exists(real(condensed))
				{
					error = exceptionInstanceNotExists
				}
				else
				{
					error = exceptionInstanceNotExists
				}
			}
			else if asset_get_type(condensed) == asset_object
			{
				var asset = asset_get_index(condensed)
				if better_instance_exists(asset)
				{
					value = asset
				}
				else
				{
					error = exceptionInstanceNotExists
				}
			}
			else
			{
				var info = variable_string_info(condensed)
				if info.exists
				{
					if is_numeric(info.value)
					{
						if better_instance_exists(info.value)
						{
							value = info.value
						}
						else error = exceptionScriptNotExists
					}
					else if is_method(info.value) or asset_get_type(info.value) == asset_script
					{
						value = info.value
					}
				}
				else error = exceptionVariableNotExists
			}
		}
		
	break #endregion
	}
}


// Interpret without identifier
if type == dt_unknown
{
	var asset_type = asset_get_type(condensed)
	
	if asset_type != asset_unknown
	{
		type = dt_asset
		value = asset_get_index(condensed)
	}
}



switch asset_type
{
case asset_animationcurve:
	
	var curve = animcurve_get(value)
	description += curve.name+": Animcurve with "+string(array_length(curve.channels))+" channels"

break
case asset_font:
	
	var font = font_get_info(value)
	description += font_get_name(value)+": Contains font "+font.name+", size "+string(font.size)
	
break
case asset_object:
	
	var number = string(instance_number(value))
	description += object_get_name(value)+": Object with "+number+" instance"+((number == "1") ? "" : "s")
	
	if instance_exists(object_get_parent(value))
	{
		description += ", child of "+object_get_name(object_get_parent(value))
	}
	
break
case asset_path:

	description += path_get_name(value)+": Path with "+string(path_get_number(value))+" nodes"
	
break
case asset_room:

	description += room_get_name(value)+": room"

break
case asset_script:

	description += script_get_name(value)+": "

break
case asset_sequence:

	var sequence = sequence_get(value)
	description += sequence.name+": "
	
	if sequence.loopmode == seqplay_pingpong description += "Ping-pong sequence"
	else if sequence.loopmode == seqplay_loop description += "Looping sequence"
	else description += "Sequence"
	
break
case asset_shader:

	description += shader_get_name(value)+": "
	
	if shader_is_compiled(value) description += "Shader"
	if shader_is_compiled(value) description += "Uncompiled shader"

break
case asset_sound:

	description += audio_get_name(value)+": Sound"
	
break
case asset_sprite:

	description += stitch(sprite_get_name(value)+": ",sprite_get_width(value),"x",sprite_get_height(value)," sprite")

break
case asset_tiles:

	description += tileset_get_name(value)+": Tileset"

break
case asset_timeline:

	description += audio_get_name(value)+": Timeline"

break
}


if error != "" compiles = false
if description == "" description = error
}
