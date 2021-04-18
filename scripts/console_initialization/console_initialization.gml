
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
tag			The command tag, usually used for event commands
deprecated	Commands which have been removed or renamed
*/

var dark_blue    = RGB(34, 50, 66)
var green	     = RGB(40, 235, 134)
var slight_blue  = RGB(67, 88, 112)
var white	     = c_white
var yellow	     = RGB(252, 252, 0)
var red		     = RGB(247, 116, 129)
var cyan	     = RGB(64, 220, 255)
var orange	     = RGB(255, 184, 113)
var pink		 = RGB(224, 43, 240)
var purple		 = RGB(95, 86, 199)

color_schemes[$ cs_greenbeans] = create_color_scheme_full(
	dark_blue,		//body
	slight_blue,	//body accent
	bm_subtract,	//body blendmode
	.7,				//body alpha
	green,			//output
	green,			//exposed output
	yellow,			//embed
	orange,			//embed hover
	white,			//plain text
	red,			//real
	yellow,			//string
	cyan,			//variable
	orange,			//method
	red,			//asset
	pink,			//tag
	purple,			//deprecated
)
color_schemes[$ cs_greenbeans].__builtin__ = true



var dark_pink   = RGB(55,  34, 66)
var slight_pink = RGB(115, 61, 113)
var pink	    = RGB(240, 58, 125)
var white	    = c_white
var purple	    = RGB(140, 62, 250)
var yellow	    = RGB(250, 221, 35)

color_schemes[$ cs_royal] = create_color_scheme7(
	pink,
	dark_pink,
	slight_pink,
	pink,
	white,
	purple,
	yellow
)
color_schemes[$ cs_royal].__builtin__ = true



var dark_blue	= RGB(43, 52, 82)
var slight_blue = RGB(44, 104, 123)
var cyan		= RGB(58, 240, 206)
var white		= c_white
var pink		= RGB(214, 94, 220)
var yellow		= RGB(250, 221, 35)

color_schemes[$ cs_drowned] = create_color_scheme7(
	cyan,
	dark_blue,
	slight_blue,
	cyan,
	white,
	pink,
	yellow
)
color_schemes[$ cs_drowned].__builtin__ = true



var dark_pink	= RGB(84, 35, 59)
var slight_pink = RGB(133, 62, 88)
var orange		= RGB(242, 151, 37)
var green		= RGB(60, 233, 137)
var yellow		= RGB(246, 248, 44)

color_schemes[$ cs_helios] = create_color_scheme7(
	orange,
	dark_pink,
	slight_pink,
	orange,
	white,
	green,
	yellow
)
color_schemes[$ cs_helios].__builtin__ = true



var dark_pink	= RGB(44, 34, 54)
var slight_blue = 9261387
var slight_pink = 15429439
var pink		= RGB(255, 159, 255)
var blue		= RGB(127, 225, 255)
var white		= c_white

color_schemes[$ cs_humanrights] = create_color_scheme_full(
	dark_pink,
	slight_pink,
	bm_subtract,
	.7,
	blue,
	blue,
	pink,
	blue,
	white,
	blue,
	pink,
	blue,
	blue,
	blue,
	slight_pink,
	white
)
color_schemes[$ cs_humanrights].__builtin__ = true


o_console.rainbow = false
color_scheme(cs_index)
return stitch("Regenerated color schemes")
}