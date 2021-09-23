

//clip_rect_cutout(sw.page_left, sw.page_top, sw.page_right, sw.page_bottom)
//draw_sprite(Sprite9, 0, x-sw.scroll_x, y-sw.scroll_y)
//shader_reset()
//sw.draw()

if keyboard_check_pressed(vk_space)
{
	animating = anim ? -1 : 1
}

if animating != 0
{
	anim = (animating == 1) ? lerp(anim, 1, inc) : lerp(anim, 0, inc)
	if animating == 1 and anim > .999
	{
		anim = 1
		animating = false
	}
	else if animating == -1 and anim < .001
	{
		anim = 0
		animating = false
	}
}

var height = o_console.BAR.text_box.cbox_bottom-o_console.BAR.text_box.cbox_top
var width = height*anim

if not surface_exists(surf) 
{
	surf = surface_create(height+2, height+2)
}
else if surface_get_width(surf) != height+2
{
	surface_resize(surf, height+2, height+2)
}

surface_set_target(surf)
draw_clear_alpha(c_black, 0)
var x1 = height/2+1 - width/2
var y1 = 1
var x2 = height/2+1 + width/2
var y2 = height+2

draw_set_color(o_console.colors.output)

draw_ellipse(x1, y1, x2, y2, false)

surface_reset_target()
gpu_set_texfilter(true)

var dir = 360*anim
draw_surface_ext(surf, x-lengthdir_x(height+2, dir)/2, y-lengthdir_y(height+2, dir)/2, 1, 1, dir, c_white, 1)
//draw_surface(surf, x-height/2, y-height/2)
gpu_set_texfilter(false)