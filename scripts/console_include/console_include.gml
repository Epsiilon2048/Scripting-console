
function console_include(criteria){

criteria = shave(" ", criteria)

if criteria == ""
{
	return "Must specify criteria!"
}
else if criteria == "*"
{
	o_console.builtin_excluded = []
	return console_macro_add_builtin(undefined)+" (wow you really didnt need to do that at all did you ??)"
}
else
{
	return console_macro_add_builtin(criteria)
}
}