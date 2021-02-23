// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function color_get(_col){ with o_console {

if is_undefined(_col) _col = object._col
	
Output.embedding = true
return [{str: "color ", col: _col},stitch(color_get_red(_col),", ",color_get_green(_col),", ",color_get_blue(_col))]
}}