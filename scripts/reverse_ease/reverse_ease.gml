// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function reverse_ease(value, ease){

var places = float_places(value)
var amount = power(10, places)

for(var i = 0; i <= amount; i++){
	if ease((1/amount)*i) == value return (1/amount)*i
}

return -1
}