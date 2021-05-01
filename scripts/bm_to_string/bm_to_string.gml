function bm_to_string(blendmode){

//uhhhhh for some reason some blendmodes share values sooo i cant do a switch statement...

if blendmode == bm_normal			return "bm_normal"
if blendmode == bm_add				return "bm_add"
if blendmode == bm_subtract			return "bm_subtract"
if blendmode == bm_max				return "bm_max"
if blendmode == bm_one				return "bm_one"
if blendmode == bm_zero				return "bm_zero"
if blendmode == bm_dest_alpha		return "bm_dest_alpha"
if blendmode == bm_dest_color		return "bm_dest_color"
if blendmode == bm_inv_dest_alpha	return "bm_inv_dest_alpha"
if blendmode == bm_inv_dest_color	return "bm_inv_dest_color"
if blendmode == bm_src_alpha		return "bm_src_alpha"
if blendmode == bm_src_alpha_sat	return "bm_src_alpha_sat"
if blendmode == bm_src_color		return "bm_src_color"
if blendmode == bm_inv_src_alpha	return "bm_inv_src_alpha"
if blendmode == bm_inv_src_color	return "bm_inv_src_color"

return "<unknown>"
}