
function draw_ease(ease, x1, y1, x2, y2, w){

for(var i = 0; i <= x2-x1; i++)
{
	draw_line_width(
		x1+i, y1+(y2-y1)-ease(i/(x2-x1))*(y2-y1),
		x1+i+1, y1+(y2-y1)-ease((i+1)/(x2-x1))*(y2-y1),
		w
	)
}
}



function ease_normal(val)
	{ return val }

function ease_out_quint(val)
	{ return 1 - power(1 - val, 5) }

function ease_in_quint(val)
	{ return power(val, 5) }