
//clip_rect_cutout(x, y, x+w, y+h)
//draw_sprite(s_scrollbar_tester, 0, x, y-scr.scroll)
//shader_reset()
//draw_scrollbar(scr)

draw_self()
draw_set_halign(fa_center)
draw_set_valign(fa_center)
draw_set_color(c_black)
draw_text_transformed(x, y, text, image_xscale, image_yscale, image_angle)

cd2.draw()
cd.draw()