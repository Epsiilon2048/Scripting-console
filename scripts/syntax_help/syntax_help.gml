// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function syntax_help(){ with o_console {
	
o_console.Output.embedding = true
return [ //note that this only takes the colors from the current color scheme; doesn't change with it
	"Supported datatypes/references\n",
	{str:"integers",col:colors.number}," - ",{str:"floats",col:colors.number}," - ",{str:"macros",col:colors.macro},"* - ",{str:"strings",col:colors.string}," - ",{str:"objects",col:colors.object}," - ",{str:"variables",col:colors.variable},"\n\n"+
	
	"- ",{str:"scripts",col:colors.script}," are also supported, but cannot be used in arguments.\n"+
	"- When variables are referenced in arguments, they return their value.\n"+
	"- Note that if a script asks for a variable or command as an argument, it's likely \n"+
	"  intended to be a string\n"+
	
	"\nSetting scope:     ",{str:"object",col:colors.object},
	"\nGetting variables: ",{str:"object",col:colors.object},{str:".variable",col:colors.variable},
	"\nSetting variables: ",{str:"object",col:colors.object},{str:".variable",col:colors.variable},{str:" value",col:colors.plain},
	"\nRunning scripts:   ",{str:"script",col:colors.script},{str:" argument0",col:colors.plain},{str:" argument1 (...)",col:colors.plain},
	"\n\nMultiple commands can be run in a single line when separated by semi-colons (;)"+
	"\nNote that this means strings currently cannot contain semi-colons"+
	"\n\n*consult readme file for more info"
]
}}