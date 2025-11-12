extends "res://scripts/buttonScripts/button_general.gd"
func action():
	var optionsMenu = load("res://scenes/objects/options.tscn").instantiate()
	if get_tree().get_current_scene().get_name() == "game":
		optionsMenu.backgroundFade = false
	optionsMenu.position = global_position
	get_node("..").add_child(optionsMenu)
	controller.optionsEnabled = true
