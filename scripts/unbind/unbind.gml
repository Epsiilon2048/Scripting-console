// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function unbind(index, show_bindings){ with o_console {
	
var keybind = keybinds[index]
	
array_delete(keybinds, index, 1)

o_console.Output.embedding = true
if show_bindings return bindings()
else return [{str: "[BINDINGS]", scr: bindings, output: true}," Removed keybind "+keybind.keyname+" - "+keybind.name]
}}