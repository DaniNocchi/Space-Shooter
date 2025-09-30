extends Node2D
func _process(delta):
	if controller.optionsEnabled:
		$"../mainButtons/startButton".disabled = true
		$"../mainButtons/optionsButton".disabled = true
		$"../mainButtons/creditsButton".disabled = true
		$"../mainButtons/quitButton".disabled = true
	else: 
		$"../mainButtons/startButton".disabled = false
		$"../mainButtons/optionsButton".disabled = false
		$"../mainButtons/creditsButton".disabled = false
		$"../mainButtons/quitButton".disabled = false
	print(str(get_viewport().gui_get_focus_owner()))
