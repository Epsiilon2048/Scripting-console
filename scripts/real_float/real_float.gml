
function real_float(str){

if string_pos(".", str) and string_pop(str) != "."
{
	var split = string_split(".", str)

	if split[0] == "-" or split[0] == "" split[0] = "0"

	return real(split[0]) + real(split[1])/power(10, string_length(split[1]))*sign(real(str))
}
else return real(str)
}