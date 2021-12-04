

draw_set_font(Font7)
draw_set_halign(fa_left)
draw_set_valign(fa_top)


var width = string_width(t)
var height = string_height(t)

windex2 = 0

if gui_mouse_between(x, y, x+width, y+height-1)
{
	var _start = 1
	var _end = string_length(t)
	var ch = string_height("W")
	has_newline = ch != height
	var nl_index = 0

	if has_newline
	{
		nl_index = floor( (gui_my-y) / ch )
		if nl_index == 0 _start = 1
		else 
		{
			_start = string_pos_index("\n", t, nl_index)+1
		}
		
		_end = string_pos_index("\n", t, nl_index+1)
		if _end == 0 _end = string_length(t)
	}
	else
	{
	}

	
	var on = false
	for(index = _start; index <= _end; index++)
	{
		windex1 = windex2
		windex2 += string_width(string_char_at(t, index))
		
		if x+windex2 > gui_mx 
		{
			on = true
			break
		}
	}
	
	if on
	{
		draw_set_color(c_red)
		draw_rectangle(x+windex1, y+ch*nl_index, x+windex2, y+ch*(nl_index+1), true)
	}
}

draw_set_color(c_white)
draw_text(x, y, t)