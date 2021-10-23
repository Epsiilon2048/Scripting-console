
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
								  
	self[$ dt_real]			= 0
	self[$ dt_string]		= 0
	self[$ dt_asset]		= 0
	self[$ dt_variable]		= 0
	self[$ dt_method]		= 0
	self[$ dt_instance]		= 0
	self[$ dt_builtinvar]	= 0
	self[$ dt_color]		= 0
	self[$ dt_tag]			= 0
	self[$ dt_deprecated]	= 0
}
}

function color_scheme_set_output(color_scheme, output, ex_output, plain, selection, embed, embed_hover){
color_scheme.output			= output
color_scheme.ex_output		= ex_output
color_scheme.plain			= plain
color_scheme.selection		= selection
color_scheme.embed			= embed
color_scheme.embed_hover	= embed_hover
}

function color_scheme_set_body(color_scheme, body, body_bm, body_alpha, body_real, body_real_alpha, body_accent){
color_scheme.body				= body			
color_scheme.body_bm			= body_bm		
color_scheme.body_alpha			= body_alpha		
color_scheme.body_real			= body_real		
color_scheme.body_real_alpha	= body_real_alpha
color_scheme.body_accent		= body_accent	
}

function color_scheme_set_sprite(color_scheme, sprite, sprite_anchor, sprite_alpha){
color_scheme.sprite			= -1
color_scheme.sprite_anchor	= false
color_scheme.sprite_alpha	= 0
}

function color_scheme_set_dt(color_scheme, real, string, asset, variable, method, instance, color, tag, deprecated, builtinvar){
color_scheme[$ dt_real]			= real
color_scheme[$ dt_string]		= string
color_scheme[$ dt_asset]		= asset
color_scheme[$ dt_variable]		= variable
color_scheme[$ dt_method]		= method
color_scheme[$ dt_instance]		= instance
color_scheme[$ dt_builtinvar]	= builtinvar
color_scheme[$ dt_color]		= color
color_scheme[$ dt_tag]			= tag
color_scheme[$ dt_deprecated]	= deprecated
}