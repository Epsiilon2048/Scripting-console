
function draw_hollowrect(x1, y1, x2, y2, w){

var _x1 = min(x1, x2)
var _y1 = min(y1, y2)
var _x2 = max(x1, x2)
var _y2 = max(y1, y2)

if _x1+w >= _x2 or _y1+w >= _y2 draw_rectangle(_x1, _y1, _x2, _y2, false)
else
{
	draw_rectangle(_x1, _y1, _x2-w, _y1+w, false)
	draw_rectangle(_x2-w, _y1, _x2, _y2-w, false)
	draw_rectangle(_x2+1, _y2-w, _x1+w, _y2, false)
	draw_rectangle(_x1, _y2+1, _x1+w, _y1+w, false)
}
}