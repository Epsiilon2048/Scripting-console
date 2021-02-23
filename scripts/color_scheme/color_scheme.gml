
function color_scheme(value){

colors = color_schemes[value]
color_string = color_console_string(console_string)
cs_index = value
return stitch("Console color scheme set to ",value)
}