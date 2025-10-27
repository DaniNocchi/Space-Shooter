extends "res://scripts/buttonScripts/button_general.gd"
func action():
	controller.newPersonalRecord()
	Transition.change_scene("res://scenes/rooms/mainMenu.tscn")
