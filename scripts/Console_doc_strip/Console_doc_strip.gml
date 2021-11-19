






function draw_doc_strip(x, y, doc, x2){ with o_console.DOC_STRIP {

if is_undefined(doc) return false

var text
if is_struct(doc)
{
	text = doc.description
	if is_undefined(text) return false
}
else text = string(doc)

if text == "" return false

var old_color = draw_get_color()
var old_font = draw_get_font()
var old_halign = draw_get_halign()
var old_valign = draw_get_valign()

draw_set_font(o_console.font)
var ch = string_height("W")
var asp = ch/char_height
var _wdist = round(wdist*asp)
var _hdist = round(hdist*asp)

var width = string_width(text)
var height = string_height(text)

x2 = max(is_undefined(x2) ? 0 : x2, x+_wdist*2+width)
var y2 = y+_hdist*2+height

draw_console_body(x, y, x2, y2)

draw_set_color(o_console.colors.plain)
draw_set_halign(fa_left)
draw_set_valign(fa_top)

draw_color_text(x+_wdist, y+_hdist, text)

draw_set_color(old_color)
draw_set_font(old_font)
draw_set_halign(old_halign)
draw_set_valign(old_valign)

return true
}}