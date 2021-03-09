
function draw_roundline(x1, y1, x2, y2, w){ //draws a line with circles on its ends

draw_circle(x1, y1, w/2, false)
draw_line_width(x1, y1, x2, y2, w)
draw_circle(x2, y2, w/2, false)
}




function draw_set_align(halign, valign){

draw_set_halign(halign)
draw_set_valign(valign)
}




function draw_set_properties(color, alpha, blendmode){

draw_set_color(color)
if not is_undefined(alpha)	   draw_set_alpha(alpha)
if not is_undefined(blendmode) gpu_set_blendmode(blendmode)
}




function draw_reset_properties(){ // resets color, alpha, circle precision, blendmode, and shader

draw_set_color(c_white)
draw_set_alpha(1)
draw_set_circle_precision(24)

gpu_set_blendmode(bm_normal)
shader_reset()
}