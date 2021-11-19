
//f++
//draw_circle(gui_mx, gui_my, sin(f/10)*10, false)

f += (keyboard_check(vk_right)-keyboard_check(vk_left))*.06

draw_set_font(fnt_debug6x)
gpu_set_tex_filter(true)
draw_text_transformed(gui_mx, gui_my+30, "How is this? I think its quite nice...", f, f, 0)
gpu_set_tex_filter(false)