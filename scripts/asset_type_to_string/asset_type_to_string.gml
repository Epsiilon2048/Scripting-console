function asset_type_to_string(type){

switch type
{
default:					return "unknown"
case asset_object:			return "object"
case asset_script:			return "script"
case asset_animationcurve:	return "animcurve"
case asset_font:			return "font"
case asset_path:			return "path"
case asset_room:			return "room"
case asset_sequence:		return "sequence"
case asset_shader:			return "shader"
case asset_sound:			return "sound"
case asset_sprite:			return "sprite"
case asset_tiles:			return "tiles"
case asset_timeline:		return "timeline"
}
}