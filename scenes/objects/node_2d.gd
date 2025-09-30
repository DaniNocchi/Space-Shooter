extends Node2D
var focusFix = false
func disableOptionsMode():
	controller.optionsEnabled = false
	$"..".queue_free()
func _ready():
	controller.optionsEnabled = true
func _process(delta):
	if controller.gamepad:
		if !focusFix:
			$"../options/CanvasLayer/SettingsContainer/VBoxContainer/HBoxContainer/back".grab_focus()
			focusFix=true
	else:
		focusFix = false
		$"../options/CanvasLayer/SettingsContainer/VBoxContainer/HBoxContainer/back".canGrabFocus = true
