
function input_set(str, add){ with o_console.BAR {
	input_log_index = -1
	enabled = true
	
	if is_undefined(add) or not add 
	{
		//ds_list_insert(input_log, 0, console_string)
		console_string = str
	}
	else
	{
		console_string = string_insert(str, console_string, text_box.char_pos1)
		text_box.char_pos1 += string_length(str)
		text_box.char_pos2 = text_box.char_pos1
	}

	keyboard_string = console_string
	colors = text_box.color_method(console_string, text_box.char_pos1)
	text_box.char_pos1 = string_length(console_string)+1
	text_box.char_pos2 = text_box.char_pos1
	
	text_box.update_variable()
}}



function input_set_pos(input){ with o_console.keyboard_scope {
input = string(input)

if string_pos(string_char_at(text, char_pos2), o_console.refresh_sep) char_pos2--

var _min = char_pos2
var _max = char_pos2

var str_length = string_length(text)
var char = string_char_at(text, _max)

while _max < (str_length) and not (char != "" and string_pos(char, o_console.refresh_sep))
{
	_max++
	char = string_char_at(text, _max)
}

var char = string_char_at(text, _min)
while _min > 0 and not (char != "" and string_pos(char, o_console.refresh_sep))
{
	_min--
	char = string_char_at(text, _min)
}
_min++
_max++

text = string_delete(text, _min, _max-_min)
text = string_insert(input, text, _min)
keyboard_string = text
char_pos1 = min(_min+string_length(input), string_length(text)+1)
char_pos2 = char_pos1

if not att.allow_alpha
{
	if not string_is_float(text)
	{
		text = "0"
		char_pos1 = 1
		char_pos2 = char_pos1
		char_selection = false
	}
	else
	{
		text = string_format_float(clamp(real(text), att.value_min, att.value_max), att.float_places)
	}
}

convert(text)

var _association = is_undefined(association) ? (docked ? dock.association : self) : association
if att.set_variable_on_input and not is_undefined(variable) with _association variable_string_set(other.variable, other.value)
			
text_width = string_width("W")*clamp(string_length(text), att.length_min, att.length_max)
				
char_mouse = false
				
colors = color_method(text)
blink_step = 0
keyboard_string = text
set_boundaries()
}}



function output_set(output){ with o_console.OUTPUT {

dock.name = "Output"

if is_struct(output) and variable_struct_exists(output, "__embedded__") output = output.o

dock.enabled = not is_undefined(output)


if is_string(output)
{
	dock.to_set = output
	move_to_front(self)
	exit
}

if is_bool(output)
{
	dock.to_set = output ? "true" : "false"
	move_to_front(self)
	exit
}

if is_real(output)
{
	dock.to_set = output
	move_to_front(self)
	exit
}

if is_ptr(output)
{
	dock.to_set = "pointer"
	move_to_front(self)
	exit
}

if is_method(output)
{
	dock.to_set = string(output)
	move_to_front(self)
	exit
}


if not is_struct(output) and not is_array(output)
{
	dock.to_set = string(output)
	exit
}


var str = ""
var sep = ",\n"

if is_struct(output)
{
	var io = instanceof(output)
	
	if io == "Console_dock"
	{
		if not variable_struct_exists(output, "name")
		{
			output.initialize()
			output.set()
		}
		
		replace_console_element(output)
		exit
	}
	
	if io == "element_container" or variable_struct_exists_get(output, "is_console_element", false)
	{
		dock.to_set = output
		move_to_front(self)
		exit
	}
	
	if variable_struct_names_count(output) == 0
	{
		dock.to_set = "{ }"
		move_to_front(self)
		exit
	}
	
	var list = variable_struct_get_names(output)
	var str = "{\n"
	var after = "}"
}


if is_array(output)
{
	if array_length(output) == 0
	{
		dock.to_set = "[ ]"
		move_to_front(self)
		exit
	}
	
	var list = output
	var str = "[\n"
	var after = "]"
}


static max_items = 20

for(var i = 0; i <= min(max_items, array_length(list)-1); i++)
{	
	var item = list[i]
	var value
		
	if is_struct(output)
	{
		value = output[$ list[@ i]]
		str += item+": "
	}
	else value = list[i]
		
	if is_string(value)
	{
		if string_length(value) < 300 and not string_pos("\n", value)
		{
			str = "\""+value+"\""
		}
		else
		{
			str = "string"
		}
		str += sep
		continue
	}
		
	if is_bool(value)
	{
		str += (value ? "true" : "false")+sep
		continue
	}
		
	if is_numeric(value)
	{
		str += string(value)+sep
		continue
	}
		
	if is_struct(value)
	{
		var struct = string_replace_all(string(value), " : ", ": ")
		if string_length(struct) > 150 str += instanceof(value)+sep
		else str += struct+sep
		continue
	}
		
	if is_array(value)
	{
		var array = string_replace_all(string(value), " : ", ": ")
		var len = array_length(value)
		if string_length(array) > 150 str += "array with "+string(len)+" item"+((len == 1) ? "" : "s")+sep
		else str += array+sep
		
		continue
	}
		
	if is_ptr(value)
	{
		str += "pointer"+sep
		continue	
	}
		
	if is_method(value)
	{
		str += "method"+sep
		continue
	}
		
	str += string(value)+sep
}


if i >= max_items
{
	str += "(...)"
	dock.to_set = str
	exit
}


str += after
dock.to_set = str

/*
if is_struct(output) and variable_struct_exists(output, "__embedded__") output = output.o

dock.association = dock
o_console.O = output
		
if is_array(output)
{
	var text = "["
	for(var i = 0; i <= array_length(output)-1; i++)
	{
		if is_array(output[i]) text += "\n[array]"
		else if is_struct(output[i]) text += "{"+instanceof(output[i])+"}"
		else text += string(output[i])
	}
	text += "]"

	dock.to_set = text)
}
if is_struct(output)
{
	var io = instanceof(output)
		
	if io == "Console_dock"
	{
		add_console_element(output)
	}
	else if io == "element_container" or variable_struct_exists_get(output, "is_console_element", false)
	{
		dock.to_set = output)
	}
	else
	{
		var names = variable_struct_get_names(output)
		
		if array_length(names) == 0
		{
			names = "{}"
		}
		else for(var i = 0; i <= array_length(names)-1; i++)
		{
			if is_array(output[$ names[i]]) names[i] = [names[i]+":", "[array]"]
			else if is_struct(output[$ names[i]]) names[i] = [names[i]+":","{"+instanceof(output[$ names[i]])+"}"]
			else names[i] = [names[i]+":", new_display_box(undefined, names[i], false)]
		}
		
		if array_length(names) == 1
		{
			names = [["{",names[0],"}"]]
		}
		
		array_insert(names, 0, "{")
		array_push(names, "}")

		dock.association = output		
		dock.to_set = names)
	}
}
else 
{
	if is_string(output) and not string_pos("\n", output) dock.to_set = quotes_if_string(output))
	else if is_numeric(output) dock.to_set = string_format_float(output, float_count_places(output, 4)))
	else dock.to_set = string(output))
}

dock.enabled = not is_undefined(output)
if dock.enabled move_to_front(self)
*/
}}



function output_set_lines(output){
if is_array(output) output_set(output[0]) else output_set(output)
}