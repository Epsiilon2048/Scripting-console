
function command_doc_add(name, details){ with o_console {

commands[? name] = details
}}



function command_doc(command){ with o_console {

if ds_map_exists(commands, command)
{
	var _command = commands[? command]
	
	var _hidden		= variable_struct_exists_get(_command, "hidden",  false)
	var _args		= variable_struct_exists_get(_command, "args",	 [])
	var _optargs	= variable_struct_exists_get(_command, "optargs", [])
	var _hiddenargs = show_hidden_args ? variable_struct_exists_get(_command, "hiddenargs", []) : []
	var _moreargs	= variable_struct_exists_get(_command, "moreargs", false)
	
	var argtext = "("

	for(var i = 0; i <= array_length(_args)-1; i++)		  argtext += _args[i]+", "
	for(var i = 0; i <= array_length(_optargs)-1; i++)	  argtext += "["+_optargs[i]   +"], "
	for(var i = 0; i <= array_length(_hiddenargs)-1; i++) argtext += "<"+_hiddenargs[i]+">, "
	
	if _moreargs argtext += "..."
	else if argtext != "(" argtext = slice(argtext, , -3)
	argtext += ")"

	return command+argtext
}
else if ds_map_exists(deprecated_commands, command)
{
	var dep = deprecated_commands[? command]
	
	var str = ""
	if variable_struct_exists(dep, "ver")		str += dep.ver+"  "
	
	str += "Deprecated command"
	
	if variable_struct_exists(dep, "newname")	str += " - replaced with "+dep.newname
	if variable_struct_exists(dep, "note")		str += " - "+dep.note
	
	return str
}
}}



function command_doc_desc(command){ with o_console {
	
if ds_map_exists(commands, command)
{
	var doc = command_doc(command)
	var func_end = string_pos("(", doc)
	
	doc = [{str: slice(doc, , func_end), col: dt_method}, slice(doc, func_end)]
	
	if not variable_struct_exists(commands[? command], "desc") return doc
	
	array_push(doc, " - "+commands[? command].desc)
	return doc
}
else if ds_map_exists(deprecated_commands, command)
{
	return [command_doc(command)]
}

return []
}}



function ds_create(ds_type, name=undefined, w=undefined, h=undefined){

var ind = -1

switch ds_type
{
	case ds_type_grid:		ind = ds_grid_create(w, h)	break
	case ds_type_list:		ind = ds_list_create()		break
	case ds_type_map:		ind = ds_map_create()		break
	case ds_type_priority:	ind = ds_priority_create()	break
	case ds_type_queue:		ind = ds_queue_create()		break
	case ds_type_stack:		ind = ds_stack_create()
}

if not is_undefined(name)
{	
	if not string_pos(".", name) name = string(id)+"."+name
	else name = string_scope_to_id(name, true)
	
	o_console.ds_types[? name] = ds_type
	o_console.ds_names[$ ds_type][@ ind] = {name: name}
}

return ind
}



function ds_destroy(ds_type, ind){ with o_console {

if ds_exists(ds_type, ind) switch ds_type
{
	case ds_type_grid:		ds_grid_destroy(ind)		break
	case ds_type_list:		ds_list_destroy(ind)		break
	case ds_type_map:		ds_map_destroy(ind)			break
	case ds_type_priority:	ds_priority_destroy(ind)	break
	case ds_type_queue:		ds_queue_destroy(ind)		break
	case ds_type_stack:		ds_stack_destroy(ind)
}

if ind >= 0 and ind < array_length(ds_names[$ ds_type]) and is_struct(ds_names[$ ds_type][@ ind])
{
	var name = ds_names[$ ds_type][@ ind].name
	ds_map_delete(ds_types, name)
	ds_names[$ ds_type][@ ind] = undefined
}
}}