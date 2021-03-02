
function console_run(compiled_command){ with o_console {

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
		case DT.SCRIPT: //run a script
	
			var _args = array_create(array_length(com[i].args))
			
			for(var j = 0; j <= array_length(_args)-1; j++)
			{
				_args[j] = com[i].args[j].value
			}
			try 
			{
				if instance_exists(object) 
					{ with object output_string[i] = script_execute_ext(subject.value, _args) }
				else 
								{ output_string[i] = script_execute_ext(subject.value, _args) }
			}
			catch(_exception)
			{
				output_string[i] = {__embedded__: true, o: [{str: "[SCRIPT ERROR]", scr: error_report, output: true}," "+_exception.message]}
				prev_longMessage = _exception.longMessage
			}
		
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
				else			   string_value = string(_value)
				
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
	
			output_string[i] = "Asset index "+string(asset_get_index(subject.plain))
		break
	
		case undefined:
		
			output_string[i] = "[SYNTAX ERROR] from \""+subject.plain+"\""
		}
	}
	else
	{
		output_string[i] = com[i].error
	}
	}
}
return output_string
}}