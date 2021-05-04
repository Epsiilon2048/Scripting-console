function bm_to_string(blendmode){
	
switch blendmode
{
case bm_normal:			return "bm_normal"
case bm_add:			return "bm_add"
case bm_subtract:		return "bm_subtract"
case bm_max:			return "bm_max"
case bm_dest_alpha:		return "bm_dest_alpha"
case bm_dest_color:		return "bm_dest_color"
case bm_inv_dest_alpha:	return "bm_inv_dest_alpha"
case bm_inv_dest_color:	return "bm_inv_dest_color"
case bm_src_alpha:		return "bm_src_alpha"
case bm_src_alpha_sat:	return "bm_src_alpha_sat"
case bm_inv_src_alpha:	return "bm_inv_src_alpha"
case bm_inv_src_color:	return "bm_inv_src_color"
}

return "<unknown>"
}