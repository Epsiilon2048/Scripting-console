
#region Window scale

global.win_sc = 3
previous_scale = global.win_sc

window_set_size(CAM_W*global.win_sc, CAM_H*global.win_sc)

var win_posx = 100
var win_posy = 100

window_set_position(win_posx, win_posy)

#endregion

game_start_instances()