
function gmcl_run(compiled_command){ with o_console {

/*
ACTION BASED ON SUBJECT DATATYPE
REAL (base10)	Set console scope to asset index or instance id
REAL (base16)	Return base10 of
STRING			Return
METHOD			Run method with args
OBJECT			Set console scope to asset index
ROOM			Change to room
ASSET			Return asset index
UNDEFINED		Throw error
*/

try{
	
if compiled_command == "" return ""	

var com = compiled_command.commands
var tag = compiled_command.tag

if not is_undefined(event_commands[$ tag])
{
	array_push(event_commands[$ tag], compiled_command.raw)
	return ["Added command to "+tag+" event"]
}

var output_string = array_create(array_length(com), "")

for(var i = 0; i <= array_length(com)-1; i++)
{
	if com[i] == 0
	{
		output_string[i] = 0
	}
	else
	{
		if not is_undefined(com[i].error) output_string[i] = com[i].error

		else
		{
			var subject = com[i].subject
	
			switch subject.type 
			{
			#region Real
			case dt_real:
				output_string[i] = real(subject.value)
			break
			#endregion

			#region Method
			case dt_method:
	
				var a = array_struct_get(com[i].args, "value")
			
				run_in_console = true
				try 
				{
					if instance_exists(object) with object
					{ 
						output_string[i] = script_execute_ext_builtin(subject.value, a)
					}
					else 
					{
						output_string[i] = script_execute_ext_builtin(subject.value, a)
					}
				
					if is_undefined(output_string[i]) output_string[i] = ""
					else if is_real(output_string[i]) output_string[i] = string_format_float(output_string[i])
				}
				catch(_exception)
				{
					output_string[i] = {__embedded__: true, o: [{str: "[SCRIPT ERROR]", scr: error_report, output: true}," "+_exception.message]}
					prev_exception = _exception
				}
				run_in_console = false
		
			break
			#endregion
	
			#region Object
			case dt_instance:
				object = subject.value
			
				if subject.value == noone output_string[i] = "Reset console scope"
				else output_string[i] = (
					"Scope set to "+stitch(object_get_name(subject.value.object_index)," ",subject.value)
				)
			break
			#endregion

			#region Room
			case dt_room:
				room_goto(asset_get_index(subject.plain))
				output_string[i] = "Changed room to "+subject.plain
			break
			#endregion
		
			#region Variable	
			case dt_variable:
	
				//if there are multiple lines and one of them changes the scope of the console,
				//the variable will not be updated to the new scope
	
				if array_length(com[i].args) < 1
				{
					var _value = variable_string_get(subject.value)
				
					var string_value
					if is_real(_value) string_value = string_format_float(_value)
					else			   string_value = _value
				
					output_string[i] = string_value
				}
				else
				{
					var _value = com[i].args[0].value
				
					variable_string_set(subject.value, _value)
			
					var string_value
					if is_real(_value) string_value = string_format_float(_value)
					else			   string_value = string(_value)
			
					output_string[i] = "Set "+subject.plain+" to "+string_value
				}
	
			break
			#endregion
	
			#region Asset
			case dt_asset:
				var _asset = string_delete(subject.plain, 1, string_pos("/", subject.plain))

				if string_is_int(_asset)
				{
					if object_exists(real(_asset))	output_string[i] = "Object "+object_get_name(real(_asset))
					else							output_string[i] = "Noone"
				}
				else 
				{
					if asset_get_index(_asset) != -1	output_string[i] = "Asset index "+string(asset_get_index(_asset))
					else								output_string[i] = "Asset does not exist"
				}
			break
			#endregion
	
			#region String
			case dt_string:
				if string_pos("\n", subject.value)	output_string[i] = subject.value
				else								output_string[i] = "\""+subject.value+"\""
			break
			#endregion
	
			#region Undefined
			case undefined:
				output_string[i] = format_output(
					[{str: "[SYNTAX ERROR]", scr: compile_report, output: true}," from \""+subject.plain+"\""], 
				true, -1)
			#endregion
			}
		}
	}
}
return output_string

}
catch(_exception)
{
	
//damn tho wouldnt this suck
//i do know this happens when you put a variable left of a string without a separator, but no one's going
//to do that so i'm not going to debug it
prev_exception = _exception
return [format_output([{str: "[CONSOLE ERROR]", scr: error_report, output: true}," Awfully sorry about this! It seems the console encountered a runtime error."], true, -1)]

}
}}