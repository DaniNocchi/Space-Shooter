extends Node2D
func _ready():
	$stars/Stars2.emitting=true
	if !controller.gamepad: Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else: $Control/startButton.manageFocus(1)
	DiscordRPC.app_id = 1084242258229993533 # Application ID
	DiscordRPC.details = "On the Main Menu"
	DiscordRPC.large_image = "logo" 
	DiscordRPC.large_image_text = "Space Shooter"
	DiscordRPC.refresh()
	
