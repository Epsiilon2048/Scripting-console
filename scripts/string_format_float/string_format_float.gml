// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function string_format_float(float){

var decimal = float - floor(float)
var whole = floor(float)

if decimal == 0 return float
else return stitch(whole,shave("0", real(string_format(decimal, 0, 6))))
}