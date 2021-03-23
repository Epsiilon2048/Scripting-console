
function Console_slider() constructor{
	
	initialize = function(variable, x, y, var_min, var_max, var_step){
		
		self.variable = variable
		
		self.meter = false
		self.value_show = true
		self.condensed = false
		self.mouse_is_pivot = false
		
		self.value = 0
		self.var_min = var_min
		self.var_max = var_max
		self.var_step = var_step
		//self.var_places = float_places(var_step)
		
		self.markers = 10 //incriment for each value step
		self.submarkers = 3 //amount of submarkers in between markers
		
		self.dividers = false
		
		self.x = x
		self.y = y
		
		self.mx_init = 0
		self.my_init = 0
		self.value_init = 0
		
		self.before_text = ""
		self.after_text  = ""
	
		self.width = 200
		
		self.ease = ease_normal
		
		self.mouse_on = false
	}
	
	set_var_step = function(step){
		
		self.var_step = step
		//self.var_places = float_places(step)
	}
}



function draw_slider(slider){ with slider {

var mx = device_mouse_x_to_gui(0)
var my = device_mouse_y_to_gui(0)

var x2 = x + width
var y2 = y + (condensed ? o_console.SLIDER.height_condensed : o_console.SLIDER.height)

var curvalue = variable_string_get(variable)

if not meter and (o_console.SLIDER.correct_not_real or is_numeric(curvalue))
{
	if gui_mouse_between(x, y, x2, y2) and mouse_check_button_pressed(mb_left)
	{
		mouse_on = true
		value_init = value
		mx_init = mx
		my_init = my
	}

	if mouse_on
	{
		if mouse_is_pivot
			{ value = clamp( value_init + ease((mx - mx_init)/width), 0, 1) }
		else
			{ value = ease(clamp( (mx - x)/width , 0, 1)) }

		if not mouse_check_button(mb_left) 
		{
			mouse_on = false
		}
	
		if o_console.SLIDER.update_every_frame or not mouse_on
		{
			var newvalue
			if value == 1 newvalue = var_max
			else
			{
				newvalue = value*(var_max-var_min)
				if var_step != 0 newvalue = clamp(newvalue - newvalue mod var_step + var_min + round(value)*var_step, var_min, var_max)
				else newvalue += var_min
			}
		
			variable_string_set(variable, newvalue)
		
			if o_console.SLIDER.lock_value_to_step and var_step != 0 and value != 1
			{
				value = clamp((newvalue - var_min)/(var_max-var_min), 0, 1)
			}
			
			curvalue = newvalue
		}
	}
	else if is_numeric(curvalue)
	{
		value = clamp( (curvalue - var_min)/(var_max-var_min) , 0, 1)
	}
	else
	{
		value = 0
	}
}

var text = NaN

if is_numeric(curvalue) 
{
	//if o_console.SLIDER.text_fill_places text = float_fill_places(curvalue, var_places)
	//else
	text = string_format_float(curvalue)
	
	text = before_text + text + after_text
}

draw_set_color(o_console.colors.body_real)
draw_rectangle(x, y, x2, y2, false)

if value_show and not condensed
{
	draw_set_color(o_console.colors.output)
	draw_set_font(o_console.font)
	draw_set_align(fa_left, fa_center)

	clip_rect_cutout(x, y, x2+1, y2)
	draw_text(x+o_console.SLIDER.text_offset, y+o_console.SLIDER.height/2+1, text)
	shader_reset()
}

if value > 0
{
	var value_x = x + (ceil( (x2-x)*value ))
	
	draw_set_color(o_console.colors.output)
	draw_rectangle(x, y, value_x, y2, false)
	
	if value_show and not condensed
	{
		clip_rect_cutout(x, y, value_x+1, y2);
		
		draw_set_color(o_console.colors.body_real)
		draw_text(x+o_console.SLIDER.text_offset, y+o_console.SLIDER.height/2+1, text)
		
		shader_reset()
	}
}

draw_set_color(c_white)
}}