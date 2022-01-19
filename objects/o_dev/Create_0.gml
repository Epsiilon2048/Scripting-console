
var sl_a = new Autofill_sublist() with sl_a
{
	color = 2
	show_all_if_blank = true
	get = function(){
		if not instance_exists(o_console.object) 
		{
			list = [ ]
		}
		else 
		{
			list = variable_instance_get_names(o_console.object)
		}
	}
	get()
}

var sl_bc = new Autofill_sublist() with sl_bc
{
	list = [
		"bbb",
		"bba",
		"bab",
		"baa",
		"bbc",
		"bcb",
		"bcc",
		"bac",
		"bca",
			
		"ccc",
		"cca",
		"cac",
		"caa",
		"ccb",
		"cbc",
		"cbb",
		"cab",
		"cba",
	]
}

l = new Console_autofill_list() with l
{
	initialize()
	set_multiple([
		sl_a,
		["a", "b", "c", "d", "e", "f", "g"],
		sl_bc,
	])
}


sc = new Console_scrollbar()
sc.initialize()
sc.set_boundaries(sprite_get_width(Sprite9), sprite_get_height(Sprite9), x, y, x+200, y+200)