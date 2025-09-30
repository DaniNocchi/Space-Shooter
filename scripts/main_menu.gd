extends Node2D
func _ready():
	$stars/Stars2.emitting=true
	$UI/mainButtons/startButton.manageFocus(1)
	$UI/mainButtons/startButton.focus_mode = Control.FOCUS_ALL
	DiscordRPC.app_id = 1084242258229993533 # Application ID
	DiscordRPC.details = "On the Main Menu"
	DiscordRPC.large_image = "logo" 
	DiscordRPC.large_image_text = "Space Shooter"
	DiscordRPC.refresh()
	
