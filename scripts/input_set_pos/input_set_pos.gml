function input_set_pos(input){ with o_console.keyboard_scope {

var old_font = draw_get_font()
draw_set_font(o_console.font)
var tb = o_console.TEXT_BOX
var ch = string_height(" ")
var asp = ch/tb.char_height
var _text_hdist = floor(tb.text_hdist*asp)
draw_set_font(old_font)

input = string(input)

if string_pos(string_char_at(text, char_pos2), o_console.refresh_sep) char_pos2--

var _min = char_pos2
var _max = char_pos2

var str_length = string_length(text)

while _max < (str_length) and not string_pos(string_char_at(text, _max), o_console.refresh_sep)
{
	_max++
}

while _min > 0 and not string_pos(string_char_at(text, _min), o_console.refresh_sep)
{
	_min--
}
_min++
_max++

text = string_delete(text, _min, _max-_min)
text = string_insert(input, text, _min)
keyboard_string = text
char_pos1 = min(_min+string_length(input), string_length(text)+1)
char_pos2 = char_pos1

if not att.allow_alpha
{
	if not string_is_float(text)
	{
		text = "0"
		char_pos1 = 1
		char_pos2 = char_pos1
		char_selection = false
	}
	else
	{
		text = string_format_float(clamp(real(text), att.value_min, att.value_max), att.float_places)
	}
}

convert(text)

var _association = is_undefined(association) ? (docked ? dock.association : self) : association
if att.set_variable_on_input and not is_undefined(variable) with _association variable_string_set(other.variable, other.value)
			
text_width = string_width(" ")*clamp(string_length(text), att.length_min, att.length_max)
				
char_mouse = false
				
colors = color_method(text)
blink_step = 0
keyboard_string = text
set_boundaries()
}}