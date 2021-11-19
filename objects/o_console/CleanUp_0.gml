
ds_destroy(ds_type_list, log)
ds_destroy(ds_type_list, input_log)
ds_destroy(ds_type_list, error_log)
ds_destroy(ds_type_list, command_log)
ds_destroy(ds_type_list, display_list)
ds_destroy(ds_type_list, command_order)
ds_destroy(ds_type_list, macro_list)
ds_destroy(ds_type_list, suggestions)
ds_destroy(ds_type_list, lite_suggestions)
ds_destroy(ds_type_list, method_list)
ds_destroy(ds_type_list, asset_list)
ds_destroy(ds_type_list, elements)

ds_destroy(ds_type_map, commands)

ds_map_destroy(ds_types)

if variable_struct_names_count(COLOR_PICKER) with COLOR_PICKER
{
	if surface_exists(svsquare) surface_free(svsquare)
	if surface_exists(hstrip) surface_free(hstrip)
}

birdcheck()