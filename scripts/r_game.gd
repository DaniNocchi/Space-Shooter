extends Node2D
var oldWave = 1
func _ready() -> void:
	$pausable/stars/Stars2.emitting=true
	if !controller.gamepad: Input.mouse_mode = Input.MOUSE_MODE_CONFINED
	controller.MaxMeteor = 15
	controller.meteorAlive = 0
	controller.Points = 0
	controller.Wave = 1
	
	
	DiscordRPC.app_id = 1084242258229993533 # Application ID
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
