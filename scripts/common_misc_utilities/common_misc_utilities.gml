
function noscript(){} //method placeholder

function script_execute_ext_builtin(ind, array){

//So, the reason I do this weird thing instead of using script_execute_ext is because for
//reasons beyond human comprehension, gms... doesn't allow you to use arrays with built in
//scripts?? like, normally it would pass the script an argument for each item in the array,
//but with built ins it just passes the array as a single argument... wtf...

//at least theres a 16 argument cap so i dont have to worry about that lol

var a = array_create(16, undefined)
array_copy(a, 0, array, 0, array_length(array))

return ind(
	a[00], a[01], a[02], a[03], 
	a[04], a[05], a[06], a[07], 
	a[08], a[09], a[10], a[11], 
	a[12], a[13], a[14], a[15]
)
}