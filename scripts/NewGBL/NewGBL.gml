
function GBL_term(term, is_subject=false, has_parentheses=false) constructor{

raw = string(term)		// Original term
condensed = raw			// Term without identifier
type = dt_unknown		// Assumed datatype
identifier = dt_unknown	// Specified datatype
value = undefined		// Interpreted value
description = ""		// For intellisense
scope = noone			// For variable and methdos

self.is_subject = is_subject
self.has_parentheses = has_parentheses

simple = true			// If the value is a constant

compiles = true
error = ""


var asset = asset_unknown
var asset_type = asset_unknown


// Check if numeric
if string_is_float(raw)
{
	value = real(raw)
	type = dt_real
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
	
		value = condensed
		
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
			var split = string_split(",", condensed)
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
				}
				else error = exceptionScriptNotExists
			}
			else if asset_get_type(condensed) == asset_script
			{
				value = asset_get_index(condensed)
			}
			else
			{
				simple = false
				
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
break
case asset_font:
break
case asset_object:
break
case asset_path:
break
case asset_room:
break
case asset_script:
break
case asset_sequence:
break
case asset_shader:
break
case asset_sound:
break
case asset_sprite:
break
case asset_tiles:
break
case asset_timeline:
break
}


if error != "" compiles = false
}



function GBL_interpret(command){

static term_sep = " ,\""

var args = []

var marker = 1
var index = 1

while index <= string_length(command)
{
	
	
	index ++
}
}


function GBL_Compile() constructor{

compile = function(){

}
}