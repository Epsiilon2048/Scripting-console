function get_update_turn(update_id){
with o_console return ((step mod update_steps) == update_id mod update_steps)
}