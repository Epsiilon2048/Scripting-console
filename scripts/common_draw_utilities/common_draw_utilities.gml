
function draw_reset_properties(){ // resets color, alpha, circle precision, blendmode, and shader

draw_set_color(c_white)
draw_set_alpha(1)
draw_set_circle_precision(24)

gpu_set_blendmode(bm_normal)
shader_reset()
}