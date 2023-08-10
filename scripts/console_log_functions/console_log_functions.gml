
function console_log_input(input, output, is_bind){ with o_console {

static max_byte_size = 512*8 * 1024  // 512 KB

var _is_bind = is_undefined(is_bind) ? false : is_bind

if input == "" ds_list_add(log, {type: lg_whitespace})

else
{
	ds_list_add(log, {type: _is_bind ? lg_bindinput : lg_userinput, value: input})
	
	for(var i = 0; i <= array_length(output)-1; i++)
	{
		var is_embed = variable_struct_exists_get(output[i], "__embedded__", false)
		
		if is_embed or (is_struct(output[i]) and variable_struct_exists(output[i], "__name__")) ds_list_add(log, {
			type: is_embed ? lg_embed : lg_output, 
			value: is_undefined(output[@ i][$ "__name__"]) ? "Unidentified" : output[i].__name__
		})
		
		else ds_list_add(log, {
			type: lg_output,
			value: 0//(value_byte_size(output[i]) > max_byte_size) ? "Value exceeding "+string(max_byte_size)+" bytes" : output[i]
		})
	}
}
}}




function console_log_message(msg){

ds_list_add(o_console.log, {type: lg_message, value: msg})
}




function log_clear(){

ds_list_clear(o_console.log)
}