extends Node2D
var oldWave = 1
func _ready() -> void:
	$pausable/stars/Stars2.emitting=true
	if !controller.gamepad: Input.mouse_mode = Input.MOUSE_MODE_CONFINED
	controller.MaxMeteor = 15
	controller.meteorAlive = 0
	controller.Points = 0
	controller.Wave = 1
	controller.bulletsMissed = 0
	controller.bulletsShot = 0
	controller.powerupsGotten = 0
	controller.meteorKilled = 0
	controller.doublePoints = false
	controller.fastShots = false
	controller.usingPowerup.clear()
	

	DiscordRPC.details = "Playing a Match"
	DiscordRPC.state = "Wave "+str(controller.Wave)
	DiscordRPC.large_image = "logo" # Image key from "Art Assets"
	DiscordRPC.large_image_text = "Space Shooter"
	DiscordRPC.start_timestamp = int(Time.get_unix_time_from_system())
	DiscordRPC.refresh()
func _process(delta):
	if controller.Wave!=oldWave:
		oldWave = controller.Wave
		DiscordRPC.refresh() 
	match controller.locale:
		1:
			$pausable/PointsText.text = str(controller.Points)+" Points"
			$pauseController/pauseLayer/Control/resumeButton.text = "Resume"
			$pauseController/pauseLayer/Control/quitButton.text = "Quit"
			$pausable/Camera2D/NinePatchRect/waveText.text = "Wave "+str(controller.Wave)
			$pauseController/pauseLayer/textContainer/pauseText.text = "--PAUSED--"
		2:
			$pausable/PointsText.text = str(controller.Points)+" Pontos"
			$pauseController/pauseLayer/Control/resumeButton.text = "Continuar"
			$pauseController/pauseLayer/Control/quitButton.text = "Sair"
			$pausable/Camera2D/NinePatchRect/waveText.text = "Onda "+str(controller.Wave)
			$pauseController/pauseLayer/textContainer/pauseText.text = "--PAUSADO--"
		3:
			$pausable/PointsText.text = str(controller.Points)+" Puntos"
			$pauseController/pauseLayer/Control/resumeButton.text = "Reanudar"
			$pauseController/pauseLayer/Control/quitButton.text = "Salir"
			$pausable/Camera2D/NinePatchRect/waveText.text = "Oleada "+str(controller.Wave)
			$pauseController/pauseLayer/textContainer/pauseText.text = "--PAUSADO--"
