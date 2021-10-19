
function new_cd_button(name, func){
var b = new Cd_button()
b.initialize(name, func)
return b
}



function Cd_button() constructor{

set_name = function(name){
	
	var old_font = draw_get_font()
	draw_set_font(o_console.font)
	
	var cw = string_width(" ")
	var ch = string_height(" ")
	
	self.name = string(name)
	name_width = string_width(self.name)/cw
	name_height = string_height(self.name)/ch
	
	draw_set_font(old_font)
}


set_sprite = function(sprite){

	self.sprite = sprite
	name_width = sprite_get_width(self.sprite)
	name_height = sprite_get_height(self.sprite)
	
	subimg_speed = sprite_get_speed(sprite)
}


initialize = function(name, func){
	
	enabled = true
	
	can_click = true
	
	set_name(name)
	
	sprite = undefined
	sprite_color = undefined
	subimg = 0
	subimg_speed = 0
	subimg_timer = 0
	
	image_scale = 1
	scale_from_global = true
	
	width = undefined
	height = undefined
	
	pressed_script = noscript
	held_script = noscript
	released_script = func
	
	x = 0
	y = 0
	
	left = 0
	top = 0
	right = 0
	bottom = 0
	
	text_x = 0
	text_y = 0
	
	mouse_on = false
	clicking = false
	
	draw_box = true
}


get_input = function(){
	
	if not enabled
	{
		left = x
		top = y
		right = x
		bottom = y
		
		return undefined
	}
	
	var bt = o_console.CD_BUTTON
	var tb = o_console.TEXT_BOX
	
	var old_font = draw_get_font()
	draw_set_font(o_console.font)
	
	var cw = string_width(" ")
	var ch = string_height(" ")
	
	var asp = ch/bt.char_height
	var tb_asp = ch/tb.char_height
	
	var _wdist = round(bt.wdist*asp)
	var _hdist = round(bt.hdist*asp)
	var _outline_width = tb.outline_width*tb_asp
	
	var _image_scale = image_scale
	if scale_from_global _image_scale *= asp
	
	if is_undefined(sprite)
	{
		var _name_width = name_width*cw
		var _name_height = name_height*ch
	}
	else
	{
		var _name_width = name_width*_image_scale
		var _name_height = name_height*_image_scale
		
		if sprite_get_speed_type(sprite) == gamespeed_microseconds
		{
			var time = get_timer()
			if time-subimg_timer >= subimg_speed
			{
				subimg ++
				subimg_timer = time
			}
		}
		else
		{
			if subimg_timer >= room_speed
			{
				subimg ++
				subimg_timer = 0
			}
			else subimg_timer += subimg_speed
		}
	}
	
	left = x
	top = y
	
	right = left+_name_width
	bottom = top+_name_height
	
	if not is_undefined(width) right = max(right, left+width)
	else if draw_box right += _wdist*2
	if not is_undefined(height) bottom = max(bottom, top+height)
	else if draw_box bottom += _hdist*2
	
	if is_undefined(sprite)
	{
		text_x = left+(right-left)/2
		text_y = top+(bottom-top)/2+_outline_width
	}
	else
	{
		text_x = left + _wdist*draw_box + (name_width + (sprite_get_xoffset(sprite)-name_width))*_image_scale + _outline_width
		text_y = top + _hdist*draw_box + (name_height + (sprite_get_yoffset(sprite)-name_height))*_image_scale + _outline_width
	}
	
	mouse_on = can_click and not mouse_on_console and not clicking_on_console and gui_mouse_between(left, top, right, bottom)
	
	if clicking and (not can_click or not mouse_check_button(mb_left) or (released_script == noscript and held_script == noscript))
	{
		clicking = false
		if mouse_on and can_click released_script()
	}
	else if clicking 
	{
		clicking_on_console = true
		held_script()
	}

	if mouse_on 
	{
		if mouse_check_button_pressed(mb_left)
		{
			clicking = true
			pressed_script()
			held_script()
		}
		
		mouse_on_console = true
	}

	draw_set_font(old_font)
}


draw = function(){
	
	if right == x and bottom == y return undefined
	
	var bt = o_console.CD_BUTTON
	var tb = o_console.TEXT_BOX
	
	var old_font = draw_get_font()
	var old_halign = draw_get_halign()
	var old_valign = draw_get_valign()
	
	draw_set_font(o_console.font)
	draw_set_halign(fa_center)
	draw_set_valign(fa_middle)
	
	var ch = string_height(" ")
	
	var asp = ch/bt.char_height
	var tb_asp = ch/tb.char_height
	
	var _outline_width = tb.outline_width*tb_asp
	
	var _image_scale = image_scale
	if scale_from_global _image_scale *= asp
	
	var is_front = not (docked and not dock.is_front)
	
	if draw_box
	{
		draw_set_color(clicking ? o_console.colors.embed_hover : o_console.colors.body_real)
		draw_rectangle(left, top, right, bottom, false)
	}
	
	if not can_click					draw_set_color(o_console.colors.body_accent)
	else if clicking and draw_box		draw_set_color(o_console.colors.body_real)
	else if clicking and not draw_box	draw_set_color(o_console.colors.plain)
	else if mouse_on					draw_set_color(o_console.colors.embed_hover)
	else if is_front or not draw_box	draw_set_color(o_console.colors.embed)
	else								draw_set_color(o_console.colors.body_accent)
	
	if not clicking and draw_box draw_hollowrect(left, top, right, bottom, _outline_width)
	
	if not is_front and not clicking and draw_box and can_click draw_set_color(o_console.colors.embed)
	
	
	if not is_undefined(sprite)
	{
		var _sprite_color
		if is_undefined(sprite_color)
		{
			_sprite_color = draw_get_color()
		}
		else _sprite_color = is_numeric(sprite_color) ? _sprite_color : o_console.colors[$ sprite_color]
		
		draw_sprite_ext(sprite, subimg, text_x, text_y, _image_scale, _image_scale, 0, _sprite_color, 1)
	}
	else draw_text(text_x, text_y, name)
	
	draw_set_font(old_font)
	draw_set_halign(old_halign)
	draw_set_valign(old_valign)
}
}
