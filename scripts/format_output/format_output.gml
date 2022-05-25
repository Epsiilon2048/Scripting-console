
function format_output(output, embedded=false){

if o_console.run_in_embed return output

if embedded output = new_embedded_text(output)
return new element_container(output)
}
