
editing = false

tile_placing = SOLID

tile_cursor = true
grid = false
grid_alpha = .04

var sep = 88

mode = -1

button_id = 0

context_string = ""
context_x = 0
context_y = 0
hovering = 0
nothovering = 0
clicked = false


buttons[0] = new Editor_button()
buttons[1] = new Editor_button()
buttons[2] = new Editor_button()
buttons[3] = new Editor_button()
buttons[4] = new Editor_button()
buttons[5] = new Editor_button()
buttons[6] = new Editor_button()
buttons[7] = new Editor_button()
buttons[8] = new Editor_button()

buttons[0].initialize({icon: s_editor_icon_solid,		x:2282/5, y:64+sep*1/5, context:"Solid"			})
buttons[1].initialize({icon: s_editor_icon_platform,	x:2282/5, y:64+sep*2/5, context:"Platform"		})
buttons[2].initialize({icon: s_editor_icon_death,		x:2282/5, y:64+sep*3/5, context:"Player death"	})
buttons[3].initialize({icon: s_editor_icon_spawn,		x:2282/5, y:64+sep*4/5, context:"Player spawn"	})
buttons[4].initialize({icon: s_editor_icon_goal,		x:2282/5, y:64+sep*5/5, context:"Level goal"	})
buttons[5].initialize({icon: s_editor_icon_enemy,		x:2282/5, y:64+sep*6/5, context:"Enemy"			})
buttons[6].initialize({icon: s_editor_icon_bucket,		x:2282/5, y:64+sep*7/5, context:"Bucket tool"	})
buttons[7].initialize({icon: s_editor_icon_selection,	x:2282/5, y:64+sep*8/5, context:"Selection tool"})
buttons[8].initialize({icon: s_editor_icon_decotile,	x:2282/5, y:64+sep*9/5, context:"Decorate tiles"})

instance_create_layer(x, y, "Grid", o_level_editor_companion)