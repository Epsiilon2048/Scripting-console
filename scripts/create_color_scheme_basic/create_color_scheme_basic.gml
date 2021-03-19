
function create_color_scheme_full(
	body,
	body_real,
	body_bm,
	body_alpha,
	body_accent,
	output,
	ex_output,
	embed,
	embed_hover,
	plain,
	real,
	string,
	variable,
	method,
	instance,
	tag,
	deprecated,
){
	
var colors = {}

colors.body			= -body
colors.body_real	=  body
colors.body_bm		=  bm_subtract
colors.body_alpha	=  1
colors.body_accent	=  body_accent
colors.output		=  main
colors.ex_output	=  main
colors.embed		=  plaintext
colors.embed_hover	=  specialtext
colors.plain		=  plaintext
colors.selection	= -body

colors[$ dt_real]		= specialtext
colors[$ dt_string]		= specialtext
colors[$ dt_asset]		= specialtext
colors[$ dt_variable]	= specialtext
colors[$ dt_method]		= specialtext
colors[$ dt_instance]	= specialtext
colors[$ dt_room]		= specialtext
colors[$ dt_tag]		= specialtext
colors[$ dt_unknown]	= plaintext

return colors	
}

function create_color_scheme_basic(main, body, plaintext, specialtext){

var body_accent = make_color_hsv(
	color_get_hue(body)+10,
	color_get_saturation(body),
	color_get_value(body)-20
)

var colors = {}

colors.body			= -body
colors.body_real	=  body
colors.body_bm		=  bm_subtract
colors.body_alpha	=  1
colors.body_accent	=  body_accent
colors.output		=  main
colors.ex_output	=  main
colors.embed		=  plaintext
colors.embed_hover	=  specialtext
colors.plain		=  plaintext
colors.selection	= -body

colors[$ dt_real]		= specialtext
colors[$ dt_string]		= specialtext
colors[$ dt_asset]		= specialtext
colors[$ dt_variable]	= specialtext
colors[$ dt_method]		= specialtext
colors[$ dt_instance]	= specialtext
colors[$ dt_room]		= specialtext
colors[$ dt_tag]		= specialtext
colors[$ dt_unknown]	= plaintext

return colors
}