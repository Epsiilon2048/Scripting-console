function new_color_scheme(){ with o_console {

static name = "custom_cs"
var i = 1

while variable_struct_exists(color_schemes, name+string(i)) i++

color_schemes[$ name+string(i)] = struct_copy( color_schemes[$ cs_template] )
color_schemes[$ name+string(i)].__builtin__ = false

return color_scheme_settings()
}}