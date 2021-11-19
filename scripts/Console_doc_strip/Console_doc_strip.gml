
function draw_doc_strip(x, y, doc){ with o_console.DOC_STRIP {

if is_undefined(doc) return undefined 

draw_set_font(o_console.font)
var ch = string_height("W")
var asp = ch/char_height
var _wdist = round(wdist*asp)
var _hdist = round(hdist*asp)

var text
show_debug_message(doc)
if is_struct(doc)	text = doc.description
else				text = string(doc)

var width = string_width(text)
var height = string_height(text)
var x2 = x+_wdist*2+width
var y2 = y+_hdist*2+height
	
draw_console_body(x, y, x2, y2)
	
draw_set_color(o_console.colors.output)
draw_set_halign(fa_left)
draw_set_valign(fa_top)
draw_color_text(x+_wdist, y+_hdist, text)
}}