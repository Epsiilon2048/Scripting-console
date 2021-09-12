
function display(variable, step){

var t = new_text_box(variable, variable)
t.att.allow_input = false

add_console_element(t)
}

function add_textbox(variable, step){

add_console_element(new_text_box(variable, variable))
}

function add_scrubber(variable, step){

add_console_element(new_scrubber(variable, variable, step))
}