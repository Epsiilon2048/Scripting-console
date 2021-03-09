
/*
str
scr
arg
args
func
checkbox
shortcut
*/
g = false
ctx = new Ctx_menu()
ctx.set([
	{str: "Hello!!"},
	{str: "Hows the context menu looking??", scr: show_message, arg: "Good!"},
	o_console.CTX_MENU.SEPARATOR,
	{str: "yooooo"},
	{str: "Option3"},
	{str: "yooooo"},
	{str: "Option4", checkbox: "o_gui.g", stay: true},
	{str: "yooooo"},
	{str: "Option5"},
	o_console.CTX_MENU.SEPARATOR,
	{str: "The option"},
	{str: "The cooler option"},
])