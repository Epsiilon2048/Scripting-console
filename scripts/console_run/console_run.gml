
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
		case DT.NUMBER: //return the number
			output_string[i] = subject.value
		break
		
		case DT.SCRIPT: //run a script
	
			var a = array_create(16, undefined)
			var _args_count = array_length(com[i].args)
			
			for(var j = 0; j <= _args_count-1; j++)
			{
				a[j] = com[i].args[j].value
			}
			
			run_in_console = true
			try 
			{
				//So, the reason I do this weird thing instead of using script_execute_ext is because for
				//reasons beyond human comprehension, gms... doesn't allow you to use arrays with built in
				//scripts?? like, normally it would pass the script an argument for each item in the array,
				//but with built ins it just passes the array as a single argument... wtf...
				
				//If for some reason you need to use scripts with more than 16 arguments, feel free to add
				//more i guess lol
				
				if instance_exists(object) 
					{ with object output_string[i] = subject.value(a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7], a[8], a[9], a[10], a[11], a[12], a[13], a[14], a[15]) }
				else 
					{			  output_string[i] = subject.value(a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7], a[8], a[9], a[10], a[11], a[12], a[13], a[14], a[15]) }
				
				if is_undefined(output_string[i]) output_string[i] = ""
			}
			catch(_exception)
			{
				output_string[i] = {__embedded__: true, o: [{str: "[SCRIPT ERROR]", scr: error_report, output: true}," "+_exception.message]}
				prev_longMessage = _exception.longMessage
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