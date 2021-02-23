// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function embedded_text_get_plain(text){

if is_undefined(text) or text == "" or text == []
{
	return ""
}
else
{
	if not is_array(text) text = [text]

	var _text = ""
	var text_len = array_length(text)
	
	for(var i = 0; i <= text_len-1; i++)
	{	
		var add = variable_struct_exists_get(text[i], "str", text[i])
		if is_string(add)
		{
			if is_struct(text[i]) and variable_struct_exists(text[i], "checkbox") _text += "[/]"
			_text += add
		}
	}
	return _text
}
}