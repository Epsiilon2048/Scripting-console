
sw = new Console_scrollbar()
sw.initialize()
sw.set_boundaries(sprite_get_width(Sprite9), sprite_get_height(Sprite9), x, y, x+200, y+200)

anim = 0
inc = .48
overshoot = .13
overshot = false
overshoot_dampner = .7
height_dampner = .6
animating = false
surf = -1

sc = 1

add_scrubber("o_dev.sc", .01)
add_scrubber("o_dev.inc", .01)
add_scrubber("o_dev.overshoot", .01)
add_scrubber("o_dev.height_dampner", .01)
add_scrubber("o_dev.overshoot_dampner", .01)