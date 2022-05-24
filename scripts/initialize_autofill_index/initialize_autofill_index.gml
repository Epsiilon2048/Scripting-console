
function initialize_autofill_index(){ with o_console {

builtin_excluded = [
	//"string",
	//"array",
	//"ds_list",
	//"ds_map",
	"ds_grid_",
	"ds_priority_",
	"ds_queue_",
	"ds_stack_",
	"ads_",
	"layer_",
	"gesture_",
	"keyboard_",
	"font_",
	"part_",			// Particles
	"steam_",	
	"xboxone_",	 
	"xboxlive_",	 
	"switch_",			// Of the nintendo variety
	"psn_",		
	"winphone_",	 
	"win8_",		 
	"vertex_",		 
	"uwp_",		
	"iap_",
	"sprite_",		 
	"skeleton_",	 
	"sequence_",	  
	"physics_",	 
	"path_",		 
	"matchmaking_", 
	"gpu_",
	"file_",
	"draw_",		 
	"display_",	 
	"date_",		 
	"camera_",		 
	"buffer_",		 
	"audio_",		 
	"achievement_", 

	// These are all odd builtin GML functions which aren't allowed in the studio, but are picked up when
	// indexing all the builtin functions. All of them are either useless or have GML counterparts.
	"ds_list_set_",		//ds_list_set_pre & ds_list_set_post 
	"ds_map_set_",		//ds_map_set_pre & ds_map_set_post 
	"ds_grid_set_p",	//ds_grid_set_pre & ds_grid_set_post
	"array_set_",		//array_set_pre, array_set_post, array_set_2D_pre, array_set_2D_post, & array_set_2D
	"@@",
	"yyAsm",
	"YoYo_",
	"$",				//$PRINT, $FAIL, $ERROR
	"sleep",
	"testFailed",
]

macro_list = ds_create(ds_type_list, "macro_list", "", 0, 0)
method_list = ds_create(ds_type_list, "method_list", "", 0, 0)
asset_list = ds_create(ds_type_list, "asset_list", "", 0, 0)
instance_variables = []
scope_variables = []
lite_suggestions = ds_create(ds_type_list, "lite_suggestions", "", 0, 0)
suggestions = ds_create(ds_type_list, "suggestions", "", 0, 0)

ds_list_add(suggestions, "help", "display")

autofill = {}; with autofill {
	macros = -1
	methods = -1
	assets = -1
	instance = -1
	scope = -1
	lite_suggestions = -1
	suggestions = -1
}
}}