
methods = new Autofill_sublist() with methods
{
	color = dt_method
	get = function(){
		list = o_console.method_list
	}
	format = function(item){
		item.side_text = "Function"
	}
	get()
}

assets = new Autofill_sublist() with assets
{
	color = dt_asset
	get = function(){
		list = o_console.asset_list
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
	get()
}

macros = new Autofill_sublist() with macros
{
	color = dt_unknown
	get = function(){
		list = o_console.macro_list
	}
	get()
}

instance_variables = new Autofill_sublist() with instance_variables
{
	color = dt_variable
	get = function(){

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
	get()
}

lite_suggestions = new Autofill_sublist() with lite_suggestions
{
	color = dt_unknown
	get = function(){
		list = o_console.lite_suggestions
	}
	get()
}



l = new Console_autofill_list() with l
{
	initialize()
	set_multiple([
		other.assets,
		other.methods,
		other.macros,
		other.scope_variables,
		other.lite_suggestions,
		other.suggestions,
		//other.instance_variables,
	])
}

sc = l.scrollbar
//sc = new Console_scrollbar()
//sc.initialize()
//sc.set_boundaries(sprite_get_width(Sprite9), sprite_get_height(Sprite9), x, y, x+200, y+200)