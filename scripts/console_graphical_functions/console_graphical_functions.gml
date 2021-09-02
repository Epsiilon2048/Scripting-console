
function clip_rect_cutout(x1, y1, x2, y2){

static u_bounds = shader_get_uniform(shd_clip_rect, "u_bounds")

shader_set(shd_clip_rect)
shader_set_uniform_f(u_bounds, x1, y1, x2, y2)
}