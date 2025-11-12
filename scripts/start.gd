extends Node2D
func _ready():
	controller.canShowMouse = false
	await controller.load_game()
func _process(delta):
	if Input.is_anything_pressed():
		gotoMain(false)

func gotoMain(nofadein = true):
	controller.canShowMouse = true
	Transition.change_scene("res://scenes/rooms/mainMenu.tscn", nofadein)
