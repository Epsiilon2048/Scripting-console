
function birdcheck(){

// I will unleash hell upon you if you try to get rid of that god damn bird

if not sprite_exists(asset_get_index("bird_mode_")) 
{
	show_message(exceptionMissingBird)
	game_end()
}
}