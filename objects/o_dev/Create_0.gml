
sw = new Console_scrollbar()
sw.initialize()
sw.set_boundaries(sprite_get_width(Sprite9), sprite_get_height(Sprite9), x, y, x+200, y+200)

anim = 0
inc = .4
overshoot = .2
animating = false
surf = -1

sc = 1