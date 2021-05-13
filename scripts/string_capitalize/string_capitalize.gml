function string_capitalize(str){

return string_upper(string_char_at(str, 1))+string_delete(str, 1, 1)
}