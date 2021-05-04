
function initialize_color_schemes(){

var dark_blue    = make_color_rgb(34, 50, 66)
var green	     = make_color_rgb(40, 235, 134)
var slight_blue  = make_color_rgb(67, 88, 112)
var white	     = 15920110
var yellow	     = make_color_rgb(252, 252, 0)
var red		     = make_color_rgb(247, 116, 129)
var cyan	     = make_color_rgb(64, 220, 255)
var orange	     = make_color_rgb(255, 184, 113)
var pink		 = 14044390
var purple		 = 16734082
var grey		 = 12559270

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
	purple,			//tag
	grey,			//deprecated
)
color_schemes[$ cs_greenbeans][$ dt_instance] = pink
color_schemes[$ cs_greenbeans].__builtin__ = true



var dark_pink   = make_color_rgb(55,  34, 66)
var slight_pink = make_color_rgb(115, 61, 113)
var pink	    = make_color_rgb(240, 58, 125)
var white	    = c_white
var purple	    = make_color_rgb(140, 62, 250)
var yellow	    = make_color_rgb(250, 221, 35)

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



var dark_blue	= make_color_rgb(43, 52, 82)
var slight_blue = make_color_rgb(44, 104, 123)
var cyan		= make_color_rgb(58, 240, 206)
var white		= c_white
var pink		= make_color_rgb(214, 94, 220)
var yellow		= make_color_rgb(250, 221, 35)

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



var dark_pink	= make_color_rgb(84, 35, 59)
var slight_pink = make_color_rgb(133, 62, 88)
var orange		= make_color_rgb(242, 151, 37)
var green		= make_color_rgb(60, 233, 137)
var yellow		= make_color_rgb(246, 248, 44)

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



var dark_pink	= make_color_rgb(44, 34, 54)
var slight_blue = 9261387
var slight_pink = 15429439
var pink		= make_color_rgb(255, 159, 255)
var blue		= make_color_rgb(127, 225, 255)
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