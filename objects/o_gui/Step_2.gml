/*
emb.set([
	"Help & info\n",
	{str: "Basic syntax & usage", func: syntax_help, outp: true}," dfgdfg\n",
	{str: "Command list", func: command_help, outp: true},"\n",
	{str: "Console windows", func: console_window_help, outp: true},"\n",
	{str: "Embedded text", func: embedded_text_help, outp: true},"\n",
	{str: "Videos", func: console_videos, outp: true},"\n\n"+
	
	"Options\n",
	{str: "General settings", func: console_settings, outp: true},"\n",
	{str: "Color schemes", func: color_scheme_settings, outp: true},"\n\n"+
	
	"Other stuff\n",
	{str: "Instances in room", func: roomobj, outp: true},"\n",
	{str: "Say a nice thing!", func: nice_thing, outp: true},"\n",
	{str: "Github page", func: url_open, arg: "https://github.com/Epsiilon2048/gms-funcipt-console"}," [link]\n",
	{str: "Creator info", func: Epsiilon, outp: true},"\n\n"+
	
	"Note, you can press [shift+console_key]\n"+
	"to quickely return to this menu!"
])