
Slider1 = new Console_slider()
Slider1.initialize("o_console.sl", 40, 40, 0, 100, .1)
Slider1.width = 400
Slider1.mouse_is_pivot = true

Slider2 = new Console_slider()
Slider2.initialize("o_console.fl", 40, 120, 0, 7, 1)
Slider2.width = 400
Slider2.after_text = "x"

Slider3 = new Console_slider()
Slider3.initialize("o_console.gl", 40, 200, 0, 100, 0)
Slider3.width = 400
Slider3.condensed = true

Slider4 = new Console_slider()
Slider4.initialize("o_console.ml", 40, 280, 0, 100, .1)
Slider4.width = 400
Slider4.mouse_is_pivot = true
Slider4.ease = ease_in_quint