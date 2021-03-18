
function noscript(){} //method placeholder

function script_execute_ext_builtin(ind, array){

//So, the reason I do this weird thing instead of using script_execute_ext is because for
//reasons beyond human comprehension, gms... doesn't allow you to use arrays with built in
//scripts?? like, normally it would pass the script an argument for each item in the array,
//but with built ins it just passes the array as a single argument... wtf...

//If for some reason you need to use scripts with more than 25 arguments, feel free to add
//more i guess lol

var a = array_create(25, undefined)
array_copy(a, 0, array, 0, array_length(array))

return ind(
	a[00], a[01], a[02], a[03], a[04], 
	a[05], a[06], a[07], a[08], a[09], 
	a[10], a[11], a[12], a[13], a[14], 
	a[15], a[16], a[17], a[18], a[19], 
	a[20], a[21], a[22], a[23], a[24],
)
}