
Slider = {}; with Slider {

	x = 50
	y = 50

	width = 200
	
	value		 = 0
	value_min	 = 0
	value_max	 = 100
	value_step	 = 0.1
	value_places = float_places(value_step)
	
	variable = "o_console.sl"
	
	mouse_on = false
}

Slider2 = {}; with Slider2 {

	x = 50
	y = 150

	width = 200
	
	value		 = 0
	value_min	 = 30
	value_max	 = 700
	value_step	 = 0.1
	value_places = float_places(value_step)
	
	variable = "o_gui.Slider.width"
	
	mouse_on = false
}