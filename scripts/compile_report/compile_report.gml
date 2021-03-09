// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function compile_report(compile, output){ with o_console {

var _console = false

var _compile = compile
var _output  = output
var _command = undefined

var str = ""

if is_undefined(compile) 
{
	_console = true
	
	_command = prev_command
	_compile = prev_compile
	_output  = prev_output
}

var _lines = array_length(_compile)

if not is_undefined(_command) str += "Input: \""+_command+"\"\n"

if _lines > 1 str += "Lines: "+string(_lines)

var _error_exists  = false
var _script_exists = false

for(var l = 0; l <= _lines-1; l++)
{
	var _str = ""
	
	if _lines > 1 _str += "\n\n===== LINE "+string(l)+" =====\n"
	
	if not is_struct(_compile[l]) _str += "\nWhitespace"
	else {
	
	var _error   = _compile[l].error
	var _subject = _compile[l].subject
	var _args	 = _compile[l].args
	
	var _plainstr = "Parsed command: "+_subject.plain
	var _valstr   = ""
	var _argstr   = ""
	
	var _outputstr = ""
	
	if not is_undefined(output)
	
	if not is_undefined(_error)	  _error_exists  = true
	if _subject.type == DT.SCRIPT _script_exists = true
	
	if array_length(_args) > 0
	{
		_valstr = "\nValued command: "+(is_undefined(_subject.value) ? _subject.plain : string(_subject.value))
		_argstr = "\nArguments"
	}
	
	for(var i = 0; i <= array_length(_args)-1; i++)
	{
		if is_struct(_args[i])
		{
			var _type = is_undefined(_args[i].type) ? -1 : dt_string[_args[i].type]
		
			_plainstr += " "+_args[i].plain
			_valstr   += " "+string(_args[i].value)
			_argstr   += stitch("\n ARG ",i,": Plain "+_args[i].plain+"; Type ",_type,"; Value ",_args[i].value)
		}
	}
	
	if array_length(_args) != 0
	{
		_valstr += "\n"
	}
	
	if not is_undefined(_output)
	{
		if not is_undefined(_error)
		{
			_outputstr += "Error: "+_error+"\n"
		}
		else
		{
			if is_struct(_output[l]) and variable_struct_exists_get(_output[l], "__embedded__", false)
			{
				_outputstr += "Output: "+string_replace_all( embedded_text_get_plain(_output[l].o), "\n", "\\n" )+"\n"+
							  "Embedded output: true\n"
			}
			else 
			{
				_outputstr += "Output: "+string_replace_all( string(_output[l]), "\n", "\\n" )+"\n"+
							  "Embedded output: false\n"
			}
		}
	}
	
	_str +=	"\n"+
			_outputstr+
			_plainstr+
			_valstr+
			_argstr
	}
	str += _str
}

if _script_exists and not _error_exists str = "Note that while there may not be any compile errors, there still could be scripting errors\n\n" + str

return str
}}