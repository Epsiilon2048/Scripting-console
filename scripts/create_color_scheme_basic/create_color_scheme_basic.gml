
function create_color_scheme4(main, body, plaintext, specialtext){

var body_accent = make_color_hsv(
	color_get_hue(body)+10,
	color_get_saturation(body),
	color_get_value(body)-20
)

return create_color_scheme_full(
	body,
	body_accent,
	bm_subtract,
	.7,
	main,
	main,
	plaintext,
	specialtext,
	plaintext,
	specialtext,
	specialtext,
	specialtext,
	specialtext,
	specialtext,
	specialtext,
	plaintext
)
}




function create_color_scheme7(main, body, body_accent, plaintext, exposedtext, specialtext, method){

return create_color_scheme_full(
	body,
	body_accent,
	bm_subtract,
	.7,
	main,
	exposedtext,
	method,
	specialtext,
	plaintext,
	specialtext,
	method,
	specialtext,
	method,
	specialtext,
	method,
	plaintext
)
}




function create_color_scheme10(
	main, 
	body, 
	body_accent, 
	plaintext, 
	exposedtext, 
	specialtext, 
	variable, 
	method, 
	asset, 
	string
){

return create_color_scheme_full(
	body,
	body_accent,
	bm_subtract,
	.7,
	main,
	exposedtext,
	string,
	specialtext,
	plaintext,
	specialtext,
	string,
	variable,
	method,
	asset,
	method,
	plaintext
)
}




function create_color_scheme_full(
	body,
	body_accent,
	body_bm,
	body_alpha,
	output,
	ex_output,
	embed,
	embed_hover,
	plaintext,
	real,
	string,
	variable,
	method,
	asset,
	tag,
	deprecated
){
	
var colors = {}

colors.body				= (body_bm == bm_subtract) ? -body : body
colors.body_real		= body
colors.body_bm			= body_bm
colors.body_alpha		= body_alpha
colors.body_accent		= body_accent
colors.output			= output
colors.ex_output		= ex_output
colors.embed			= embed
colors.embed_hover		= embed_hover
colors.plain			= plaintext
colors.selection		= body

colors[$ dt_real]		= real
colors[$ dt_string]		= string
colors[$ dt_asset]		= asset
colors[$ dt_variable]	= variable
colors[$ dt_method]		= method
colors[$ dt_instance]	= asset
colors[$ dt_room]		= asset
colors[$ dt_tag]		= tag
colors[$ dt_unknown]	= plaintext
colors[$ dt_deprecated] = deprecated

return colors	
}