function gmcl_build_error(location, error, segment){

var _error
var _segment

if is_struct(error)
{
	_error = string(error.error)
	_segment = "from \""+string(error.plain)+"\": "
}
else
{
	_error = string(error)
	_segment = is_undefined(segment) ? "" : "from \""+string(segment)+"\": "
}

return "["+string_upper(string(location))+" ERROR] "+_segment+_error
}