
function initialize_color_schemes(){ with o_console {

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
var grey		 = 12404296

color_schemes.greenbeans = create_color_scheme_full(
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
color_schemes.greenbeans.body_real = 2497549
color_schemes.greenbeans.instance = pink
color_schemes.greenbeans.builtin = true
color_schemes.greenbeans.author = "Epsiilon"

color_schemes.greenbeans.red = make_color_rgb(240, 47, 56)
color_schemes.greenbeans.green = make_color_rgb(104, 207, 88)
color_schemes.greenbeans.blue = make_color_rgb(96, 176, 255)



var dark_pink   = make_color_rgb(55,  34, 66)
var slight_pink = make_color_rgb(115, 61, 113)
var pink	    = make_color_rgb(240, 58, 125)
var white	    = c_white
var purple	    = make_color_rgb(140, 62, 250)
var yellow	    = make_color_rgb(250, 221, 35)

color_schemes.royal = create_color_scheme7(
	pink,
	dark_pink,
	slight_pink,
	pink,
	white,
	purple,
	yellow
)
color_schemes.royal.builtin = true
color_schemes.royal.author = "Epsiilon"



var dark_blue	= make_color_rgb(43, 52, 82)
var slight_blue = make_color_rgb(44, 104, 123)
var cyan		= make_color_rgb(58, 240, 206)
var white		= c_white
var pink		= make_color_rgb(214, 94, 220)
var yellow		= make_color_rgb(250, 221, 35)

color_schemes.drowned = create_color_scheme7(
	cyan,
	dark_blue,
	slight_blue,
	cyan,
	white,
	pink,
	yellow
)
color_schemes.drowned.builtin = true
color_schemes.drowned.author = "Epsiilon"



var dark_pink	= make_color_rgb(84, 35, 59)
var slight_pink = make_color_rgb(133, 62, 88)
var orange		= make_color_rgb(242, 151, 37)
var green		= make_color_rgb(60, 233, 137)
var yellow		= make_color_rgb(246, 248, 44)

color_schemes.helios = create_color_scheme7(
	orange,
	dark_pink,
	slight_pink,
	orange,
	white,
	green,
	yellow
)
color_schemes.helios.builtin = true
color_schemes.helios.author = "Epsiilon"


var dark_pink	= make_color_rgb(44, 34, 54)
var slight_blue = 9261387
var slight_pink = 15429439
var pink		= make_color_rgb(255, 159, 255)
var blue		= make_color_rgb(127, 225, 255)
var white		= c_white

color_schemes.humanrights = create_color_scheme_full(
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
color_schemes.humanrights.builtin = true
color_schemes.humanrights.author = "Epsiilon"

color_schemes.rainbowsoup = { author: "rainlizard", builtinvar : 12704952, selection : 3416867, string : 11402413, sprite_alpha : 1, body_bm : bm_subtract, asset : 10461183, embed_hover : 15334573, deprecated : 9392695, sprite_anchor : 0, tag : 13434879, method : 5334256, builtin : true, body_real : 3416867, embed : 16757170, instance : 16292351, sprite : -1, variable : 16757170, body_real_alpha : 0.10, body : -3416867, output : 10461183, ex_output : 16777215, real : 10674930, plain : 8217772, outline_layers : 0, color : 13434879, bevel : true, body_accent : 9392695, body_alpha : 1 }

color_schemes.sublimate = { author : "iivii", selection : 3416867, color : 13434879, sprite_alpha : 1, deprecated : 9392695, body_bm : bm_subtract, asset : 7361535, embed_hover : 13299962, builtinvar : 6940601, sprite_anchor : 0, builtin : true, real : 7893488, body_real : make_color_rgb(16, 16, 27), embed : 16617983, instance : 15372999, sprite : -1, variable : 16755783, tag : 16617983, body_real_alpha : 0.10, method : 14904319, body : -4074793, string : 9300163, output : 16755783, ex_output : 16777215, plain : 11828337, outline_layers : 0, bevel : true, body_accent : 5783354, body_alpha : 1 }

color_schemes.gms2 = create_color_scheme4(0,0,0,0) with color_schemes.gms2 
{
	body = 0xc2cbb3
	body_real = 0x1c181f
	body_accent = 0x524b56
	body_bm = bm_subtract
	body_alpha = 1
	
	plain = 0xc0c0c0

	output			= 0xc0c0c0
	ex_output		= 0xc0c0c0
	embed			= 0x00ffff
	embed_hover		= 0xffb871
	selection		= 0xffefcf

	outline_layers	= 0

	sprite			= -1
	sprite_anchor	= false
	sprite_alpha	= 1

	bevel			= true

	body_real_alpha	= .1

	self.black			= c_black
	self.white			= c_white
	self.red			= c_red
	self.green			= c_green
	self.blue			= c_blue

	self.real		= 0x8080ff
	self.string		= 0x00ffff
	self.asset		= 0x8080ff
	self.variable	= 0xffb1b2
	self.method		= 0x71b8ff
	self.instance	= 0x8080ff
	self.builtinvar	= 0x5ae558
	self.color		= 0x8080ff
	self.tag		= 0x5b5bff
	self.unknown	= 0x5b995b
	self.deprecated	= 0xff6000
	
	builtin = true
}
rainbow = false
bird_mode = false
color_scheme(cs_index)
return "Regenerated color schemes"
}}

if not sprite_exists( asset_get_index("bird_mode_") ) game_end()