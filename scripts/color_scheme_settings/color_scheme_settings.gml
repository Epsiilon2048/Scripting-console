// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function color_scheme_settings(){

o_console.Output.embedding = true
return [
	{str: "Greenbeans ",	scr: color_scheme, arg: cs.greenbeans},
	{str: "\nRoyal ",	scr: color_scheme, arg: cs.royal},
	{str: "\nDrowned",		scr: color_scheme, arg: cs.drowned},
	{str: "\nHelios",		scr: color_scheme, arg: cs.helios},
	{str: "\nHumanrights",	scr: color_scheme, arg: cs.humanrights},
	{str: "\nBlack & white",	scr: color_scheme, arg: cs.blackwhite},
	{str: "\nWhite & black",	scr: color_scheme, arg: cs.whiteblack},
	"\n\n",
	{str: "", checkbox: "o_console.rainbow"}," gamer mode",
	"\n\n",
	{str: "Regenerate color schemes", scr: generate_color_schemes},

	"\n\nClick on a palette to try it out!"
]
}