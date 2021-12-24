
function dev_console_setup(){ with o_console {

if not gmcl_in_debug_mode return undefined

// These are in-dev operations and should've been removed
add_console_element(new_console_dock("Scroll", [
	[new_scrubber("scroll x","o_dev.sc.scroll_x",1),new_scrubber("scroll y","o_dev.sc.scroll_y",1),],
	new_separator(),
	[new_display_box("mouse on wbar","o_dev.sc.mouse_on_wbar",false),new_display_box("mouse on hbar","o_dev.sc.mouse_on_hbar",0),],
	[new_display_box("mouse offset","o_console.SCROLLBAR.mouse_offset",false),],
	new_separator(),
	[new_scrubber("wbar_center","o_dev.sc.wbar_center",1),new_scrubber("hbar_center","o_dev.sc.hbar_center",1),],
	new_separator(),
	[new_scrubber("wbar_min","o_dev.sc.wbar_min",1),new_scrubber("wbar_max","o_dev.sc.wbar_max",1),],
	[new_scrubber("hbar_min","o_dev.sc.hbar_min",1),new_scrubber("hbar_max","o_dev.sc.hbar_max",1),],
]))


var t = new_text_box("Text", "text") with t {
att.length_min = 70
att.exit_with_enter = false
__command = false
color_method = function(){
	
	var i = 1
	while string_char_at(text, i) == " " i++
	
	if string_char_at(text, i) == "/"
	{
		var f = gmcl_string_color(slice(text, i+1))
		array_insert(f.colors, 0, {col: "body_accent", text: slice(text,,i+1)})
		
		__command = i+1
		return f
	}
	else 
	{
		__command = false
		return undefined
	}
}

on_enter = function(){
	
	if __command
	{
		gmcl_exec(slice(text, __command))
	}
	else
	{
		show_debug_message(text)
	}
	
	text = ""
	keyboard_string = ""
	update_variable()
}
}

add_console_element(t)

// These are just my preferred settigs; you can put anything in here really
autofill_from_float = true
}}