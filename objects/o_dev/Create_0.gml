
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
		
		if is_struct(value) color = dt_instance
		
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
			}
			else if macro.type == dt_builtinvar
			{
				side_text = "Built-in variable"
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
		
	}
	format = function(item){
		var color = dt_variable
		//var value = variable_instance_get(o_console.object, item)
		//
		//if is_struct(value) color = dt_instance
		
		return new Autofill_item(item, item, "Variable", color)
	}
	get()
}

suggestions = new Autofill_sublist() with suggestions
{
	show_all_if_blank = true
	
	color = dt_unknown
	get = function(){
		list = o_console.suggestions
	}
	format = function(item){
		return new Autofill_item(item, item, "Suggestion", dt_builtinvar)
	}
	get()
}

lite_suggestions = new Autofill_sublist() with lite_suggestions
{
	color = dt_unknown
	get = function(){
		list = o_console.lite_suggestions
	}
	format = function(item){
		return new Autofill_item(item, item, "Suggestion", dt_builtinvar)
	}
	get()
}

input_log = new Autofill_sublist() with input_log
{
	color = dt_unknown
	get = function(){
		list = o_console.input_log
	}
	format = function(item){
		return new Autofill_item(item, item, "Previous", dt_unknown)
	}
	get()
}



l = new Console_autofill_list() with l
{
	initialize()
	set_multiple([
		other.input_log,
		other.suggestions,
		other.lite_suggestions,
		other.scope_variables,
		other.macros,
		other.methods,
		other.assets,
		//other.instance_variables,
	])
}

sc = l.scrollbar
//sc = new Console_scrollbar()
//sc.initialize()
//sc.set_boundaries(sprite_get_width(Sprite9), sprite_get_height(Sprite9), x, y, x+200, y+200)