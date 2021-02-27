
#macro SLIDER global.SLIDER_PROPERTIES

SLIDER = {}; with SLIDER {
	
	height = 32
	text_offset = 10
	
	mouse_is_pivot		  = false
	update_every_frame	  = true
	lock_value_to_step	  = true
	correct_not_real	  = true
	text_fill_places	  = true
	
	ease = ease_normal
}



function draw_slider(slider){ with slider {

var mx = device_mouse_x_to_gui(0)
var my = device_mouse_y_to_gui(0)

var x2 = x + width
var y2 = y + SLIDER.height

var curvalue = variable_string_get(variable)

if SLIDER.correct_not_real or is_real(curvalue)
{
	if gui_mouse_between(x, y, x2, y2) and mouse_check_button_pressed(mb_left)
	{
		mouse_on = true
	}

	if mouse_on
	{
		value = clamp( (mx - x)/width , 0, 1)
	
		if not mouse_check_button(mb_left) 
		{
			mouse_on = false
		}
	
		if SLIDER.update_every_frame or not mouse_on
		{
			var newvalue
			if value == 1 newvalue = value_max
			else
			{
				newvalue = SLIDER.ease(value)*(value_max-value_min)
				newvalue = newvalue - newvalue mod value_step + value_min
			}
		
			variable_string_set(variable, newvalue)
		
			if SLIDER.lock_value_to_step and value != 1
			{
				value = SLIDER.ease((newvalue - value_min)/(value_max-value_min))
			}
			
			curvalue = newvalue
		}
	}
	else if is_real(curvalue)
	{
		value = clamp( SLIDER.ease((curvalue - value_min)/(value_max-value_min)) , 0, 1)
	}
	else
	{
		value = 0
	}
}

var text = "/"

if is_real(curvalue) 
{
	if SLIDER.text_fill_places text = float_fill_places(curvalue, value_places)
	else					   text = string_format_float(curvalue)
}

draw_set_color(o_console.colors.body_real)
draw_rectangle(x, y, x2, y2, false)

draw_set_color(o_console.colors.output)
draw_set_font(o_console.font)
draw_set_align(fa_left, fa_center)

clip_rect_cutout(x, y, x2+1, y2)
draw_text(x+SLIDER.text_offset, y+SLIDER.height/2+1, text)
shader_reset()

if value > 0
{
	var value_x = x + ceil( (x2-x)*value )
	
	draw_rectangle(x, y, value_x, y2, false)
	
	clip_rect_cutout(x, y, value_x+1, y2);

	draw_set_color(o_console.colors.body_real)
	draw_text(x+SLIDER.text_offset, y+SLIDER.height/2+1, text)

	shader_reset()
}

draw_set_color(c_white)
}}