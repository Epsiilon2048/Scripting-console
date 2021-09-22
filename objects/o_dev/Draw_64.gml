

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
	if animating == 1 and anim > .99
	{
		anim = 1
		animating = false
	}
	else if animating == -1 and anim < .01
	{
		anim = 0
		animating = false
	}
}

var height = o_console.BAR.text_box.cbox_bottom-o_console.BAR.text_box.cbox_top
var width = height*anim

var ldx1 = lengthdir_x(height/2, 360*anim)
var ldy1 = lengthdir_y(height/2, 360*anim)
var ldx2 = -ldy1*anim
var ldy2 = ldx1*anim

var x1 = x+width/2
var y1 = y-height/2
var x2 = x-width/2
var y2 = y+height/2

draw_set_color(o_console.colors.output)

//draw_rectangle(x1, y1, x2, y2, false)
draw_ellipse(x1, y1, x2, y2, false)
