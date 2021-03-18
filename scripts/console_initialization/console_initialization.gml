
function initialize_color_schemes(){

/*
body		The background of the console
body_real	The background of the consone when the blendmode and alpha isn't applied
body_bm
body_alpha
body_accent
output		The output, generally used as an accent color
ex_output	The exposed output; the output when it doesn't have a background
embed		Text with embeds
embed_hover	Text with embeds when the mouse is hovering over them

// These are specific for the command text
plain		Input which isn't understood to represent anything
selection	The color of the text that's selected
string
real
variable
instance
method
room
asset
*/

var dark_blue    = RGB(34, 50, 66)
var green	     = RGB(40, 235, 134)
var slight_green = RGB(40, 80, 102)
var white	     = c_white
var black	     = c_black
var yellow	     = RGB(252, 252, 0)
var red		     = RGB(247, 116, 129)
var cyan	     = RGB(64, 220, 255)
var orange	     = RGB(255, 184, 113)

color_schemes[$ "greenbeans"] = {
	body:		-dark_blue,
	body_real:	 dark_blue,
	body_bm:	 bm_subtract,
	body_alpha:  1,
	body_accent: slight_green,
	output:		 green,
	ex_output:	 green,
	embed:		 yellow,
	embed_hover: orange,
	plain:		 white,
	selection:	 black,
	string:		 yellow,
	real:		 red,
	variable:	 cyan,
	instance:	 red,
	method:		 orange,
	asset:		 red,
	
	__builtin__ : true
}
color_schemes.greenbeans[$ "room"] = red

var dark_pink   = RGB(55,  34, 66)
var slight_pink = 4466264
var pink	    = RGB(240, 58, 125)
var white	    = c_white
var purple	    = RGB(140, 62, 250)
var yellow	    = RGB(250, 221, 35)

color_schemes[$ "royal"] = {
	body:		-dark_pink,
	body_real:	 dark_pink,
	body_bm:	 bm_subtract,
	body_alpha:  1,
	body_accent: slight_pink,
	output:		 pink,
	ex_output:	 white,
	embed:		 yellow,
	embed_hover: purple,
	plain:		 pink,
	selection:	 dark_pink,
	variable:	 purple,
	instance:	 purple,
	string:		 yellow,
	real:		 pink,
	method:		 purple,
//	room:		 purple,
	asset:		 purple,
	
	__builtin__ : true
}

var dark_blue	= RGB(43, 52, 82)
var slight_blue = 8087596
var cyan		= RGB(58, 240, 206)
var white		= c_white
var pink		= RGB(214, 94, 220)
var yellow		= RGB(250, 221, 35)

color_schemes[$ "drowned"] = {
	body:		-dark_blue,
	body_real:	 dark_blue,
	body_bm:	 bm_subtract,
	body_alpha:  1,
	body_accent: slight_blue,
	output:		 cyan,
	ex_output:	 white,
	embed:		 yellow,
	embed_hover: pink,
	plain:		 cyan,
	selection:	 dark_blue,
	variable:	 pink,
	instance:	 pink,
	string:		 yellow,
	real:		 cyan,
	method:		 pink,
//	room:		 pink,
	asset:		 pink,
	
	__builtin__ : true
}

var dark_pink	= RGB(84, 35, 59)
var slight_pink = 4994672
var orange		= RGB(242, 151, 37)
var green		= RGB(60, 233, 137)
var yellow		= RGB(246, 248, 44)

color_schemes[$ "helios"] = {
	body:		-dark_pink,
	body_real:	 dark_pink,
	body_bm:	 bm_subtract,
	body_alpha:  1,
	body_accent: slight_pink,
	output:		 orange,
	ex_output:	 white,
	embed:		 yellow,
	embed_hover: green,
	plain:		 orange,
	selection:	 dark_pink,
	variable:	 green,
	instance:	 green,
	string:		 yellow,
	real:		 orange,
	method:		 green,
//	room:		 green,
	asset:		 green,
	
	__builtin__ : true
}

var dark_pink	= RGB(44, 34, 54)
var slight_blue = 9261387
var pink		= RGB(255, 159, 255)
var blue		= RGB(127, 225, 255)
var white		= c_white

color_schemes[$ "humanrights"] = {
	body:		-dark_pink,
	body_real:	 dark_pink,
	body_bm:	 bm_subtract,
	body_alpha:  1,
	body_accent: slight_blue,
	output:		 pink,
	ex_output:	 white,
	embed:		 blue,
	embed_hover: white,
	plain:		 white,
	selection:	 dark_pink,
	variable:	 blue,
	instance:	 blue,
	string:		 pink,
	real:		 pink,
	method:		 blue,
//	room:		 pink,
	asset:		 pink,
	
	__builtin__ : true
}

o_console.rainbow = false
color_scheme(cs_index)
return stitch("Regenerated color schemes")
}