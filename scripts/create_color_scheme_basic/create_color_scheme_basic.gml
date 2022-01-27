
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
colors.selection		= body // Not being used

colors.outline_layers	= 0 // (mostly) not being used

colors.sprite			= -1
colors.sprite_anchor	= false
colors.sprite_alpha		= 1

colors.bevel			= true

colors.body_real_alpha	= .1

colors.black			= c_black
colors.white			= c_white
colors.red				= c_red
colors.green			= c_green
colors.blue				= c_blue

colors.real			= real
colors.string		= string
colors.asset		= asset
colors.variable		= variable
colors.method		= method
colors.instance		= asset
colors.builtinvar	= output
colors.color		= real
colors.tag			= tag
colors.unknown		= plaintext
colors.deprecated	= deprecated

return colors	
}