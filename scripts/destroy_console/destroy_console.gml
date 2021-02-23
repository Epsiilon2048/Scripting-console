// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function destroy_console(confirmation){

if confirmation
{
	instance_destroy(o_console)
}
else
{
	o_console.Output.embedding = true
	output_set([[
	"H-huh?? Unless you build your own method of getting it back, I'll be gone for the rest of the runtime!\nCould break some stuff too!! S-seriously, I bet it'll crash the moment you do it!\n",
	"Are you absolutely sure? <",{str: "yep!", scr: destroy_console, arg: true},">"
	]])
}
}