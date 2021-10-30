
function color_scheme(value){ with o_console {

if not is_undefined(color_schemes[$ value])
{
	colors = color_schemes[$ value]
	
	cs_index = value

	if run_in_embed
	{
		return color_scheme_settings()
	}
	else
	{
		return stitch("Console color scheme set to ",value)
	}
}
else return "No such color scheme exists!"
}}




function destroy_console(confirmation){

if confirmation
{
	instance_destroy(o_console)
}
else
{
	output_set({__embedded__: true, o: [
	"H-huh?? Unless you build your own method of getting it back, I'll be gone for the rest of the runtime!\nCould break some stuff too!! S-seriously, I bet it'll crash the moment you do it!\n",
	"Are you absolutely sure? <",{str: "yep!", scr: destroy_console, arg: true},">"
	]})
}
}
	


	
function error_report(){ with o_console {

var list

if variable_struct_exists(prev_exception, "stacktrace")
{
	list = array_create(array_length(prev_exception.stacktrace)+1)
	list[0] = {str: "Stacktrace\n", col: o_console.colors.variable}

	for(var i = 0; i <= array_length(prev_exception.stacktrace)-1; i++)
	{
		list[i+1] = string_replace_all(prev_exception.stacktrace[i], "	", "")+"\n"
	}
}
else list = []

if variable_struct_exists(prev_exception, "Long message") array_push(list, 
	"\n",
	{str: "longMessage", col: o_console.colors.variable},"\n"+
	prev_exception.longMessage
)

//return format_output(list, true, error_report)
return prev_exception
}}
	
	
	

function bind(_keyname, command){			with o_console {
//though proper key macros are supported, it's much better to use strings so they can be read by the user

var _key = -1

if is_string(_keyname) 
{
	if console_macros[$ _keyname] != undefined 
	{
		_key = console_macros[$ _keyname].value
		_keyname = string_copy(_keyname, 4, string_length(_keyname)-3)
	}
	else
	{
		_key = ord(string_upper(_keyname))
		_keyname = string_upper(_keyname)
	}
}

keybinds[array_length(keybinds)] = 
{
	name: command,
	key: _key,
	keyname: _keyname,
	action: function(){ gmcl_exec(name) },
	built_in: false
}

return format_output([{str:"[BINDINGS]", scr: bindings, output: true}," Bound "+string(_keyname)+" to \""+string(command)+"\""], true, -1, "Bind key")
}}




function unbind(index, show_bindings){ with o_console {
	
var keybind = keybinds[index]
	
array_delete(keybinds, index, 1)

if show_bindings return bindings()
else return {__embedded__: true, o: [{str: "[BINDINGS]", scr: bindings, output: true}," Removed keybind "+keybind.keyname+" - "+keybind.name]}
}}




function bindings(){ with o_console {

if array_length(keybinds) > 0
{
	var text = []

	for(var i = 0; i <= array_length(keybinds)-1; i++)
	{
		array_insert(text, i*2, {str: stitch("[",i,"]"), scr: unbind, args: [i, true], output: true},stitch(" ",keybinds[i].keyname," - RUN COMMAND: ",keybinds[i].name,"\n"))
	}

	text[array_length(text)] = "\nClick on binding numbers to unbind"

	return {__embedded__: true, o: text}
}
else
{
	return "No active keybinds!"
}
}}