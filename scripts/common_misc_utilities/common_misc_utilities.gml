
function noscript(){} //method placeholder

function script_execute_ext_builtin(ind, array){

//So, the reason I do this weird thing instead of using script_execute_ext is because for
//reasons beyond human comprehension, gms... doesn't allow you to use arrays with built in
//scripts?? like, normally it would pass the script an argument for each item in the array,
//but with built ins it just passes the array as a single argument... wtf...

if ind >= 100000 return script_execute_ext(ind, array)

var f = ind
var a = array

switch array_length(a)
{
case 16: return f(a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7], a[8], a[9], a[10], a[11], a[12], a[13], a[14], a[15]	); break
case 15: return f(a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7], a[8], a[9], a[10], a[11], a[12], a[13], a[14]			); break
case 14: return f(a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7], a[8], a[9], a[10], a[11], a[12], a[13]				); break
case 13: return f(a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7], a[8], a[9], a[10], a[11], a[12]						); break
case 12: return f(a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7], a[8], a[9], a[10], a[11]								); break
case 11: return f(a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7], a[8], a[9], a[10]										); break
case 10: return f(a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7], a[8], a[9]											); break
case 9:  return f(a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7], a[8]													); break
case 8:  return f(a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7]														); break
case 7:  return f(a[0], a[1], a[2], a[3], a[4], a[5], a[6]																); break
case 6:  return f(a[0], a[1], a[2], a[3], a[4], a[5]																	); break
case 5:  return f(a[0], a[1], a[2], a[3], a[4]																			); break
case 4:  return f(a[0], a[1], a[2], a[3]																				); break
case 3:  return f(a[0], a[1], a[2]																						); break
case 2:  return f(a[0], a[1]																							); break
case 1:  return f(a[0]																									); break
case 0:  return f(																										); break
}
}