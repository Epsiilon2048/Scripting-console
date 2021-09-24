

//clip_rect_cutout(sw.page_left, sw.page_top, sw.page_right, sw.page_bottom)
//draw_sprite(Sprite9, 0, x-sw.scroll_x, y-sw.scroll_y)
//shader_reset()
//sw.draw()

var height = o_console.BAR.text_box.cbox_bottom-o_console.BAR.text_box.cbox_top
height *= sc

if keyboard_check_pressed(vk_space)
{
	animating = (anim > 0) ? -1 : 1
}

var wsep = 1+ceil(height*overshoot)/2

if not surface_exists(surf) 
{
	surf = surface_create(height+wsep*2, height+2)
}
else if surface_get_width(surf) != height+2
{
	surface_resize(surf, height+wsep*2, height+2)
}

surface_set_target(surf)
draw_clear_alpha(c_black, 0)
draw_set_color(o_console.colors.output)

var c = height/2+wsep
if animating == 1
{
	var width = height*anim*(1+overshoot)
	
	draw_ellipse(c-width/2, 1, c+width/2, height+1, false)
	anim = lerp(anim, 1, inc)
	
}
else if animating == -1 
{
	anim = 0
	animating = false
}
else if anim > 0
{
	draw_circle(c, c, height/2, false)
}
else
{
	draw_rectangle(c-1, wsep, c+1, height+wsep, false)
}

surface_reset_target()
gpu_set_texfilter(true)
draw_surface(surf, x, y)
gpu_set_texfilter(false)