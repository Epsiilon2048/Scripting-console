
function add_element(element){

if not variable_struct_exists(element, "id")
{
	if not variable_struct_exists(element, "name")
	{
		element.id = instanceof(element)
		if element.id == "struct" element.id = "Element"
	}
	else element.id = element.name
}

element.id = string_replace_all(element.id, " ", "_")

var _id = element.id
var i = 1
while variable_struct_exists(e, _id) _id = element.id+string(i++)
element.id = _id

e[$ element.id] = element
}



function add_console_element(element){ with o_console {

static max_iterations = 50
static get_has_xyltrb = function(el){
	return 
		is_struct(el) and
		variable_struct_exists_get(el, "enabled", true) and
		is_numeric(el[$ "x"]) and
		is_numeric(el[$ "y"]) and
		is_numeric(el[$ "left"]) and
		is_numeric(el[$ "top"]) and
		is_numeric(el[$ "right"]) and
		is_numeric(el[$ "bottom"])
}

if not is_array(element) element = [element]
for(var i = 0; i <= array_length(element)-1; i++)
{
	var el = element[i]
	el.x = 50
	el.y = 50
	el.get_input()
	
	var iter_count = 0
	var going_side = false
	
	el.has_xyltrb = get_has_xyltrb(el)
	
	if el.has_xyltrb for(var j = 0; j <= ds_list_size(elements)-1; j++)
	{	
		var check = elements[| j]
		
		check.has_xyltrb = get_has_xyltrb(check)
		if not check.has_xyltrb continue
		
		if el.bottom > check.top and el.right > check.left
		{
			if going_side
			{
				var xx = check.right+30
				el.left += xx-el.x+1
				el.right += xx-el.x+1
				el.x = xx
				
				if el.x > (gui_width-70)
				{
					el.x = 400
					el.y = 400
					
					show_debug_message("No space found for element; placing arbitrarily")
					break
				}
				
				going_side = false
			}
			else
			{
				var yy = check.bottom+30
				el.top += yy-el.y+1
				el.bottom += yy-el.y+1
				el.y = yy
			
				if el.y > (gui_height-70)
				{
					el.y = 50
					going_side = true
				}
			}
			
			j = 0
		}
		
		iter_count ++
		if iter_count > max_iterations
		{
			var name = variable_struct_exists_get(el, "name", "")
			show_debug_message("Element "+name+" placement exceeded maximum iterations")
			break
		}
	}
	
	add_element(el)
	ds_list_insert(elements, 0, el)
}

element_dock_update()
}}