
function text_char_at(x, y, str_x, str_y, str){
//i bodged this together since people were asking for it before it was complete, in
//a more final version the logic won't be as redundant

var str_width = string_width(str)

var halign =  (draw_get_halign() == fa_center)*str_width/2
			 +(draw_get_halign() == fa_right )*str_width
			 
var valign =  (draw_get_valign() == fa_middle)*str_width/2
			 +(draw_get_valign() == fa_bottom)*str_width

if x < str_x+halign or y < str_y+valign
{
	return 0
}
else
{

var char_x = floor((x-str_x+halign)/string_width (" "))
var char_y = floor((y-str_y+valign)/string_height(" "))

var pos = char_x+1
var list = string_split("\n", str)

if (char_y > array_length(list)-1) or (char_x > string_length(list[clamp(char_y+1,1, array_length(list))-1])-1)
{
	return 0
}
else
{
	for(var i = 0; i <= min(char_y, array_length(list))-1; i++)
	{
		pos += string_length(list[i])
	}
	return pos
}
}
}




function draw_roundline(x1, y1, x2, y2, w){ //draws a line with circles on its ends

draw_circle(x1, y1, w/2, false)
draw_line_width(x1, y1, x2, y2, w)
draw_circle(x2, y2, w/2, false)
}




function draw_set_align(halign, valign){

draw_set_halign(halign)
draw_set_valign(valign)
}




function draw_set_properties(color, alpha, blendmode){

draw_set_color(color)
if not is_undefined(alpha)	   draw_set_alpha(alpha)
if not is_undefined(blendmode) gpu_set_blendmode(blendmode)
}




function draw_reset_properties(){ // resets color, alpha, circle precision, blendmode, and shader

draw_set_color(c_white)
draw_set_alpha(1)
draw_set_circle_precision(24)

gpu_set_blendmode(bm_normal)
shader_reset()
}