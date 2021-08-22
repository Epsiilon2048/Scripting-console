
init = true

f=[0]

text = ""

var tb_text = new_text_box("o_dev.text") with tb_text {
	att.set_variable_on_input = true
	att.length_min = 16
}

var emb = new Embedded_text()
emb.set(["Click ",{str: "here",scr: show_message, arg: 1}," to show the message \"1\""])

var dc = new Console_dock() with dc
{
	initialize()
	name = "embedded lol"
	set([
		"this is pretty cool right???",
		["its like",new_text_box(),"a new thing and stuff!!"],
		"woo embedded lol"
	])
}
cd = new Console_dock() with cd
{
	initialize()
	name = "Test console dock"
	set([
		["text",tb_text],
		["x",new_scrubber("o_dev.x"),"y",new_scrubber("o_dev.y")],
		["image_angle ",new_scrubber("o_dev.image_angle")],
		dc,
		["image_xscale",new_scrubber("o_dev.image_xscale"),"image_yscale",new_scrubber("o_dev.image_yscale")],
		emb,
	])
}

//w=150
//h=150
//scr=new Console_scrollbar()
//scr.initialize(x, y, x+w, y+h, w, h, sprite_get_width(s_scrollbar_tester), sprite_get_height(s_scrollbar_tester), fa_left, fa_bottom)
