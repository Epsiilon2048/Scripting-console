
mouse_on_console = false

o_console.run_in_console = true
simple = variable_string_info(o_console.BAR.text_box.text).simple
o_console.run_in_console = false

//sc.get_input()

{
	if o_console.console_string != constr
	{
		gmcl_autofill_new(o_console.console_string)
		//autofill.get(o_console.console_string)
		constr = o_console.console_string
	}
	autofill.get_input()
}
