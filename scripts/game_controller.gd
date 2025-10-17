extends Node2D
var Wave = 1
var Points = 0
var MaxMeteor = 15
var meteorAlive = 0
var gamepad = false
var optionsEnabled = false
var version = "2.0.0"
var personalRecord = 0
var oldPersonalRecord = 0
var powerupsGotten = 0
var bulletsShot = 0
var bulletsMissed = 0
var meteorKilled = 0
var doublePoints = false
var canShowMouse = true
var fastShots = false
var existingPowerup = []

var locale : int = 1           # 1: English, 2: Portuguese, 3: Spanish
var maxLocaleOptions = 3       #Sets how much languages are in the game
var SFXVolume = 5
var musicVolume = 5
var fullscreen = false                              #Enables/Disables the fullscreen
var screenShake = true                              #Enables/Disables the screen shake
var gamepadShake = true                             #Enables/Disables the gamepad vibration
var soundBus = AudioServer.get_bus_index("Sounds")  #The category "Sounds" (Used by all SFX in the game)
var musicBus = AudioServer.get_bus_index("Music")   #The category "Music" (Used by all musics in the game)
var oldSFXVolume = SFXVolume                        #Used to check if the sound volume changed (Performance Reasons)
var oldMusicVolume = musicVolume                    #Used to cehck if the music volume changed (Performance Reasons)
var oldFullscreen = fullscreen                      #Used to check if the fullscreen changed (Performance Reasons)

func newPersonalRecord():
	if Points > personalRecord:
		oldPersonalRecord = personalRecord
		personalRecord = Points
		save_game()
	else: 
		oldPersonalRecord = personalRecord
func _process(_delta):
	locale = wrap(locale, 1, maxLocaleOptions+1) #limits the languages and wrap it (if i pass the last language, it goes back to the first)
	
	
	#checks if i changed the fullscreen or the volumes (for performance reasons)
	if oldSFXVolume != SFXVolume:
		AudioServer.set_bus_volume_linear(soundBus, SFXVolume/10.0)
		oldSFXVolume = SFXVolume
	if oldMusicVolume != musicVolume:
		AudioServer.set_bus_volume_linear(musicBus, musicVolume/10.0)
		oldMusicVolume = musicVolume
	if oldFullscreen != fullscreen:
		if fullscreen:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			oldFullscreen = fullscreen
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			oldFullscreen = fullscreen
	
	
	
	
	Wave = floori((Points/25.0)+1.0) #basically, +25 points equals to +1 waves.
	MaxMeteor = 15*Wave 
	#basically, +1 waves means +15 max meteors that can spawn. 
	#I prob have to lower it cause 30 meteors when you have only 
	#25 points is a lot of meteors, but yeah, soon ill check if 
	#this is needed.
	
	
	if gamepad or !canShowMouse: Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	else:                        Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
func _input(event: InputEvent): #Set gamepad as true or false
	if event is InputEventKey or event is InputEventMouse:
		gamepad = false

	if event is InputEventJoypadButton or event is InputEventJoypadMotion:
		gamepad = true

func save_game():
	var save_dict = {
		"SFXVolume"      : SFXVolume,
		"musicVolume"    : musicVolume,
		"fullscreen"     : fullscreen,
		"screenShake"    : screenShake,
		"gamepadShake"   : gamepadShake,
		"locale"         : locale,
		"personalRecord" : personalRecord
 	}
	
	var save_file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	var saveString = JSON.stringify(save_dict)
	save_file.store_line(saveString)
func load_game():
	if not FileAccess.file_exists("user://savegame.save"):
		save_game()
	
	var json = JSON.new()
	var save_file = FileAccess.open("user://savegame.save", FileAccess.READ)
	var file_content = save_file.get_as_text()
	
	if json.parse(file_content) == OK:
		var save_dict = json.get_data()
		
		SFXVolume      = save_dict.get("SFXVolume",      SFXVolume)
		musicVolume    = save_dict.get("musicVolume",    musicVolume)
		fullscreen     = save_dict.get("fullscreen",     fullscreen)
		screenShake    = save_dict.get("screenShake",    screenShake)
		gamepadShake   = save_dict.get("gamepadShake",   gamepadShake)
		locale         = save_dict.get("locale",         locale)
		personalRecord = save_dict.get("personalRecord", personalRecord)
