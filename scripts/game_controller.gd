extends Node2D
var Wave = 1
var Points = 0
var MaxMeteor = 15
var meteorAlive = 0
var gamepad = false
var optionsEnabled = false
var version = "2.0.0"


var locale = 1
var soundsVolume = 5
var musicsVolume = 5
var fullscreen = false
var screenShake = true
var gamepadShake = true
var soundBus = AudioServer.get_bus_index("Sounds")
var musicBus = AudioServer.get_bus_index("Music")
var oldSoundsVolume = soundsVolume
var oldMusicsVolume = musicsVolume
var oldFullscreen = fullscreen

func _process(_delta):
	locale = wrap(locale, 1, 4) # 1: English      2: Português       3: Español (4 there cause it excludes the max)
	
	if oldSoundsVolume != soundsVolume:
		AudioServer.set_bus_volume_linear(soundBus, soundsVolume/10.0)
		oldSoundsVolume = soundsVolume
	if oldMusicsVolume != musicsVolume:
		AudioServer.set_bus_volume_linear(musicBus, musicsVolume/10.0)
		oldMusicsVolume = musicsVolume
	if oldFullscreen != fullscreen:
		if fullscreen:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			oldFullscreen = fullscreen
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			oldFullscreen = fullscreen
			
	
	
	
	
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
