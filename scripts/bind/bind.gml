// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function bind(_keyname, command){ with o_console {
//though proper key macros are supported, it's much better to use strings so they can be read by the user

var _key = -1

if is_string(_keyname) 
{
	if console_macros[? _keyname] != undefined 
	{
		_key = console_macros[? _keyname]
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

Output.embedding = true
return [{str:"[BINDINGS]", scr: bindings, output: true}," Bound "+_keyname+" to \""+command+"\""]
}}