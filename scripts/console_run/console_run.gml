
function console_run(compiled_command){ with o_console {

try
{
var com = compiled_command
var output_string = array_create(array_length(com))

for(var i = 0; i <= array_length(com)-1; i++)
{
	if com[i] == 0
	{
		output_string[i] = 0
	}
	else
	{
	if is_undefined(com[i].error)
	{
		var subject = com[i].subject
	
		switch subject.type
		{
		case DT.NUMBER: //return the number
			output_string[i] = subject.value
		break
		
		case DT.SCRIPT: //run a script
	
			var a = array_struct_get(com[i].args, "value")
			
			run_in_console = true
			try 
			{
				if instance_exists(object) with object
				{ 
					if subject.builtin output_string[i] = script_execute_ext_builtin(subject.value, a)
					else			   output_string[i] = script_execute_ext(subject.value, a)
				}
				else 
				{
					if subject.builtin output_string[i] = script_execute_ext_builtin(subject.value, a)
					else			   output_string[i] = script_execute_ext(subject.value, a)
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
	
		case DT.OBJECT: //set the console scope
	
			object = subject.value
			
			if subject.value == noone output_string[i] = "Reset console scope"
			else output_string[i] = (
				"Scope set to "+stitch(object_get_name(subject.value.object_index)," ",subject.value)
			)
	
		break
	
		case DT.ROOM: //switch to a room
	
			room_goto(asset_get_index(subject.plain))
			output_string[i] = "Changed room to "+subject.plain
	
		break
	
		case DT.VARIABLE: //set or display a variable
	
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
	
		case DT.ASSET: //return an asset id
	
			var _asset = string_delete(subject.plain, 1, string_pos("/", subject.plain))
	
			output_string[i] = "Asset index "+string(asset_get_index(_asset))
		break
	
		case DT.STRING:
		
			output_string[i] = "\""+subject.value+"\""
			
		break
	
		case undefined:
		
			output_string[i] = format_output([{str: "[SYNTAX ERROR]", scr: compile_report, output: true}," from \""+subject.plain+"\""], true, -1)
		}
	}
	else
	{
		output_string[i] = com[i].error
	}
	}
}
return output_string
}
catch(_exception)
{
	prev_exception = _exception
	return [format_output([{str: "[CONSOLE ERROR]", scr: error_report, output: true}," Awfully sorry about this! It seems the console encountered a runtime error."], true, -1)]
}
}}