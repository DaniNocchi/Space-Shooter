extends Node2D
func _process(delta):
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
func gotoMain():
	Transition.change_scene("res://scenes/rooms/mainMenu.tscn", true)
