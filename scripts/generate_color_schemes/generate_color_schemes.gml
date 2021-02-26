
function generate_color_schemes(){

/*
body		The background of the console
body_real	The background of the consone when the blendmode and alpha isn't applied
body_bm
body_alpha
output		The output, generally used as an accent color
ex_output	The exposed output; the output when it doesn't have a background
embed		Text with embeds
embed_hover	Text with embeds when the mouse is hovering over them

// These are specific for the command text
plain		Input which isn't understood to represent anything
selection	The color of the text that's selected
string		
number		
macro
variable
object
script
*/

var dark_blue = RGB(34, 50, 66)
var green	  = RGB(40, 235, 134)
var white	  = c_white
var black	  = c_black
var yellow	  = RGB(252, 252, 0)
var red		  = RGB(247, 116, 129)
var cyan	  = RGB(64, 220, 255)
var orange	  = RGB(255, 184, 113)

color_schemes[cs.greenbeans] = {
	body:		-dark_blue,
	body_real:	 dark_blue,
	body_bm:	 bm_subtract,
	body_alpha:  1,
	output:		 green,
	ex_output:	 green,
	embed:		 yellow,
	embed_hover: orange,
	plain:		 white,
	selection:	 black,
	string:		 yellow,
	number:		 red,
	macro:		 red,
	variable:	 cyan,
	object:		 red,
	script:		 orange,
}

var dark_pink = RGB(55,  34, 66)
var pink	  = RGB(240, 58, 125)
var white	  = c_white
var purple	  = RGB(140, 62, 250)
var yellow	  = RGB(250, 221, 35)

color_schemes[cs.royal] = {
	body:		-dark_pink,
	body_real:	 dark_pink,
	body_bm:	 bm_subtract,
	body_alpha:  1,
	output:		 pink,
	ex_output:	 white,
	embed:		 yellow,
	embed_hover: purple,
	plain:		 pink,
	selection:	 dark_pink,
	variable:	 purple,
	object:		 purple,
	macro:		 purple,
	string:		 yellow,
	number:		 pink,
	script:		 purple,
}

var dark_blue	= RGB(43, 52, 82)
var cyan		= RGB(58, 240, 206)
var white		= c_white
var pink		= RGB(214, 94, 220)
var yellow		= RGB(250, 221, 35)

color_schemes[cs.drowned] = {
	body:		-dark_blue,
	body_real:	 dark_blue,
	body_bm:	 bm_subtract,
	body_alpha:  1,
	output:		 cyan,
	ex_output:	 white,
	embed:		 yellow,
	embed_hover: pink,
	plain:		 cyan,
	selection:	 dark_blue,
	variable:	 pink,
	object:		 pink,
	macro:		 pink,
	string:		 yellow,
	number:		 cyan,
	script:		 pink,
}

var dark_pink	= RGB(84, 35, 59)
var orange		= RGB(242, 151, 37)
var green		= RGB(60, 233, 137)
var yellow		= RGB(246, 248, 44)

color_schemes[cs.helios] = {
	body:		-dark_pink,
	body_real:	 dark_pink,
	body_bm:	 bm_subtract,
	body_alpha:  1,
	output:		 orange,
	ex_output:	 white,
	embed:		 yellow,
	embed_hover: green,
	plain:		 orange,
	selection:	 dark_pink,
	variable:	 green,
	object:		 green,
	macro:		 green,
	string:		 yellow,
	number:		 orange,
	script:		 green,
}

var dark_pink	= RGB(44, 34, 54)
var pink		= RGB(255, 159, 255)
var blue		= RGB(127, 225, 255)
var white		= c_white

color_schemes[cs.humanrights] = {
	body:		-dark_pink,
	body_real:	 dark_pink,
	body_bm:	 bm_subtract,
	body_alpha:  1,
	output:		 pink,
	ex_output:	 white,
	embed:		 blue,
	embed_hover: white,
	plain:		 white,
	selection:	 dark_pink,
	variable:	 blue,
	object:		 blue,
	macro:		 pink,
	string:		 pink,
	number:		 pink,
	script:		 blue,
}

var true_black = c_black
var true_white = c_white
var black = RGB(14, 14, 15)
var white = RGB(219, 216, 215)

var light_grey  = RGB(138, 134, 136)

color_schemes[cs.whiteblack] = {
	body:		 black,
	body_real:	 black,
	body_bm:	 bm_normal,
	body_alpha:  1,
	output:		 light_grey,
	ex_output:	 true_white,
	embed:		 true_white,
	embed_hover: light_grey,
	plain:		 light_grey,
	selection:	 black,
	variable:	 true_white,
	object:		 true_white,
	macro:		 true_white,
	string:		 true_white,
	number:		 light_grey,
	script:		 true_white,
}

var dark_grey  = RGB(98, 96, 102)

color_schemes[cs.blackwhite] = {
	body:		 white,
	body_real:	 white,
	body_bm:	 bm_normal,
	body_alpha:  1,
	output:		 dark_grey,
	ex_output:	 true_black,
	embed:		 true_black,
	embed_hover: dark_grey,
	plain:		 dark_grey,
	selection:	 white,
	variable:	 true_black,
	object:		 true_black,
	macro:		 true_black,
	string:		 true_black,
	number:		 dark_grey,
	script:		 true_black,
}

o_console.rainbow = false
color_scheme(cs_index)
return stitch("Regenerated color schemes")
}