
function color_scheme(value){				with o_console {

if not is_undefined(color_schemes[$ value])
{
	colors = color_schemes[$ value]
	
	color_string = color_console_string(console_string)
	cs_index = value

	if run_in_embed and (Output.tag == color_scheme_settings)
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
	


	
function error_report(){
return string_replace_all(o_console.prev_longMessage, "▯", "")
}
	
	
	

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
	action: function(){ console_exec(name) },
	built_in: false
}

return {__embedded__: true, o: [{str:"[BINDINGS]", scr: bindings, output: true}," Bound "+_keyname+" to \""+command+"\""]}
}}




function unbind(index, show_bindings){		with o_console {
	
var keybind = keybinds[index]
	
array_delete(keybinds, index, 1)

if show_bindings return bindings()
else return {__embedded__: true, o: [{str: "[BINDINGS]", scr: bindings, output: true}," Removed keybind "+keybind.keyname+" - "+keybind.name]}
}}




function bindings(){						with o_console {

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