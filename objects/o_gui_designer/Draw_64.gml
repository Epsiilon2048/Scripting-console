
//draw_set_color(c_white)

//for(var i = 0; i <= array_length(sprts)-1; i++)
//{
//	gpu_set_blendmode(sprts[i].bm)
//	draw_sprite(sprts[i].sprite, sprts[i].subimg, sprts[i].x, sprts[i].y)
//	if sprts[i].anim_spd > 0
//	{
//		sprts[i].timer ++
//		sprts[i].subimg += (sprts[i].timer mod sprts[i].anim_spd) == 0
//	}
//}
//for(var i = 0; i <= array_length(lines)-1; i++)
//{
//	gpu_set_blendmode(lines[i].bm)
//	draw_set_color(lines[i].c)
//	draw_round_line(lines[i].x1, lines[i].y1, lines[i].x2, lines[i].y2, lines[i].w, lines[i].c)
//}
//for(var i = 0; i <= array_length(rects)-1; i++)
//{
//	gpu_set_blendmode(rects[i].bm)
//	draw_set_color(rects[i].c)
//	draw_rectangle(rects[i].x1, rects[i].y1, rects[i].x2, rects[i].y2, rects[i].outline)
//	draw_rectangle_outline(rects[i].x1, rects[i].y1, rects[i].x2, rects[i].y2, rects[i].w)
//}
//for(var i = 0; i <= array_length(circs)-1; i++)
//{
//	gpu_set_blendmode(circs[i].bm)
//	draw_set_color(circs[i].c)
//	draw_circle(circs[i].x, circs[i].y, circs[i].r, circs[i].outline)
//}
//gpu_set_blendmode(bm_normal)

//for(var i = 0; i <= array_length(texts)-1; i++)
//{
//	draw_set_halign(texts[i].halign)
//	draw_set_valign(texts[i].valign)
//	draw_set_color(texts[i].c)
//	draw_text(texts[i].x, texts[i].y, texts[i].text)
//}
//draw_set_color(c_white)