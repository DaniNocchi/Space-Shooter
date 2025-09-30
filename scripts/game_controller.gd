extends Node2D
var Wave = 1
var Points = 0
var MaxMeteor = 15
var meteorAlive = 0
var gamepad = false
var optionsEnabled = false

func _process(_delta):
	@warning_ignore("integer_division") #remove that fking stupid error, i already know that 
	Wave = (Points/25)+1				#bro, thanks for warning something i made on porpouse
	MaxMeteor = 15*Wave
	if gamepad:
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
		
func _input(event: InputEvent):
	if event is InputEventKey or event is InputEventMouse:
		gamepad = false

	if event is InputEventJoypadButton or event is InputEventJoypadMotion:
		gamepad = true
