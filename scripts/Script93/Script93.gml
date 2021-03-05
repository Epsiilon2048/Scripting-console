// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function Ctx_menu() constructor{

set = function(items){
	
	self.items = items
	if not is_array(self.items) self.items = [self.items]
	
	self.items_count = array_length(items)
	self.sep_count = 0
	
	self.longest_item = 0
	
	for(var i = 0; i <= self.items_count-1; i++)
	{
		if is_struct(self.items[i].str) and string_length(self.items[i].str) > self.longest_item
		{
			self.longest_item = string_length(self.items[i].str)
		}
		else 
		{
			self.items_count --
			if self.items[i] == SEPARATOR self.sep_count ++
		}
	}
}

set_item = function(item, index){
	
	if index == self.items_count self.items_count ++
	if string_length(item.str) > self.longest_item self.longest_item = string_length(item.str)
	
	self.items[index] = item
}
}