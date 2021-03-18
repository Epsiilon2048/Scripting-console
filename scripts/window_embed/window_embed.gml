
function window_embed(text){ with o_console {

Window.set(text)
Window.enabled = true
Window.show = true

window_reset_pos()

return "Set window text"
}}