
function console_log_input(input, output, is_bind){ with o_console {

static max_byte_size = power(512, 2)  // 512 KB

var _is_bind = is_undefined(is_bind) ? false : is_bind

if input == "" ds_list_add(log, {type: lg_whitespace})

else
{
	ds_list_add(log, {type: _is_bind ? lg_bindinput : lg_userinput, value: input})
	
	for(var i = 0; i <= array_length(output)-1; i++)
	{
		if variable_struct_exists_get(output[i], "__embedded__", false) ds_list_add(log, {
			type: lg_embed, 
			value: is_undefined(output[@ i][$ "name"]) ? "Unidentified" : output[i].name
		})
		
		else ds_list_add(log, {
			type: lg_output,
			value: (value_byte_size(output[i]) > max_byte_size) ? "Value exceeding "+string(max_byte_size)+" bytes" : output[i]
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