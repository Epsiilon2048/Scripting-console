function com_add(name, details){

commands[? name] = details
ds_list_add(command_order, {str: name, cat: false})
}

function com_add_category(text, hidden){

ds_list_add(command_order, {str: text, cat: true, hidden: is_undefined(hidden) ? false : hidden})
}