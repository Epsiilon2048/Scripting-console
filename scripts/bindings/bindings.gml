// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function bindings(){ with o_console {

if array_length(keybinds) > 0
{
	var text = []

	for(var i = 0; i <= array_length(keybinds)-1; i++)
	{
		array_insert(text, i*2, {str: stitch("[",i,"]"), scr: unbind, args: [i, true], output: true},stitch(" ",keybinds[i].keyname," - RUN COMMAND: ",keybinds[i].name,"\n"))
	}

	text[array_length(text)] = "\nClick on binding numbers to unbind"

	o_console.Output.embedding = true
	return text
}
else
{
	return "No active keybinds!"
}
}}