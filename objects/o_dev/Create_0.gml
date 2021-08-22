
init = true

f=[0]


var txx = new Cd_text()
txx.initialize("x")
var tbx = new Text_box()
tbx.initialize_scrubber(x, y) with tbx{
	variable = "o_dev.x"
}

var txy = new Cd_text()
txy.initialize("y")
var tby = new Text_box()
tby.initialize_scrubber(x, y) with tby{
	variable = "o_dev.y"
}


var nwdtx = new Cd_text()
nwdtx.initialize("name_wdist")
var nwdtb = new Text_box()
nwdtb.initialize_scrubber(0, 0, 1)
nwdtb.variable = "o_console.DOCK.name_wdist"

var nhdtx = new Cd_text()
nhdtx.initialize("name_hdist")
var nhdtb = new Text_box()
nhdtb.initialize_scrubber(0, 0, 1)
nhdtb.variable = "o_console.DOCK.name_hdist"


var ewdtx = new Cd_text()
ewdtx.initialize("element_wdist")
var ewdtb = new Text_box()
ewdtb.initialize_scrubber(0, 0, 1)
ewdtb.variable = "o_console.DOCK.element_wdist"

var ehdtx = new Cd_text()
ehdtx.initialize("element_hdist")
var ehdtb = new Text_box()
ehdtb.initialize_scrubber(0, 0, 1)
ehdtb.variable = "o_console.DOCK.element_hdist"


var ewstx = new Cd_text()
ewstx.initialize("element_wsep")
var ewstb = new Text_box()
ewstb.initialize_scrubber(0, 0, 1)
ewstb.variable = "o_console.DOCK.element_wsep"

var ehstx = new Cd_text()
ehstx.initialize("element_hsep")
var ehstb = new Text_box()
ehstb.initialize_scrubber(0, 0, 1)
ehstb.variable = "o_console.DOCK.element_hsep"


var emb = new Embedded_text()
emb.set(["Click ",{str: "here",scr: show_message, arg: 1}," to show the message \"1\""])

cd = new Console_dock()
cd.initialize() with cd
{
	name = "Test console dock"
	elements = [
		[txx, tbx, txy, tby],
		[nwdtx, nwdtb, nhdtx, nhdtb],
		[ewdtx, ewdtb, ehdtx, ehdtb],
		[ewstx, ewstb, ehstx, ehstb],
		emb,
	]	
}

//w=150
//h=150
//scr=new Console_scrollbar()
//scr.initialize(x, y, x+w, y+h, w, h, sprite_get_width(s_scrollbar_tester), sprite_get_height(s_scrollbar_tester), fa_left, fa_bottom)
