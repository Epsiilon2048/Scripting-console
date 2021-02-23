// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function output_set(_output){
with(o_console)
{
	if not is_array(_output) _output = [_output]
	
	if is_undefined(_output) or _output == "" or _output == []
	{
		Output.text = []
		Output.plaintext = ""
		Output.text_embedding = false
	}
	else
	{
		if Output.embedding
		{
			Output.text = _output[0]
			Output.plaintext = embedded_text_get_plain(_output[0])
			Output.embedding = false
			Output.text_embedding = true
		}
		else
		{
			if array_length(_output) == 1 _output = _output[0]
			Output.text = array_to_string(_output, "\n")
			Output.plaintext = Output.text
			Output.text_embedding = false
		}
		Output.alpha		= 1
		Output.fade_time	= 0
		
		Output_window.set(Output.text)
	}
}
return _output
}