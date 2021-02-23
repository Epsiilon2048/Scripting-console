
function draw_set_align(halign, valign){

draw_set_halign(halign)
draw_set_valign(valign)
}

function draw_set_properties(color, alpha, blendmode){

draw_set_color(color)
if not is_undefined(alpha)	   draw_set_alpha(alpha)
if not is_undefined(blendmode) gpu_set_blendmode(blendmode)
}

function draw_reset_properties(){
//color, alpha, circle precision, blendmode, shader

draw_set_color(c_white)
draw_set_alpha(1)
draw_set_circle_precision(24)

gpu_set_blendmode(bm_normal)
shader_reset()
}