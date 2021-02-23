// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function color_make(r, g, b){

var _col = make_color_rgb(r, g, b)
var box = {str: "color ", col: _col}

o_console.Output.embedding = true

if instance_exists(object)
{
	object._col = _col
	return [box, stitch(object_get_name(object),"._col set to ",_col)]
}
else
{
	return [box, string(_col)]
}
}