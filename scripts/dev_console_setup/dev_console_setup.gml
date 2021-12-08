
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

// These are just my preferred settigs; you can put anything in here really
autofill_from_float = true
}}