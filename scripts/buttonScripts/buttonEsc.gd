extends "res://scripts/buttonScripts/button_general.gd"
func action():
	controller.save_game()
	Input.action_press("back")
	Input.action_release("back")
