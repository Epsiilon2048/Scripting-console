
function initialize_autofill_index(){ with o_console {

builtin_excluded = [
	//"string",
	//"array",
	//"ds_list",
	//"ds_map",
	//"ds_grid_",
	//"ds_priority_",
	//"ds_queue_",
	//"ds_stack_",
	"ads_",
	"layer_",
	"gesture_",
	"keyboard_",
	"font_",
	"part_",			// Particles
	"steam_",	
	"xboxone_",	 
	"xboxlive_",	 
	"switch_",			// Of the nintendo variety
	"psn_",		
	"winphone_",	 
	"win8_",		 
	"vertex_",		 
	"uwp_",		
	"iap_",
	"sprite_",		 
	"skeleton_",	 
	"sequence_",	  
	"physics_",	 
	"path_",		 
	"matchmaking_", 
	"gpu_",
	"file_",
	"draw_",		 
	"display_",	 
	"date_",		 
	"camera_",		 
	"buffer_",		 
	"audio_",		 
	"achievement_", 

	// These are all odd builtin GML functions which aren't allowed in the studio, but are picked up when
	// indexing all the builtin functions. All of them are either useless or have GML counterparts.
	"ds_list_set_",		//ds_list_set_pre & ds_list_set_post 
	"ds_map_set_",		//ds_map_set_pre & ds_map_set_post 
	"ds_grid_set_p",	//ds_grid_set_pre & ds_grid_set_post
	"array_set_",		//array_set_pre, array_set_post, array_set_2D_pre, array_set_2D_post, & array_set_2D
	"@@",
	"yyAsm",
	"YoYo_",
	"$",				//$PRINT, $FAIL, $ERROR
	"sleep",
	"testFailed",
]

macro_list = ds_create(ds_type_list, "macro_list", "", 0, 0)
method_list = ds_create(ds_type_list, "method_list", "", 0, 0)
asset_list = ds_create(ds_type_list, "asset_list", "", 0, 0)
instance_variables = []
scope_variables = []
lite_suggestions = ds_create(ds_type_list, "lite_suggestions", "", 0, 0)
suggestions = ds_create(ds_type_list, "suggestions", "", 0, 0)

// Initial suggestions; can be replaced without concern
ds_list_add(suggestions, 
	"help",
	"display",
)

autofill = {}; with autofill {
	methods = new Autofill_sublist() with methods
	{
		color = dt_method
		get = function(){
			list = o_console.method_list
		}
		format = function(item){
			return new Autofill_item(item, item, "Function")
		}
		get()
	}

	assets = new Autofill_sublist() with assets
	{	
		color = dt_asset
		get = function(){
			list = o_console.asset_list
		}
		format = function(item){
			var side_text = string_capitalize(asset_type_to_string(asset_get_type(item)))
			var color = undefined
	
			if side_text == "Object" and instance_exists(asset_get_index(item))
			{
				color = dt_instance		
			}
		
			return new Autofill_item(item, item, side_text, color)
		}
		get()
	}

	scope_variables = new Autofill_sublist() with scope_variables
	{
		color = dt_variable
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
		format = function(item){
			var color = dt_variable
			var value = variable_instance_get(o_console.object, item)
		
			if is_method(value) color = dt_method
			else if is_struct(value) color = dt_instance
		
			return new Autofill_item(item, item, "Variable", color)
		}
		get()
	}

	macros = new Autofill_sublist() with macros
	{
		color = dt_real
		get = function(){
			list = o_console.macro_list
		}
		format = function(item){
			var side_text = "Constant"
			var color = undefined
			var macro = o_console.console_macros[$ item]
		
			if not is_undefined(macro)
			{
				color = macro.type
			
				if macro.type == dt_string or macro.type == dt_real
				{
					side_text = "Constant"
					color = dt_real
				}
				else if macro.type == dt_builtinvar or macro.type == dt_variable
				{
					side_text = "Built-in"
					color = dt_builtinvar
				}
				else side_text = string_capitalize(macro.type)
			}
		
			return new Autofill_item(item, item, side_text, color)
		}
		get()
	}

	instance_variables = new Autofill_sublist() with instance_variables
	{
		color = dt_variable
		get = function(){
			list = o_console.variable_scope_list
		}
		format = function(item){
			var color = dt_variable
			var value = variable_instance_get(o_console.variable_scope, item)

			if is_method(value) color = dt_method
			else if is_struct(value) color = dt_instance
		
			return new Autofill_item(item, item, "Variable", color)
		}
		get()
	}

	suggestions = new Autofill_sublist() with suggestions
	{
		show_all_if_blank = true
	
		color = dt_builtinvar
		get = function(){
			list = o_console.suggestions
		}
		format = function(item){
			return new Autofill_item(item, item, "Suggestion")
		}
		get()
	}

	lite_suggestions = new Autofill_sublist() with lite_suggestions
	{
		color = dt_builtinvar
		get = function(){
			list = o_console.lite_suggestions
		}
		format = function(item){
			return new Autofill_item(item, item, "Suggestion")
		}
		get()
	}

	input_log = new Autofill_sublist() with input_log
	{
		show_all_if_blank = true
		color = dt_unknown
		get = function(){
			list = slice(o_console.input_log, , min(3, ds_list_size(o_console.input_log)))
		}
		format = function(item){
			return new Autofill_item(item, item, "Previous")
		}
		get()
	}

	tags = new Autofill_sublist() with tags
	{
		list = variable_struct_get_names(o_console.tags)
		for(var i = 0; i <= array_length(list)-1; i++)
		{
			list[i] = "#"+list[i]
		}
	
		get = function(term){
			show_all_always = string_char_at(term, 1) == "#" 
		}
	
		color = dt_tag
	
		format = function(item){
			return new Autofill_item(item, item, "Instruction")
		}
		get("")
	}

	instances = new Autofill_sublist() with instances
	{
		show_all_always = true
		color = dt_instance
		get = function(term){
			list = array_create(instance_count)
			for (var i = 0; i <= instance_count-1; i++)
			{
				list[i] = string(instance_id[i])
			}
		
			if not string_is_float(term) var i = 0; while object_exists(i)
			{
				if better_instance_exists(i) 
				{
					array_push(list, object_get_name(i))
				}
				i++
			}
		}
		format = function(item){
			if string_is_int(item)
			{
				var name = object_get_name(real(item).object_index)
				return new Autofill_item(item+" ("+name+")", item, "Instance")
			}
			else
			{
				return new Autofill_item(item, item, "Object")
			}
		}
		get()
	}

	list = new Autofill_sublist() with list
	{
		color = dt_real
		get = function(){
			list = []
		}
		format = function(item){
			return new Autofill_item(item, item, "Instruction")
		}
		get()
	}

	chatterbox = new Autofill_sublist() with chatterbox
	{
		color = dt_variable
		get = function(){
			if chatterbox_is_ready 
			{
				list = ds_list_to_array(global.chatterboxVariablesList)
				for(var i = 0; i <= array_length(list)-1; i++)
				{
					list[i] = "$"+list[i]
				}
			}
		}
		format = function(item){
			return new Autofill_item(slice(item, 2), item, "Yarn variable")
		}
		get()
	}
}

autofill_default = new Console_autofill_list() with autofill_default
{
	var af = o_console.autofill
	
	initialize()
	set_multiple([
		af.assets,
		af.macros,
		af.methods,
		af.scope_variables,
		af.lite_suggestions,
		af.suggestions,
		af.input_log,
		af.tags,
		af.instance_variables,
		af.instances,
		af.list,
		af.chatterbox,
	])
}
}}