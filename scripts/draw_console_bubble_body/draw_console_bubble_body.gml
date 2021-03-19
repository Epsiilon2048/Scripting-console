
function draw_console_bubble_body(x1, y1, x2, y2){

static radius = 30
static border = 16
static outline_dist = border-2
static outline_radius1 = radius*(outline_dist/border)
static outline_radius2 = radius*((outline_dist-1)/border)

draw_set_color(o_console.colors.body_real)
draw_roundrect_ext(x1-border, y1-border, x2+border, y2+border, radius, radius, false)

draw_set_color(o_console.colors.output)
draw_roundrect_ext(x1-outline_dist, y1-outline_dist, x2+outline_dist, y2+outline_dist, outline_radius1, outline_radius1, false)

draw_set_color(o_console.colors.body_real)
draw_roundrect_ext(x1-outline_dist+1, y1-outline_dist+1, x2+outline_dist-1, y2+outline_dist-1, outline_radius2, outline_radius2, false)

draw_set_color(c_white)

return gui_mouse_between(x1-border, y1-border, x2+border, y2+border)
}