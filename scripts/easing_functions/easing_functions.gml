// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function ease_normal(val)
	{ return val }


function ease_out_quint(val)
	{ return 1 - power(1 - val, 5) }

function ease_in_quint(val)
	{ return power(val, 5) }