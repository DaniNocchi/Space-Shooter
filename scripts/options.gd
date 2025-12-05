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
	$options/CanvasLayer/TitleBackground/TitleText.text = tr("SET_TITLE")
	$options/CanvasLayer/SettingsContainer/VBoxContainer/Language.text = tr("SET_LANG_TITLE")
	$options/CanvasLayer/SettingsContainer/VBoxContainer/HBoxContainer/Label.text = tr("SET_LANG_LABEL")
	$options/CanvasLayer/SettingsContainer/VBoxContainer/SoundVolume.text = tr("SET_SOUNDS_VOLUME")
	$options/CanvasLayer/SettingsContainer/VBoxContainer/MusicVolume.text = tr("SET_MUSIC_VOLUME")
	$options/CanvasLayer/SettingsContainer/VBoxContainer/Fullscreen.text = tr("SET_FULLSCREEN")
	$options/CanvasLayer/SettingsContainer/VBoxContainer/ScreenShake.text = tr("SET_SCREEN_SHAKE")
	$options/CanvasLayer/SettingsContainer/VBoxContainer/ControllerShake.text = tr("SET_CONTROLLER_SHAKE")
	$options/CanvasLayer/SettingsContainer/VBoxContainer/backButtonCenter/backButton.text = tr("SET_SAVE_AND_EXIT")
