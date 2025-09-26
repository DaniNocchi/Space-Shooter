extends Control
var gamepad = false

func _input(event: InputEvent):
	if event is InputEventKey or event is InputEventMouse:
		gamepad = false

	elif event is InputEventJoypadButton or event is InputEventJoypadMotion:
		gamepad = true
