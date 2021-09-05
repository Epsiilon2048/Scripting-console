// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function format_output(output, embedded, tag, name){

if is_undefined(embedded) embedded = false
if is_undefined(tag) tag = -1

if embedded output = new_embedded_text(output)
return new element_container(output)

return {o: output, __tag__: tag, __embedded__: embedded, __name__: name}
}