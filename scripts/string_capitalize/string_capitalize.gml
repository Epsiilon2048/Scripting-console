function string_capitalize(str){

if not is_string(str) return string(str)
return string_upper(string_char_at(str, 1))+string_delete(str, 1, 1)
}