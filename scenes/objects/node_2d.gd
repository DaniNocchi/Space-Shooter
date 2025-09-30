extends Node2D
func disableOptionsMode():
	controller.optionsEnabled = false
	if get_node("UI/mainButtons/startButton") != null: get_node("UI/mainButtons/startButton").manageFocus(1)
	$"..".queue_free()

func _process(delta):
	if controller.gamepad:
		$"../options/CanvasLayer/SettingsContainer/VBoxContainer/HBoxContainer/back".manageFocus(1)
	else:
		$"../options/CanvasLayer/SettingsContainer/VBoxContainer/HBoxContainer/back".canGrabFocus = true
	print(str($"../options/CanvasLayer/SettingsContainer/VBoxContainer/HBoxContainer/back".canGrabFocus))
