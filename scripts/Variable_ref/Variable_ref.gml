
function Variable_ref() constructor{

	set = function(variable){
	
		self.scope = variable_string_get_scope(variable)
		self.variable = variable_string_get_last(variable)
	}
	
	get = function(){

		return is_undefined(scope) ? undefined : variable_instance_get(scope, variable)
	}
	
	exists = function(){
		
		return	(is_struct(scope) and variable_struct_exists(scope, variable)) or
				(is_real(scope) and instance_exists(scope) and variable_instance_exists(scope, variable))
	}
}