extends "res://scripts/buttonScripts/buttonGeneral.gd"
func disableOptionsMode():
	controller.optionsEnabled = false

func _process(delta):
	if controller.gamepad:
	$options/CanvasLayer/SettingsContainer/VBoxContainer/HBoxContainer/back
