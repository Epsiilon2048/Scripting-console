// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function help(){

return {__embedded__: true, o: [
	"Help & info\n",
	{str: "Basic syntax & usage", scr: syntax_help, output: true},
	{str: "\nCommand list", scr: command_help, output: true},
	{str: "\nConsole windows", scr: console_window_help, output: true},
	{str: "\nEmbedded text", scr: embedded_text_help, output: true},
	{str: "\nVideos", scr: console_videos, output: true},
	
	"\n\nOptions\n",
	{str: "General settings", scr: console_settings, output: true},
	{str: "\nColor schemes", scr: color_scheme_settings, output: true},
	
	"\n\nOther stuff\n",
	{str: "Instances in room", scr: roomobj, output: true},
	{str: "\nSay a nice thing!", scr: nice_thing, output: true},
	{str: "\nGithub page", scr: url_open, arg: "https://github.com/Epsiilon2048/gms-script-console"}," [link]",
	{str: "\nCreator info", scr: Epsiilon, output: true},
	
	"\n\nNote, you can press [shift+console_key]\n"+
	"to quickely return to this menu!"
]}
}