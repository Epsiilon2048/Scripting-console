// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function console_settings(){ with o_console {
	
return {__embedded__: true, o: [
	{str: "", checkbox: "o_console.collapse_windows"}, " Collapse windows by clicking sidebar\n\n",
	{str: "", checkbox: "o_console.embed_text"}, " Text embedding - WILL MAKE THIS WINDOW UNUSABLE IF DISABLED\n",
	{str: "", checkbox: "o_console.window_embed_text"}, " Window text embedding\n\n",
	{str: "", checkbox: "o_console.output_as_window", func: function(){o_console.Output_window.reset_pos()}}, " Output as window\n\n",
	{str: "", checkbox: "o_console.output_set_window"}, " Click output to set window\n",
	{str: "", checkbox: "o_console.force_output"}, " Always show output\n",
	{str: "", checkbox: "o_console.force_output_body"}, " Always show output background\n",
	{str: "", checkbox: "o_console.force_output_embed_body"}, " Show output background when it displays embedded text\n\n",
	
	{str: "", checkbox: "o_console.show_hidden_commands"}, " Show hidden commands in command help menu\n",
	{str: "", checkbox: "o_console.show_hidden_args"}, " Show hidden args in command help menu\n\n",
	
	{str: "Color schemes", scr: color_scheme_settings, output: true},"\n\n",

	{str: "Reset console\n", scr: reset_obj, arg: o_console},
	{str: "Destroy console", scr: destroy_console},
]}
}}