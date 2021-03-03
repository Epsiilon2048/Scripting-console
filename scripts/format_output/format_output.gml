// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function format_output(output, embedded, tag){

var _embedded = is_undefined(embedded) ? false : embedded
var _tag =		is_undefined(tag)	   ? -1	   : tag

return {o: output, __tag__: _tag, __embedded__: _embedded}
}