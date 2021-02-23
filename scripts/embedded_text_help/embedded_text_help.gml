// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function embedded_text_help(){ with o_console {

o_console.Output.embedding = true
return [
	"Text embedding is used everywhere for menus and interactive elements.\n\n"+
	
	"It's used to change the color of or bind scripts to text, and it also\n"+
	"supports checkboxes ",{checkbox:"o_console.checkboxes_like_this_one", str: " like this one"}," which can manipulate boolean variables.\n\n"+
	
	"However it is quite costly, and all settings can be manually edited\n"+
	"from the console.\n\n"+
	
	"As it stands, when embedding is disabled, all these menus are unchanged\n"+
	"in content, making them very difficult to navigate.\n"+
	"This will be fixed soon hopefully.\n\n"+
	
	"Note that the console input colors are not embeds.\n\n"+

	"Embeds can be disabled in ",{str: "general settings", scr: console_settings, output: true},"."
]
}}