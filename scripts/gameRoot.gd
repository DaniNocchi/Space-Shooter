extends Node2D
var oldWave = 1
var oldOptionsEnabled = controller.optionsEnabled
@onready var resumeButton = $screenEffectsLayer/pauseFade/pauseController/Control/resumeButton
@onready var optionsButton =$screenEffectsLayer/pauseFade/pauseController/Control/optionsButton
@onready var quitButton = $screenEffectsLayer/pauseFade/pauseController/Control/quitButton
@onready var pausedText = $screenEffectsLayer/pauseFade/pauseController/textContainer/pauseText
func _ready() -> void:
	$pausable/stars/Stars2.emitting=true
	if !controller.gamepad: Input.mouse_mode = Input.MOUSE_MODE_CONFINED
	pwrupController.newGame()
	controller.currentMenu = 0


	

	DiscordRPC.details = "Playing a Match"
	DiscordRPC.state = "Wave "+str(controller.Wave)
	DiscordRPC.large_image = "logo" # Image key from "Art Assets"
	DiscordRPC.large_image_text = "Space Shooter"
	DiscordRPC.start_timestamp = int(Time.get_unix_time_from_system())
	DiscordRPC.refresh()
func _process(delta):
	if oldOptionsEnabled != controller.optionsEnabled:
		oldOptionsEnabled = controller.optionsEnabled
		if !oldOptionsEnabled:
			if $screenEffectsLayer/pauseFade/pauseController.paused:
				controller.currentMenu = 4
			else:
				controller.currentMenu = 0
	if controller.Wave!=oldWave:
		oldWave = controller.Wave
		DiscordRPC.refresh() 
	match controller.locale:
		1:
			$pausable/PointsText.text = str(controller.Points)+" Points"
			resumeButton.text = "Resume"
			optionsButton.text = "Options"
			quitButton.text = "Quit"
			$pausable/Camera2D/NinePatchRect/waveText.text = "Wave "+str(controller.Wave)
			pausedText.text = "--PAUSED--"
		2:
			$pausable/PointsText.text = str(controller.Points)+" Pontos"
			resumeButton.text = "Continuar"
			optionsButton.text = "Configurações"
			quitButton.text = "Sair"
			$pausable/Camera2D/NinePatchRect/waveText.text = "Onda "+str(controller.Wave)
			pausedText.text = "--PAUSADO--"
		3:
			$pausable/PointsText.text = str(controller.Points)+" Puntos"
			resumeButton.text = "Reanudar"
			optionsButton.text = "Ajustes"
			quitButton.text = "Salir"
			$pausable/Camera2D/NinePatchRect/waveText.text = "Oleada "+str(controller.Wave)
			pausedText.text = "--PAUSADO--"
