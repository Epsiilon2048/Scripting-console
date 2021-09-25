

//clip_rect_cutout(sw.page_left, sw.page_top, sw.page_right, sw.page_bottom)
//draw_sprite(Sprite9, 0, x-sw.scroll_x, y-sw.scroll_y)
//shader_reset()
//sw.draw()

var length = o_console.BAR.text_box.cbox_bottom-o_console.BAR.text_box.cbox_top
length *= sc

if keyboard_check_pressed(vk_space)
{
	animating = (anim > 0) ? -1 : 1
}

var wsep = 1+ceil(length*overshoot)/2

if not surface_exists(surf) 
{
	surf = surface_create(length+wsep*2, length+2)
}
else if surface_get_width(surf) != length+2
{
	surface_resize(surf, length+wsep*2, length+2)
}

surface_set_target(surf)
draw_clear_alpha(c_black, 0)
draw_set_color(o_console.colors.output)

var cx = length/2+wsep
var cy = length/2+1
if animating == 1
{
	var width = max(3, length*anim)
	var height = length-max(0, width-length)*height_dampner
	
	draw_ellipse(cx-width/2, cy-height/2, cx+width/2, cy+height/2, false)
	if overshot 
	{
		anim = lerp(anim, 1, inc*overshoot_dampner)
		
		if anim-1 < .001
		{
			animating = 0
			overshot = false
			anim = 1
		}
	}
	else
	{
		anim = lerp(anim, 1+overshoot, inc)
		
		if ((1+overshoot)-anim) < .001
		{
			overshot = true
			anim = 1+overshoot
		}
	}
	
}
else if animating == -1 
{
	var width = max(2, length*anim)
	draw_roundrect_ext(cx-width/2, 1, cx+width/2, length+1, width, width, false)
	anim = lerp(anim, 0, inc)
	
	if width == 2
	{
		animating = false
		anim = 0
	}
}
else if anim > 0
{
	draw_circle(cx, cy, length/2, false)
}

if animating != 1 and anim != 1
{
	draw_rectangle(cx-1, 1, cx+1, length+1, false)
}

surface_reset_target()
gpu_set_texfilter(true)
draw_surface(surf, x, y)
gpu_set_texfilter(false)