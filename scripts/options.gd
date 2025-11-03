extends Node2D
var backgroundFade = true
@onready var backgroundAnimator = $options/CanvasLayer/backgroundAnimator
@onready var everythingAnimator = $options/CanvasLayer/everythingAnimator
func _ready():
	controller.currentMenu = 2
	$options/CanvasLayer/SettingsContainer/VBoxContainer/soundContainer/soundSlider.value = controller.SFXVolume
	$options/CanvasLayer/SettingsContainer/VBoxContainer/musicContainer/musicSlider.value = controller.musicVolume
	$options/CanvasLayer/SettingsContainer/VBoxContainer/fullscreenCenter/FullscreenCheck.button_pressed = controller.fullscreen
	$options/CanvasLayer/SettingsContainer/VBoxContainer/screenShakeCenter/screenShake.button_pressed = controller.screenShake
	$options/CanvasLayer/SettingsContainer/VBoxContainer/controllerShakeCenter/controllerShake.button_pressed = controller.gamepadShake
	await await get_tree().process_frame
	playAnimation(true)

func playAnimation(state): ##state true: in;  state false: out
	if state:
		if backgroundFade: backgroundAnimator.play("in")
		everythingAnimator.play("in")
		controller.optionsEnabled = true
	else:
		if backgroundFade: backgroundAnimator.play("out")
		everythingAnimator.play("out")
		controller.save_game()
		controller.optionsEnabled = false

func _process(delta):
	controller.fullscreen = $options/CanvasLayer/SettingsContainer/VBoxContainer/fullscreenCenter/FullscreenCheck.button_pressed
	controller.SFXVolume = $options/CanvasLayer/SettingsContainer/VBoxContainer/soundContainer/soundSlider.value
	controller.musicVolume = $options/CanvasLayer/SettingsContainer/VBoxContainer/musicContainer/musicSlider.value
	controller.screenShake = $options/CanvasLayer/SettingsContainer/VBoxContainer/screenShakeCenter/screenShake.button_pressed
	controller.gamepadShake = $options/CanvasLayer/SettingsContainer/VBoxContainer/controllerShakeCenter/controllerShake.button_pressed
	
	
	# localization for basically everything related to the settings menu
	match controller.locale:
		1:
			$options/CanvasLayer/TitleBackground/TitleText.text = "Settings"
			$options/CanvasLayer/SettingsContainer/VBoxContainer/Language.text = "Language"
			$options/CanvasLayer/SettingsContainer/VBoxContainer/HBoxContainer/Label.text = "English"
			$options/CanvasLayer/SettingsContainer/VBoxContainer/SoundVolume.text = "Sound Volume"
			$options/CanvasLayer/SettingsContainer/VBoxContainer/MusicVolume.text = "Music Volume"
			$options/CanvasLayer/SettingsContainer/VBoxContainer/Fullscreen.text = "Fullscreen"
			$options/CanvasLayer/SettingsContainer/VBoxContainer/ScreenShake.text = "Screen Shake"
			$options/CanvasLayer/SettingsContainer/VBoxContainer/ControllerShake.text = "Controller Shake"
			$options/CanvasLayer/SettingsContainer/VBoxContainer/backButtonCenter/backButton.text = "Save and Exit"
		2:
			$options/CanvasLayer/TitleBackground/TitleText.text = "Configurações"
			$options/CanvasLayer/SettingsContainer/VBoxContainer/Language.text = "Língua"
			$options/CanvasLayer/SettingsContainer/VBoxContainer/HBoxContainer/Label.text = "Português"
			$options/CanvasLayer/SettingsContainer/VBoxContainer/SoundVolume.text = "Volume do Som"
			$options/CanvasLayer/SettingsContainer/VBoxContainer/MusicVolume.text = "Volume da Música"
			$options/CanvasLayer/SettingsContainer/VBoxContainer/Fullscreen.text = "Tela Cheia"
			$options/CanvasLayer/SettingsContainer/VBoxContainer/ScreenShake.text = "Tremor da Tela"
			$options/CanvasLayer/SettingsContainer/VBoxContainer/ControllerShake.text = "Tremor do Controle"
			$options/CanvasLayer/SettingsContainer/VBoxContainer/backButtonCenter/backButton.text = "Salvar e Sair"
		3:
			$options/CanvasLayer/TitleBackground/TitleText.text = "Ajustes"
			$options/CanvasLayer/SettingsContainer/VBoxContainer/Language.text = "Idioma"
			$options/CanvasLayer/SettingsContainer/VBoxContainer/HBoxContainer/Label.text = "Español"
			$options/CanvasLayer/SettingsContainer/VBoxContainer/SoundVolume.text = "Volumen del Sonido"
			$options/CanvasLayer/SettingsContainer/VBoxContainer/MusicVolume.text = "Volumen de la Música"
			$options/CanvasLayer/SettingsContainer/VBoxContainer/Fullscreen.text = "Pantalla Completa"
			$options/CanvasLayer/SettingsContainer/VBoxContainer/ScreenShake.text = "Vibración de Pantalla"
			$options/CanvasLayer/SettingsContainer/VBoxContainer/ControllerShake.text = "Vibración del Mando"
			$options/CanvasLayer/SettingsContainer/VBoxContainer/backButtonCenter/backButton.text = "Guardar y Salir"
