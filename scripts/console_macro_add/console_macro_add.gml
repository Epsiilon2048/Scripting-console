
function better_script_exists(ind){
	return ind >= 0 and script_get_name(ind) != "<unknown>"
}

function console_macro_add(name, type, value){

o_console.console_macros[$ name] = {type: type, value: value}
}

function console_macro_add_builtin(){ 

for(var i = 0; i <= 10000; i++)
{
	if script_exists(i) console_macro_add(script_get_name(i), dt_method, i)
}
}