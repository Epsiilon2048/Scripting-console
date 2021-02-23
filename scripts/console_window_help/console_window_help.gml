// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function console_window_help(){ with o_console {

o_console.Output.embedding = true
return [
	"The Window\n"+
	"- Shows static strings.\n"+
	"- If it's enabled in settings, you can click on the output to quickly set the window to it.\n"+
	"- Can be very helpful for keeping notes or navigating menus.\n"+
	"Syntax: ",{str:"window ",col:colors.script},{str:"value",col:colors.plain},"\n"+
	"Commands: ",{str:"window",col:colors.script},", ",{str:"window_reset_pos",col:colors.script},"\n\n"+

	"The Display\n"+
	"- Displays variables and their values.\n"+
	"- Remember, though the argument references a variable, make sure the variable name is a string.\n"+
	"Syntax: ",{str:"display ",col:colors.script},{str:"\"object.variable\"",col:colors.string},"\n"+
	"Commands: ",{str:"display",col:colors.script},", ",{str:"displayds",col:colors.script},", ",{str:"display_clear",col:colors.script},", ",{str:"display_reset_pos",col:colors.script},", ",{str:"display_all",col:colors.script},", ",{str:"display_toggle_objects",col:colors.script},"\n\n"+
	
	"You can drag windows from their sidebar, and collapse them by clicking it.\n\n"+
	
	"Click to show ",{str: "Window", scr: window, arg: "This is the Window!"}, " - ",{str: "Display", scr: display, arg: "o_console.is_this_the_display"},
]
}}