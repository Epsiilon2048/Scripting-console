// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function first_is_digit(str){

var char = string_char_at(str, 1)

if char == "-" char = string_char_at(str, 2)

return ( string_digits(char) == char )
}