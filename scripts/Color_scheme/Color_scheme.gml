
function Color_scheme() constructor{
	
self.build = function(author){
		
	self.author = author
	self.builtin = not (o_console.run_in_console or o_console.run_in_embed)
		
	self.body				= 0
	self.body_bm			= bm_normal
	self.body_alpha			= 1
	
	self.body_real			= 0
	self.body_real_alpha	= 0
	
	self.body_accent		= 0
	
	self.output				= 0
	self.ex_output			= 0
	self.embed				= 0
	self.embed_hover		= 0
	self.plain				= 0
	self.selection			= 0

	self.sprite				= -1
	self.sprite_anchor		= false
	self.sprite_alpha		= 0

	self.outline_layers		= 0
	self.bevel				= undefined
								  
	self.real		= 0
	self.string		= 0
	self.asset		= 0
	self.variable	= 0
	self.method		= 0
	self.instance	= 0
	self.builtinvar	= 0
	self.color		= 0
	self.tag		= 0
	self.deprecated	= 0
}
}