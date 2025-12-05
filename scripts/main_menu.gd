extends Node2D
var oldOptionsEnabled = controller.optionsEnabled
var locale = 0
func _ready():
	$stars/Stars2.emitting=true
	$UI/mainButtons/startButton.changeFocus()
	$UI/mainButtons/startButton.focus_mode = Control.FOCUS_ALL
	DiscordRPC.app_id = 1084242258229993533 # Application ID
	DiscordRPC.details = "On the Main Menu"
	DiscordRPC.large_image = "logo" 
	DiscordRPC.large_image_text = "Space Shooter"
	DiscordRPC.refresh()
	controller.currentMenu = 1



func _process(delta: float) -> void:
	if oldOptionsEnabled != controller.optionsEnabled:
		oldOptionsEnabled = controller.optionsEnabled
		if !oldOptionsEnabled:
			controller.currentMenu = 1
	$UI/creditsAnimation/CanvasLayer/skippingText.text = tr("MENU_SKIP_TEXT")
	$UI/mainButtons/startButton.text = 					 tr("MENU_START_BUTTON")
	$UI/mainButtons/optionsButton.text = 				 tr("MENU_OPTIONS_BUTTON")
	$UI/mainButtons/creditsButton.text = 				 tr("MENU_CREDITS_BUTTON")
	$UI/mainButtons/quitButton.text = 					 tr("MENU_QUIT_BUTTON")
	$"UI/made by".text = 								 tr("MENU_MADE_BY")
	$UI/version.text = tr("MENU_VERSION").format({"version" = str(controller.version)})
