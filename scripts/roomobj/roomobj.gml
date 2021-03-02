// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function roomobj(){

var text = []

for (i = 0; i <= instance_count-1; i++)
{
	var inst = instance_id[i]
	var name = object_get_name(inst.object_index)
	var entry = {}; with entry
	{
		id   = inst
		str  = stitch("(",id,")\n")
		func = function(){o_console.object = id}
	}
	
    array_push(text, name+" ", entry)
}
text[array_length(text)] = "\nClick on an ID to set the console scope"

return {__embedded__: true, o: text}
}