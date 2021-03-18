
function create_color_scheme_basic(main, body, plaintext, specialtext){

var body_accent = make_color_hsv(
	color_get_hue(body)+10,
	color_get_saturation(body),
	color_get_value(body)-20
)

return
{
	body:		-body,
	body_real:	 body,
	body_bm:	 bm_subtract,
	body_alpha:  1,
	body_accent: body_accent,
	output:		 main,
	ex_output:	 main,
	embed:		 plaintext,
	embed_hover: specialtext,
	plain:		 plaintext,
	selection:	-body,
	string:		 specialtext,
	real:		 specialtext,
	variable:	 specialtext,
	instance:	 specialtext,
	method:		 specialtext,
	asset:		 specialtext,
}
}