
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